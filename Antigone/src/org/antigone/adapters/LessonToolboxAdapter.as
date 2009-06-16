package org.antigone.adapters
{
	import mx.collections.ArrayCollection;
	
	import org.antigone.vos.Lesson;
	import org.antigone.vos.LessonContent;
	
	public class LessonToolboxAdapter
	{
		[Bindable]
		public var lessonContentSummary:ArrayCollection = new ArrayCollection();
		
		[Bindable]
		public var selectedContent:uint;
		
		public function set lesson(newLesson:Lesson):void
		{
			// Create an array with the sorted lesson content
			var content:Array = new Array();
			content = content.concat(newLesson.courses, newLesson.exercises);
			content.sortOn("position");
			
			// Populate the lessonContentSummary
			lessonContentSummary.removeAll();
			for each(var contentItem:LessonContent in content) {
				var summary:Object = {label:contentItem.title};
				lessonContentSummary.addItem(summary);
			}
		}
	}
}