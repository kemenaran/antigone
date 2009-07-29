package org.antigone.vos
{
	[Bindable]
	/** A sample sentence in a exercice. Contains a sentence text, including a placeholder
	 * for inserting the answer, and a valid answer. */
	public class ExerciseSample
	{
		/** The sample as a String, including the XML for formatting or answers. */
		public var sentence:String = "";
		
		/** An array of all the answers of the sample. */
		public var answers:Array = new Array();
		
		public static function DecodeFromXML(coder:XML):ExerciseSample
		{
			var sample:ExerciseSample = new ExerciseSample();
			
			if (coder == null)
				return null;
			
			// Construct the sentence as a string
			for each(var sentencePart:XML in coder.children()) {
				sample.sentence += sentencePart.toXMLString() + " ";
			}
			
			for each(var answer:XML in coder.answer) {
				sample.answers.push(answer.@value.toString());
			}
			
			return sample;
		}
	}
}