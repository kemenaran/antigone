package org.antigone.vos
{
	[Bindable]
	public class Exercise extends LessonContent
	{		
		public static function DecodeFromXML(coder:XML):Exercise
		{
			var exercice:Exercise = new Exercise();
			
			if (coder == null)
				return null;
				
			exercice.title = coder.@title;
			
			return exercice;
		}

	}
}