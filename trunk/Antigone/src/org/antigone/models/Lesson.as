package org.antigone.models
{
	/* Model class representing a lesson. */
	[Bindable]
	public class Lesson
	{
		/* The title of the lesson. */
		public var title:String;
		
		/* One or several courses associated with the lesson. */
		public var courses:Array = new Array();
		
		/* Several exercises associated with the lesson. */
		public var exercises:Array = new Array();
		
		/* Where are we in the lesson. Retrieved from the ProgressionStore. */
		public var status:LessonStatus;
				
		/* Create a new Lesson object from an XML coder. */
		public static function DecodeFromXML(coder:XML):Lesson
		{
			var lesson:Lesson = new Lesson();
			
			// Sanity check
			if (coder == null)
				return null;
				
			// Decode instance members
			lesson.title = coder.@title;
			
			// Decode courses
			for each(var courseCoder:XML in coder.course)
				lesson.courses.push(Course.DecodeFromXML(courseCoder));
			
			// Decode exercices
			for each(var exerciceCoder:XML in coder.exercice)
				lesson.exercises.push(Exercise.DecodeFromXML(exerciceCoder));
			
			return lesson;
		}
	}
}