package org.antigone.controllers
{
	import flash.events.Event;
	import flash.filesystem.*;
	import flash.utils.Dictionary;
	
	import org.antigone.models.Lesson;
	
	/* Manage multiple lessons stored in XML files. */
	public class LessonController extends Controller
	{
		/* Simple (and data-providable) lesson array.
		 * Updated by LoadAllLessons(). */
		protected var __lessons:Array = new Array();
		
		/* Lessons indexed by id - faster for searches and duplicate checks.
		 * Updated by LoadAllLessons(). */
		protected var lessonDict:Dictionary = new Dictionary();
		
		/* Allow elements to bind to "lessons".
		 * The property is read-only - change notifications are triggered
		 * by the protected setter (setLessons).
		 */
		[Bindable(event="lessonsArrayUpdated")]
		public function get lessons():Array
		{
			return __lessons;
		}
		
		/* Protected setter for the "lesson" property.
		 * Dispatch the event required for data-binding. */
		protected function setLessons(newLessons:Array):void
		{
			this.__lessons = newLessons;
			dispatchEvent(new Event("lessonsArrayUpdated"));
		}
		
		/* Load all lessons in the Lessons Array. */
		public function LoadAllLessons():void
		{
			var lessonsPath:File = this.GetLessonsPath();
			var lessonsFiles:Array = lessonsPath.getDirectoryListing();
			var lessonFile:File;
			var lesson:Lesson;
			var newLessons:Array = new Array();
			
			// Clear previous lessons
			this.__lessons = new Array();
			this.lessonDict = new Dictionary();
						
			// Enumerate XML files and load them as lessons
			for (var i:uint = 0; i < lessonsFiles.length; i++) {
				lessonFile = lessonsFiles[i];
				if (!lessonFile.isDirectory && lessonFile.extension == "xml") {
					// Decode a Lesson from the XML file
					lesson = LessonController.ReadLessonXML(lessonFile);
					
					// Check for id duplicates
					if (this.lessonDict[lesson.id] != null) {
						// We've got an id duplicate !
						throw new Error("The lesson '" + lesson.title + "' has the same id than "
								+ "the lesson '" + (this.lessonDict[lesson.id] as Lesson).title + "'.");
					}
					
					// Add the lesson to the lesson dictionary
					this.lessonDict[lesson.id] = lesson;
					
					// Append the lesson to the newLessons array
					newLessons.push(lesson);
				}
			}
			
			this.setLessons(newLessons);
		}
		
		/* Retrieve a given lesson, specified by its index. */
		public function GetLessonById(lessonId:String):Lesson
		{
			return this.lessonDict[lessonId] as Lesson;
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
