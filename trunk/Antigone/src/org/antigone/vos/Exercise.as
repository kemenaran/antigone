package org.antigone.vos
{
	import org.antigone.vos.ExerciseSample;
	
	[Bindable]
	public class Exercise extends LessonContent
	{	
		/** A collection of all the samples in the exercice */
		public var samples:Array = new Array();
		
		/** The number of correct answers. */
		public var rating:Number = 0;
		
		/** The number of proposed samples by session (5 by default). */
		public var samplesBySession:Number = 5;
		
		public static function DecodeFromXML(coder:XML):Exercise
		{
			var exercise:Exercise = new Exercise();
			
			if (coder == null)
				return null;
				
			// Decode Exercice properties
			exercise.title = coder.@title;
			if (coder.attribute("samplesBySession").length() != 0)
				exercise.samplesBySession = coder.@samplesBySession;
			
			// Decode samples
			if (coder.sample.length() != 0) {
				for each(var sample:XML in coder.sample) {
					exercise.samples.push(ExerciseSample.DecodeFromXML(sample));
				}
			}
			
			// Check that samplesBySession is not superior to the total samples available
			exercise.samplesBySession = Math.min(exercise.samplesBySession, exercise.samples.length);
			
			return exercise;
		}

	}
}