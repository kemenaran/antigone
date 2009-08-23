package org.antigone.business
{
	import flash.events.IEventDispatcher;
	
	import org.antigone.events.ContentEvent;
	import org.antigone.vos.Course;

	/** Manage the courses of a lesson. */
	public class CourseManager extends Manager
	{
		/** Dispatched when an exercise has been successfully validated. */
		[Event("courseSucceededEvent", "org.antigone.events.ContentEvent")]
		
		/** Constructor */
		public function CourseManager(dispatcher:IEventDispatcher)
		{
			super(dispatcher);
		}
		
		/** Check weather a course is succeeded and fire the appropriate events. */
		public function Validate(course:Course):Course
		{
			/* Validate the course
			 * (there is no specific rules for now) */
			course.isSucceeded = true;
			
			// Dispatch events
			dispatcher.dispatchEvent(new ContentEvent(ContentEvent.COURSE_SUCCEEDED, course));
			
			return course;
		}
	}
}