package org.antigone.controllers
{
	import flash.filesystem.*;
	
	import org.antigone.models.Lesson;
	
	/* Manage multiple lessons stored in XML files. */
	public class LessonController extends Controller
	{
		protected var __lessons:Array = new Array();
		
		[Bindable]
		public function get lessons():Array
		{
			//if (__lessons == null)
			//	this.LoadAllLessons();
				
			return __lessons;
		}
		
		/* Bindings need a setter to work properly. */
		public function set lessons(lessons:Array):void
		{
			this.__lessons = lessons;
		}
		
		/* Load all lessons in the Lessons Array. */
		public function LoadAllLessons():void
		{
			var lessonsPath:File = this.GetLessonsPath();
			var lessonsFiles:Array = lessonsPath.getDirectoryListing();
			var lessonFile:File;
			var newLessons:Array = new Array();
			
			for (var i:uint = 0; i < lessonsFiles.length; i++) {
				lessonFile = lessonsFiles[i];
				if (!lessonFile.isDirectory && lessonFile.extension == "xml") {
					newLessons.push(LessonController.ReadLessonXML(lessonFile));
				}
			}
			
			this.lessons = newLessons;
		}
		
		/* Retrieve a given lesson, specified by its index. */
		public function GetLessonAtIndex(index:int):Lesson
		{
			return lessons[index] as Lesson;
		}
		
		/* Return the lessons' folder. */
		protected function GetLessonsPath():File
		{
			return File.applicationDirectory.resolvePath("Lessons/");
		}
		
		/* Create a Lesson object from an XML file. */
		protected static function ReadLessonXML(lessonFile:File):Lesson
		{
			var lessonXML:XML = null;
			var stream:FileStream = new FileStream();
			
			// if the file doesn't exist, you failed
			if (!lessonFile.exists)
				return null;
			
			// Read the file	
			try {
				stream.open(lessonFile, FileMode.READ);
		    	lessonXML = XML(stream.readUTFBytes(stream.bytesAvailable));
			} catch (error:Error) {
				return null;
			} finally {
				stream.close();
			}
		
			// Decode the XML into a new User object
			return Lesson.DecodeFromXML(lessonXML);
		}

	}
}
