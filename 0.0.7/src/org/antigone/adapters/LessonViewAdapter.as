package org.antigone.adapters
{
	import flash.events.Event;
	
	import mx.binding.utils.ChangeWatcher;
	import mx.collections.ArrayCollection;
	
	import org.antigone.vos.*;
	
	[Bindable]
	public class LessonViewAdapter extends Adapter
	{
		[Bindable("representedObjectChanged")]
		/** Typped getter for representedObject. */
		public function get representedLesson():Lesson { return representedObject as Lesson; }
		
		/** Content items for the lesson (Courses, Exercises, etc) sorted by lessonIndex */
		public var contentAdapters:ArrayCollection = new ArrayCollection();
		
		/** The index of the currently selected content */
		public var selectedContentIndex:uint;
		
		[Bindable(event="selectedContentChanged")]
		/** A direct reference to the currently selected content (read-only) */
		public function get selectedContent():ContentAdapter
		{
			return contentAdapters[selectedContentIndex];
		}
		
		/** Constructor */
		public function LessonViewAdapter(representedObject:Lesson=null):void
		{
			super(representedObject);
			
			// Monitor changes that invalidate the "selectedContent" value
			ChangeWatcher.watch(
				this,
				"selectedContentIndex",
				function():void { dispatchEvent(new Event("selectedContentChanged"))}
			);	
		}
		
		/** Called when the representedObject changes ; update represented data. */
		override protected function PopulateData(object:*):void
		{
			var adapters:Array = new Array;
			
			// Replace Content objects in the array by the matching adapters
			for each(var content:LessonContent in representedLesson.contents) {
				adapters.push(ContentAdapter.InitFromContent(content));
			}
			
			// Inject the sorted array into the Adapter property
			contentAdapters.source = adapters;
		}
	}
}