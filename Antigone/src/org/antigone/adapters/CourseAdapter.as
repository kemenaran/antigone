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
	public class CourseAdapter extends Course
	{
		/** The directory in which lessons are stored.
		 * (needed to resolve the audioFilePath)
		 * By default, this is set to the Application Directory. */
		protected var _lessonsPath:File;
		
		public function get lessonsPath():File { return _lessonsPath; }
		
		public function set lessonsPath(newLessonsPath:File):void
		{
			this._lessonsPath = newLessonsPath;
			dispatchEvent(new Event("audioFileURLChanged"));
		}
		
		/** The resolved path to the audioFile, as a file URL. */
		[Bindable(event="audioFileURLChanged")]
		public function get audioFileURL():String
		{
			return "file://" + lessonsPath.resolvePath(this.audioFile).nativePath;
		}
		
		/** Constructor */
		public function CourseAdapter():void
		{
			this._lessonsPath = File.applicationDirectory;
			ChangeWatcher.watch(
				this,
				"audioFile",
				function():void { dispatchEvent(new Event("audioFileURLChanged")); }
			);
			
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