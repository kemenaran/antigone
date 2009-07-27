package org.antigone.adapters
{
	import flash.events.Event;
	import flash.filesystem.File;
	import flash.utils.*;
	
	import mx.binding.utils.ChangeWatcher;
	import mx.core.Application;
	
	import org.antigone.events.CourseAdapterEvent;
	import org.antigone.vos.Course;

	/** Adapter class for Courses */
	[Bindable]
	public class CourseAdapter extends Course
	{
		/** The directory in which lessons are stored.
		 * (needed to resolve the audioFilePath)
		 * By default, this is set to the Application Directory. */
		public var lessonsPath:File;
		
		/** The resolved path to the audioFile, as a file URL. */
		[Bindable(event="audioFileURLChanged")]
		public function get audioFileURL():String
		{
			if (this.audioFile == null || this.audioFile == "")
				return "";
			
			return "file://" + lessonsPath.resolvePath(this.audioFile).nativePath;
		}
		
		[Bindable(event="hasAudioChanged")]
		/** Weather the lesson has an existing audio file associated */
		public function get hasAudio():Boolean
		{
			if (this.audioFile == null || this.audioFile == "")
				return false;
			
			return lessonsPath.resolvePath(this.audioFile).exists;
		}
		
		/** Constructor */
		public function CourseAdapter():void
		{
			this.lessonsPath = File.applicationDirectory;
			
			// Monitor changes that invalidates the "audioFileURL" value
			ChangeWatcher.watch(
				this,
				"audioFile",
				function():void { dispatchEvent(new Event("audioFileURLChanged")); }
			);
			ChangeWatcher.watch(
				this,
				"lessonsPath",
				function():void { dispatchEvent(new Event("audioFileURLChanged")); }
			);
			
			// Monitor changes that invalidates the "hasAudio" value
			ChangeWatcher.watch(
				this,
				"audioFile",
				function():void { dispatchEvent(new Event("hasAudioChanged")); }
			);
			
			// Inform that we just created a new instance of the CourseAdapter
			Application.application.dispatchEvent(new CourseAdapterEvent(CourseAdapterEvent.COURSE_ADAPTER_CREATED, this));
		}
		
		/** Create a new CourseAdapter, populated with data from an existing Course */
		public static function InitFromCourse(course:Course):CourseAdapter
		{
			// Create a new CourseAdapter
			var adapter:CourseAdapter = new CourseAdapter();
			
			// Describe User type
			var courseType:XML = describeType(Course);
			
			// Populate the inherited properties of the adapter from the course
			for each(var property:XML in courseType.factory.accessor) {
				adapter[property.@name] = course[property.@name];
			}
						
			return adapter;
		}
	}
}