package org.antigone.business
{
	import flash.events.IEventDispatcher;
	
	import org.antigone.events.ExerciseEvent;
	import org.antigone.vos.Exercise;
	import org.antigone.vos.ExerciseAnswer;
	import org.antigone.vos.ExerciseSample;

	public class ExerciseManager extends Manager
	{
		[Bindable]
		public var currentExercise:Exercise;
		
		public function ExerciseManager(dispatcher:IEventDispatcher)
		{
			super(dispatcher);
		}
		
		public function Rate(exercise:Exercise):Exercise
		{
			var correctAnswers:Array = new Array();
			var wrongAnswers:Array = new Array();
			
			for each(var answer:ExerciseAnswer in GetAnswers(exercise)) {
				if (answer.isAnswerCorrect)
					correctAnswers.push(answer);
				else
					wrongAnswers.push(answer);
			}
			
			// Update rating
			exercise.rating = correctAnswers.length;
			
			// Dispatch events
			if (exercise.rating == exercise.samplesBySession)
				dispatchEvent(new ExerciseEvent(ExerciseEvent.EXERCISE_SUCCEEDED, exercise));
			else
				dispatchEvent(new ExerciseEvent(ExerciseEvent.EXERCISE_FAILED, exercise));
				
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