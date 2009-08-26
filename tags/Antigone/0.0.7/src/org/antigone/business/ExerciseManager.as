package org.antigone.business
{
	import flash.events.IEventDispatcher;
	
	import org.antigone.events.ContentEvent;
	import org.antigone.vos.Exercise;
	import org.antigone.vos.ExerciseAnswer;
	import org.antigone.vos.ExerciseSample;

	/** Manage the exercises of a lesson. */
	public class ExerciseManager extends Manager
	{
		/** Dispatched when an exercise has been successfully validated. */
		[Event("exerciseSucceededEvent", "org.antigone.events.ContentEvent")]
		
		/** Dispatched when an exercise has not been successfully validated. */
		[Event("exerciseFailedEvent", "org.antigone.events.ContentEvent")]
		
		/** Constructor. */
		public function ExerciseManager(dispatcher:IEventDispatcher)
		{
			super(dispatcher);
		}
		
		/** Compute the Rate of an exercise, set the isSucceeded property,
		 * then fire appropriate events. */
		public function Validate(exercise:Exercise):Exercise
		{
			exercise = Rate(exercise);
			
			// Dispatch events
			if (exercise.rating == exercise.samplesBySession) {
				exercise.isSucceeded = true;
				dispatcher.dispatchEvent(new ContentEvent(ContentEvent.EXERCISE_SUCCEEDED, exercise));
			} else {
				// We don't touch 'isSucceeded' here : once an exercise has been successfully completed,
				// it is flagged as 'succeeded', whatever may happend after. 
				dispatcher.dispatchEvent(new ContentEvent(ContentEvent.EXERCISE_FAILED, exercise));
			}
			
			return exercise;
		}
		
		/** Set the rating of an exercise by checking the given answers. */
		public function Rate(exercise:Exercise):Exercise
		{
			var correctAnswers:Array = new Array();
			var wrongAnswers:Array = new Array();
			
			// For each answer, check if it is correct of not
			for each(var answer:ExerciseAnswer in GetAnswers(exercise)) {
				if (answer.isAnswerCorrect)
					correctAnswers.push(answer);
				else
					wrongAnswers.push(answer);
			}
			
			// Update rating
			exercise.rating = correctAnswers.length;
			
			return exercise;
		}
		
		/** Return all the answers of an exercise. */
		protected static function GetAnswers(exercise:Exercise):Array
		{
			var answers:Array = new Array();
			
			for each(var sample:ExerciseSample in exercise.samples)
				for each(var answer:ExerciseAnswer in sample.answers)
					answers.push(answer);
					
			return answers;
		}
	}
}