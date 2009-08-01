package org.antigone.vos
{
	import mx.collections.ArrayCollection;
	
	[Bindable]
	/** A sample sentence in a exercice. Contains a sentence text, including a placeholder
	 * for inserting the answer, and a valid answer. */
	public class ExerciseSample
	{
		/** The sample as a String, including the XML for formatting or answers. */
		public var sentence:String = "";
		
		/** An array of all the answers of the sample. */
		public var answers:ArrayCollection = new ArrayCollection();
		
		public static function DecodeFromXML(coder:XML):ExerciseSample
		{
			var sample:ExerciseSample = new ExerciseSample();
			
			if (coder == null)
				return null;
			
			// Construct the sentence as a string
			for each(var sentencePart:XML in coder.children()) {
				if (sentencePart.attribute("value").length() != 0)
					sample.sentence += "%answer%";
				else
					sample.sentence += sentencePart.toXMLString();
				sample.sentence += " ";
			}
			// Remove last extra-space
			sample.sentence = sample.sentence.slice(0, -1);
			
			// Populate the answers of the sentence in an array
			for each(var answer:XML in coder.answer) {
				var newAnswer:ExerciseAnswer = new ExerciseAnswer();
				newAnswer.expected = answer.@value.toString();
				sample.answers.addItem(newAnswer);
			}
			
			return sample;
		}
	}
}