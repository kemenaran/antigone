package org.antigone.events
{
	import flash.events.Event;
	
	import org.antigone.models.Lesson;

	public class LessonEvent extends Event
	{
		/* The lesson concerned by the event */
		public var lesson:Lesson;
		
		/* EventType constants */
		public static const LessonSelectedEvent:String = "lessonSelected";
		
		public function LessonEvent(type:String, lesson:Lesson, bubbles:Boolean=true)
		{
			super(type, bubbles, false);
			this.lesson = lesson;
		}
		
		public override function clone():Event
		{
			var newEvent:LessonEvent = super.clone() as LessonEvent;
			newEvent.lesson = this.lesson;
			
			return newEvent;
		}
		
		public override function toString():String
		{
			return formatToString("LessonEvent", "type", "bubbles", "cancelable", "eventPhase", "message");
		}		
	}
}