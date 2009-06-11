package org.antigone.vos
{
	import flash.filesystem.File;
	
	/* Modelize the course included in a Lesson. */
	[Bindable]
	public class Course
	{
		public var title:String;
		public var text:String;
		public var audioFile:File;
		
		/* Create a new Course object from an XML coder. */
		public static function DecodeFromXML(coder:XML):Course
		{
			var course:Course = new Course();
			
			// Sanity check
			if (coder == null)
				return null;
				
			// Decode instance members
			course.title = coder.@title;
			course.text = coder.text[0];
			course.audioFile = File.applicationDirectory.resolvePath("/Lessons/" + coder.audioFile[0]);
			
			return course;
		}
	}
}