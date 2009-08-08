package org.antigone.business
{
	import flash.events.IEventDispatcher;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	
	import org.antigone.helpers.XMLHelper;
	import org.antigone.vos.*;
	
	/** Store and manage the progression of an user. */
	public class ProgressManager extends Manager
	{
		/** User for which the progression is managed. */ 
		public var user:User;
		
		/** Store settings for lessons and exercises. */
		public var lessons:Object = new Object();
		
		/** Wheather any change to the progression shoudl trigger a save to the disk. */
		public var autosave:Boolean = false;
		
		/** Wheather the progression data have already been loaded. */
		protected var progressionLoaded:Boolean = false;
		
		/** Constructor. */
		public function ProgressManager(dispatcher:IEventDispatcher)
		{
			super(dispatcher);
			
			// FIXME : when "user" changes, update "progressionloaded"
		}
		
		/** Load the progression data, and inject them into the lesson. */
		public function RestoreProgression(lesson:Lesson):void
		{
			//if (!progressionLoaded)
			//	LoadProgression();
			
			trace("Not implemented !");
		}
		
		/** Saves an exercise rating in the ProgressManager.
		 * @throw Exercise.parent n'est pas défini. */
		public function SaveExerciseRating(exercise:Exercise):void
		{
			if (!exercise.parent)
				throw new Error("Exercise.parent n'est pas défini.");
			
			var lessonId:String = exercise.parent.id;
			
			// If needed, create a string-indexed object for storing exercises
			if (!lessons[lessonId])
				lessons[lessonId] = new Object();
			
			// If needed, create a string-indexed object for storing exercise properties
			if (!lessons[lessonId]["content-" + exercise.position])
				lessons[lessonId]["content-" + exercise.position] = new Object();
				
			// Store exercise rating
			lessons[lessonId]["content-" + exercise.position]["rating"] = exercise.rating;
			
			// If needed, autosave the progression
			AutoSave();
		}
		
		/** If 'autosave' is activated, save the data.
		 * Returns weather the data were saved of not. */
		protected function AutoSave():void
		{
			if (autosave) {
				SaveProgression();
			}
		}
		
		/** Load all the progression data from the correct file.
		 * If the progression file doesn't exists, fails silently.
		 * 
		 * @throw Error if the user is not defined. */
		public function LoadProgression():void
		{
			if (!user)
				throw new Error("The 'user' property is not defined.");
				
			var file:File = GetProgressionFile(user.username);
			
			if (!file.exists)
				return;
				
			ReadProgressionFromXML(file);
		}
		
		/** Save all the progression data to the correct file.
		 * 
		 * @throw Error if the user is not defined. */
		public function SaveProgression():Boolean
		{
			if (!user)
				throw new Error("The 'user' property is not defined.");
				
			return SaveProgressionToXML();
		}
		
		/** Return the file of the progression settings for the given user. */ 
		protected static function GetProgressionFile(username:String):File
		{
			return File.applicationStorageDirectory.resolvePath("Users/" + username + "-progress.xml"); 
		}
		
		/** Decode the progression state from an XML object. */
		protected function DecodeProgressFromXML(coder:XML):void
		{
			
		}
		
		/** Encode the progression state to an XML object. */
		protected function EncodeProgressToXML(coder:XML):XML
		{			
			XMLHelper.EncodeObjectToXML(lessons, coder, "lessons");
			
			return coder;
		}
		
		/** Read the progression from an XML file. */
		protected function ReadProgressionFromXML(xml:File):void
		{
			throw new Error("Not implemented !");
		}
		
		/** Save the progression to an XML file. */
		protected function SaveProgressionToXML():Boolean
		{
			var coder:XML;
			var file:File = GetProgressionFile(user.username);
			
			// Add user infos to the XML file
			coder = new XML("<userProgress></userProgress>");
			coder = EncodeProgressToXML(coder);
			
			// Build up the full XML data as a string
			var newXMLStr:String = "<?xml version=\"1.0\" encoding=\"UTF-8\"?>"
				+ File.lineEnding
				+ coder.toXMLString();
				
			// Write XML to the file
			var fs:FileStream = new FileStream();
			try {
				fs.open(file, FileMode.WRITE);
				fs.writeUTFBytes(newXMLStr);
			} catch(error:Error) {
				return false;
			} finally {
				fs.close();
			}
			
			return true;
		}
	}
}