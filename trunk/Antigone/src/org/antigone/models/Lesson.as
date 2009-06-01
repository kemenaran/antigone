package org.antigone.models
{
	/* Model class representing a lesson. */
	[Bindable]
	public class Lesson
	{
		public var title:String;
		public var exercices:Array = new Array();
				
		public static function DecodeFromXML(coder:XML):Lesson
		{
			var lesson:Lesson = new Lesson();
			
			if (coder == null)
				return null;
				
			lesson.title = coder.@title;
			
			for each(var exerciceCoder:XML in coder.exercice)
				lesson.exercices.push(Exercice.DecodeFromXML(exerciceCoder));
			
			return lesson;
		}
	}
}