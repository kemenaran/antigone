package org.antigone.vos
{
	import org.antigone.vos.ExerciseSample;
	
	[Bindable]
	public class Exercise extends LessonContent
	{	
		/** A collection of all the samples in the exercice */
		public var samples:Array = new Array();
		
		public static function DecodeFromXML(coder:XML):Exercise
		{
			var exercice:Exercise = new Exercise();
			
			if (coder == null)
				return null;
				
			// Decode Exercice properties
			exercice.title = coder.@title;
			
			// Decode samples
			if (coder.sample.length() != 0) {
				for each(var sample:XML in coder.sample) {
					exercice.samples.push(ExerciseSample.DecodeFromXML(sample));
				}
			}
			
			return exercice;
		}

	}
}