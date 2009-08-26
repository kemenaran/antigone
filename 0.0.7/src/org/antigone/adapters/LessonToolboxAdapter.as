package org.antigone.adapters
{
	import mx.binding.utils.ChangeWatcher;
	import mx.collections.ArrayCollection;
	import mx.events.PropertyChangeEvent;
	
	import org.antigone.vos.Lesson;
	import org.antigone.vos.LessonContent;
	
	/** Adapter for the LessonToolbox data. */
	public class LessonToolboxAdapter extends Adapter
	{
		[Bindable("representedObjectChanged")]
		/** Typped getter for representedObject. */
		public function get representedLesson():Lesson { return representedObject as Lesson; }
		
		[Bindable]
		/** Represents the title and enabled status of each content item in the lesson. */
		public var lessonContentSummary:ArrayCollection = new ArrayCollection();
		
		[Bindable]
		/** The index of the selected content item in the current lesson. */
		public var selectedContentIndex:uint;
		
		/** Called when the representedObject changes ; update represented data. */
		protected override function PopulateData(object:*):void
		{
			var lesson:Lesson = representedObject as Lesson;
			var size:Number = lesson.contents.length;
			var isItemEnabled:Boolean;
			var contentItem:LessonContent;
			var summary:Object;
			
			// Populate the lessonContentSummary
			lessonContentSummary.removeAll();
			for (var i:int = 0; i < size; i++) {
				// Prepare data
				contentItem = lesson.contents[i];
				isItemEnabled = (i > 0) ? LessonContent(lesson.contents[i-1]).isSucceeded : true;
				
				// Add a new summary
				summary = {label:contentItem.title, enabled:isItemEnabled};
				lessonContentSummary.addItem(summary);
				
				// Monitor changes to "isSucceeded", to update the "enabled" field if needed
				ChangeWatcher.watch(contentItem, "isSucceeded", RefreshEnabledStatus);
			}
		}
		
		/** Update lessonContentSummary when the "isSucceeded" property of a lesson content changes. */
		public function RefreshEnabledStatus(e:PropertyChangeEvent):void
		{
			var newSummary:Object;
			var contentIndex:int = this.representedLesson.contents.getItemIndex(e.source);
			
			if (contentIndex < (representedLesson.contents.length - 1)) {
				newSummary = lessonContentSummary[contentIndex + 1];
				newSummary["enabled"] = e.newValue;
			
				lessonContentSummary.setItemAt(newSummary, contentIndex + 1);
			}
		}
	}
}