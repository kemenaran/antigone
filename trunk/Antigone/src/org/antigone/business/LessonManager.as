package org.antigone.business
{
	import flash.events.Event;
	import flash.events.IEventDispatcher;
	import flash.filesystem.*;
	import flash.text.StyleSheet;
	import flash.utils.Dictionary;
	
	import org.antigone.events.LessonEvent;
	import org.antigone.vos.Lesson;
	
	/* Manage multiple lessons stored in XML files. */
	[Bindable]
	public class LessonManager extends Manager
	{
		/* The lesson currently selected (read-only). */
		protected var _selectedLesson:Lesson = new Lesson();
		
		[Bindable(event="selectedLessonChanged")]
		public function get selectedLesson():Lesson
		{
			return _selectedLesson;
		}
		
		protected function setSelectedLesson(lesson:Lesson):void
		{
			this._selectedLesson = lesson;
			dispatchEvent(new Event("selectedLessonChanged"));
		}
		
		/* The currently selected content in the selected lesson */
		public var selectedContent:uint;
		
		/* StyleSheet object for the lesson */
		public var styleSheet:StyleSheet;
		
		/* Simple (and data-providable) lesson array.
		 * Updated by LoadAllLessons(). */
		protected var _lessons:Array = new Array();
		
		/* Lessons indexed by id - faster for searches and duplicate checks.
		 * Updated by LoadAllLessons(). */
		protected var _lessonDict:Dictionary = new Dictionary();
		
		/* Allow elements to bind to "lessons".
		 * The property is read-only - change notifications are triggered
		 * by the protected setter (setLessons).
		 */
		[Bindable(event="lessonsArrayUpdated")]
		public function get lessons():Array
		{
			return _lessons;
		}
		
		/* Protected setter for the "lesson" property.
		 * Dispatch the event required for data-binding. */
		protected function setLessons(newLessons:Array):void
		{
			this._lessons = newLessons;
			dispatchEvent(new Event("lessonsArrayUpdated"));
		}
		
		/* Constructor */
		public function LessonManager(dispatcher:IEventDispatcher)
		{
			super(dispatcher);
		}
		
		/* Load all lessons in the Lessons Array.
		 * If a non-empty lesson array already exists, LoadLesson will not attempt
		 * to reconstruct the lesson tree from the disk - unless you force it to
		 * using forceRefresh. */
		public function LoadLessons(forceRefresh:Boolean=false):void
		{
			var lessonsPath:File = this.GetLessonsPath();
			var lessonsFiles:Array;
			var lessonFile:File;
			var lesson:Lesson;
			var newLessons:Array = new Array();
			
			// If some lessons were already loaded and forceRefresh is not required, give up
			if (this._lessons.length != 0 && !forceRefresh)
				return;
				
			// Check that the lessons folder exists
			if (!lessonsPath.exists)
				throw new Error("The Lessons directory (" + lessonsPath.nativePath + ") cannot be found. " +
					"Your program setup is probably corrupted - please try to reinstall the latest version of Antigone.");
			
			// Clear previous lessons
			this._lessons = new Array();
			this._lessonDict = new Dictionary();
			
			// Enumerate the files in the lessons directory
			lessonsFiles = lessonsPath.getDirectoryListing();
						
			// Enumerate XML files and load them as lessons
			for (var i:uint = 0; i < lessonsFiles.length; i++) {
				lessonFile = lessonsFiles[i];
				if (!lessonFile.isDirectory && lessonFile.extension == "xml") {
					// Decode a Lesson from the XML file
					lesson = LessonManager.ReadLessonXML(lessonFile);
					
					// Check for id duplicates
					if (this._lessonDict[lesson.id] != null) {
						// We've got an id duplicate !
						throw new Error("The lesson '" + lesson.title + "' has the same id than "
								+ "the lesson '" + (this._lessonDict[lesson.id] as Lesson).title + "'.");
					}
					
					// Add the lesson to the lesson dictionary
					this._lessonDict[lesson.id] = lesson;
					
					// Append the lesson to the newLessons array
					newLessons.push(lesson);
				}
			}
			
			this.setLessons(newLessons);
		}
		
		/* Load the lessons' stylesheet defined by GetStyleSheetPath() and parse
		 * it into the stylesheet property. */
		public function LoadStyleSheet(forceRefresh:Boolean=false):void
		{
			var styleSheetFile:File;
			var newStyleSheet:StyleSheet;
			var stream:FileStream = new FileStream();
			
			if (this.styleSheet != null && !forceRefresh)
				return;
			
			// Retrieve the file
			styleSheetFile = this.GetStyleSheetFile();
			
			try {
				stream.open(styleSheetFile, FileMode.READ);
			
				newStyleSheet = new StyleSheet();
				newStyleSheet.parseCSS(stream.readUTFBytes(stream.bytesAvailable));
				
			} catch (e:Error) {
				throw new Error("Cannot load the CSS Stylesheet for lessons : " + e.message);
			} finally {
				stream.close();
			}
			
			// Set the new stylesheet
			this.styleSheet = newStyleSheet;
		}
		
		/* Retrieve a given lesson, specified by its index. */
		public function GetLessonById(lessonId:String):Lesson
		{
			return this._lessonDict[lessonId] as Lesson;
		}
		
		public function SelectLesson(lesson:Lesson):void
		{
			this.setSelectedLesson(lesson);
			
			// Dispatch a LESSON_SELECTED event
			var event:LessonEvent = new LessonEvent(LessonEvent.LESSON_SELECTED);
			event.lesson = lesson;
			dispatcher.dispatchEvent(event);
		}
		
		/* Return the lessons' folder. */
		protected function GetLessonsPath():File
		{
			return File.applicationDirectory.resolvePath("Lessons/");
		}
		
		/* Return the lessons' stylesheet file */
		protected function GetStyleSheetFile():File
		{
			return File.applicationDirectory.resolvePath("courses.css");
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
