package org.antigone.events
{
	import flash.events.Event;
	
	import org.antigone.vos.LessonContent;
	
	public class ContentEvent extends Event
	{
		/* Constants */
		public static const COURSE_VALIDATED:String = "courseValidatedEvent";
		public static const COURSE_SUCCEEDED:String = "courseSucceededEvent";
		public static const EXERCISE_VALIDATED:String = "exerciseValidatedEvent";
		public static const EXERCISE_SUCCEEDED:String = "exerciseSucceededEvent";
		public static const EXERCISE_FAILED:String = "exerciseFailedEvent";
		
		/* Properties */
		public var content:LessonContent;
		
		/* Constructor */
		public function ContentEvent(type:String, content:LessonContent=null, bubbles:Boolean=true, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			this.content = content;
		}
	}
}