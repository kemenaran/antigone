package org.antigone.events
{
	import flash.events.Event;
	
	import org.antigone.vos.Lesson;
	
	public class LessonEvent extends Event
	{
		/* Constants */
		public static const LESSON_CLICKED:String = "lessonClickedEvent";
		public static const LESSON_SELECTED:String = "lessonSelectedEvent";
		
		/* Properties */
		public var lesson:Lesson;
		
		/* Constructor */
		public function LessonEvent(type:String, lesson:Lesson=null, bubbles:Boolean=true, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			this.lesson = lesson;
		}

	}
}