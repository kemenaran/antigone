package org.antigone.vos
{
	import flash.events.Event;
	import mx.binding.utils.ChangeWatcher;
	
	[Bindable]
	/** Model class for answer data.
	 * 
	 * Can be subclassed for specific behavior (especially if you need custom
	 * validation) */
	public class ExerciseAnswer
	{
		/** The given value for an answer. */
		public var given:String;
		
		/** The expected value for an answer. */
		public var expected:String;
		
		/** Weather the given and expected answers validate. */ 
		public function get isAnswerCorrect():Boolean
		{
			return ValidateAnswer();
		}
		
		/** Indicates weather the given input matchs the expected answer.
		 * To be overriden by subclasses for specific validation. */
		protected function ValidateAnswer():Boolean
		{
			return (given == expected);
		}
	}
}