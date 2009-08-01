package org.antigone.events
{
	import flash.events.Event;
	
	import org.antigone.vos.Exercise;
	
	public class ExerciseEvent extends Event
	{
		/* Constants */
		public static const EXERCISE_VALIDATED:String = "exerciseValidatedEvent";
		public static const EXERCISE_SUCCEEDED:String = "exerciseSucceededEvent";
		public static const EXERCISE_FAILED:String = "exerciseFailedEvent";
		
		/* Properties */
		public var exercise:Exercise;
		
		/* Constructor */
		public function ExerciseEvent(type:String, exercise:Exercise=null, bubbles:Boolean=true, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			this.exercise = exercise;
		}
	}
}