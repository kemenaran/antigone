package org.antigone.adapters
{
	import flash.utils.getQualifiedClassName;
	
	import mx.collections.ArrayCollection;
	import mx.core.Application;
	
	import org.antigone.events.CourseAdapterEvent;
	import org.antigone.vos.*;
	
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
			sortArray.sortOn("position");
			
			// Replace Courses in the content by the matching adapter
			for (var i:String in sortArray) {
				if (sortArray[i] is Course) {
					sortArray[i] = CourseAdapter.InitFromCourse(sortArray[i]);
				}
			}
			
			// Inject the sorted array into the Adapter property
			lessonContents.source = sortArray;
		}
	}
}