package org.antigone.vos
{
	import flash.events.Event;
	import mx.binding.utils.ChangeWatcher;
	
	[Bindable]
	public class ExerciseAnswer
	{
		public var given:String;
		public var expected:String;
		
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