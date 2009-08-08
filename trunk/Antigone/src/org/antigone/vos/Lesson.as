package org.antigone.vos
{
	/** Model class representing a lesson. */
	[Bindable]
	public class Lesson
	{
		/** An unique identifier for the lesson.*/
		public var id:String;
		
		/** The title of the lesson. */
		public var title:String;
		
		/** One or several courses associated with the lesson. */
		public var courses:Array = new Array();
		
		/** Several exercises associated with the lesson. */
		public var exercises:Array = new Array();
				
		/** Create a new Lesson object from an XML coder. */
		public static function DecodeFromXML(coder:XML):Lesson
		{
			var lesson:Lesson = new Lesson();
			
			// Sanity check
			if (coder == null)
				return null;
			var id:String = coder.@id;
			if (coder.@id == undefined)
				throw new Error("The lesson '" + coder.@title + "' must have an 'id' attribute.");
			
			// Decode instance members
			lesson.id    = coder.@id;
			lesson.title = coder.@title;
			
			// Decode courses and exercises, and assing a lesson index to them
			var lessonIndex:uint = 0;
			var content:LessonContent;
			for each (var child:XML in coder.children()) {
				// We have a course !
				if (child.name() == "course") {
					// Decode it, and add it to the courses array
					content = Course.DecodeFromXML(child);
					
				} else
				// We have an exercise !
				if (child.name() == "exercise") {
					// Decode it, and add it to the courses array
					content = Exercise.DecodeFromXML(child);
				}
				
				// Set common content properties
				content.position = lessonIndex++;
				content.parent = lesson;
				lesson.courses.push(content);							
			}
			
			return lesson;
		}
	}
}