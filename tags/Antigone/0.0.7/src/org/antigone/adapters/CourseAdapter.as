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
	public class CourseAdapter extends ContentAdapter
	{
		[Bindable("representedObjectChanged")]
		/** Typped getter for representedObject. */
		public function get representedCourse():Course { return representedObject as Course; }
		
		/** The directory in which lessons are stored.
		 * (needed to resolve the audioFilePath). */
		public var lessonsPath:File;
		
		/** The resolved path to the audioFile, as a file URL. */
		[Bindable(event="audioFileURLChanged")]
		public function get audioFileURL():String
		{
			var audioFile:String = this.representedCourse.audioFile;
			if (audioFile == null || audioFile == "")
				return "";
			
			return "file://" + lessonsPath.resolvePath(audioFile).nativePath;
		}
		
		[Bindable(event="hasAudioChanged")]
		/** Weather the lesson has an existing audio file associated */
		public function get hasAudio():Boolean
		{
			var audioFile:String = this.representedCourse.audioFile;
			if (audioFile == null || audioFile == "")
				return false;
			
			return lessonsPath.resolvePath(audioFile).exists;
		}
		
		/** Constructor. */
		public function CourseAdapter(representedObject:Course=null):void
		{
			super(representedObject);			
		}
		
		/** Called when the representedObject changes ; update represented data. */
		override protected function PopulateData(object:*):void
		{			
			// Monitor changes that invalidates the "audioFileURL" value
			ChangeWatcher.watch(
				this.representedCourse,
				"audioFile",
				function():void { dispatchEvent(new Event("audioFileURLChanged")); }
			);
			ChangeWatcher.watch(
				this.representedCourse,
				"lessonsPath",
				function():void { dispatchEvent(new Event("audioFileURLChanged")); }
			);
			
			// Monitor changes that invalidates the "hasAudio" value
			ChangeWatcher.watch(
				this.representedCourse,
				"audioFile",
				function():void { dispatchEvent(new Event("hasAudioChanged")); }
			);
			
			// Inform that we just created a new instance of the CourseAdapter
			Application.application.dispatchEvent(new CourseAdapterEvent(CourseAdapterEvent.COURSE_ADAPTER_CREATED, this));
		}
	}
}