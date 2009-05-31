package org.antigone.controllers
{
	import flash.filesystem.File;
	import org.antigone.models.Lesson;
	
	/* Manage multiple lessons stored in XML files. */
	public class LessonsController extends Controller
	{
		protected var lessons:Array;
		
		/* Load all lessons in the Lessons Array. */
		public function LoadAllLessons()
		{
			var lessonsPath:File = this.GetLessonsPath();
			
			var lessonsFiles:Array = lessonsPath.getDirectoryListing();
			
			for (var lessonFile:File in lessonsFiles) {
				if (!lessonFile.isDirectory && lessonFile.extension == "xml") {
					this.lessons[] = LessonsController.ReadLessonXML(lessonFile);
				}
			}
		}
		
		/* Retrieve a given lesson, specified by its index. */
		public function GetLessonAtIndex(index:int):Lesson
		{
			return lessons[index] as Lesson;
		}
		
		/* Return the lessons' folder. */
		protected function GetLessonsPath():File
		{
			var path:File = new File();
			return path.resolvePath(File.applicationStorageDirectory.toString() + "/Lessons/");
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
