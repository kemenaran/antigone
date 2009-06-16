package org.antigone.adapters
{
	import mx.collections.ArrayCollection;
	
	import org.antigone.vos.Lesson;
	
	[Bindable]
	public class LessonViewAdapter
	{
		/* Content items for the lesson (Courses, Exercises, etc) sorted by lessonIndex */
		public var lessonContents:ArrayCollection = new ArrayCollection();
		
		/* The index of the currently selected content */
		public var selectedContent:uint;
		
		/* Populate the adapter content with data */
		public function set lesson(newLesson:Lesson):void
		{
			// populate lessonContent
			lessonContents.removeAll();
			
			// Merge LessonContent (Courses and Exercises)…
			var sortArray:Array = new Array();
			sortArray = sortArray.concat(newLesson.courses, newLesson.exercises);
			
			// … and sort them by lessonIndex
			sortArray.sortOn("lessonIndex");
			lessonContents.source = sortArray;
		}
	}
}