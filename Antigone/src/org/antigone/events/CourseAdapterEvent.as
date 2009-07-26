package org.antigone.events
{
	import flash.events.Event;
	
	import org.antigone.adapters.CourseAdapter;

	public class CourseAdapterEvent extends Event
	{
		/* Constants */
		public static const COURSE_ADAPTER_CREATED:String = "courseAdapterCreated";
		
		/* Properties */
		public var courseAdapter:CourseAdapter;
		
		/* Constructor */
		public function CourseAdapterEvent(type:String, courseAdapter:CourseAdapter, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			this.courseAdapter = courseAdapter;
		}
		
	}
}