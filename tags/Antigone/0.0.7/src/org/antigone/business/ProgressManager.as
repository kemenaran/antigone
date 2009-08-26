package org.antigone.business
{
	import flash.events.IEventDispatcher;
	import flash.filesystem.File;
	
	import mx.binding.utils.BindingUtils;
	
	import org.antigone.helpers.XMLHelper;
	import org.antigone.vos.*;
	
	/** Store and manage the progression of an user. */
	public class ProgressManager extends Manager
	{
		/** User for which the progression is managed. */ 
		public var user:User;
		
		/** Store settings for lessons and exercises. */
		public var lessonsRecord:Object = new Object();
		
		/** Wheather any change to the progression shoudl trigger a save to the disk. */
		public var autosave:Boolean = false;
		
		/** Wheather the progression data have already been loaded. */
		protected var progressionLoaded:Boolean = false;
		
		/** Constructor. */
		public function ProgressManager(dispatcher:IEventDispatcher)
		{
			super(dispatcher);
			
			// Set progressionLoaded to false when the user changes
			BindingUtils.bindSetter(
				function (value:*):void { progressionLoaded = false },
				this,
				"user");
		}
		
		/** Load the progression data, and inject them into the lesson. */
		public function RestoreProgression(lesson:Lesson):void
		{
			if (!progressionLoaded)
				LoadProgression();
			
			// Check if we have a matching lesson in our records
			if (this.lessonsRecord.hasOwnProperty(lesson.id)) {
				var lessonRecord:Object = lessonsRecord[lesson.id];
				
				// Enumerate all contents in the lesson…
				for each(var content:LessonContent in lesson.contents) {
					var contentName:String = "content-" + content.position;
				
					// Check if we have a matching content in our records
					if (lessonRecord.hasOwnProperty(contentName)) {
						var contentRecord:Object = lessonRecord[contentName];
						
						// Copy stored properties into the content
						for (var key:String in contentRecord) {
							content[key] = contentRecord[key];
						}
					}
				}
			}
		}
		
		/** Saves an exercise rating in the ProgressManager.
		 * @throw Exercise.parent n'est pas défini. */
		public function SaveLessonProgression(lesson:Lesson):void
		{
			var lessonId:String = lesson.id;
			
			// If needed, create a string-indexed object for storing content objects
			if (!lessonsRecord[lessonId])
				lessonsRecord[lessonId] = new Object();
			
			// Enumerate lessons' content…
			for each(var content:LessonContent in lesson.contents){
				
				// If needed, create a string-indexed object for storing content properties
				if (!lessonsRecord[lessonId]["content-" + content.position])
					lessonsRecord[lessonId]["content-" + content.position] = new Object();
				
				// Store common properties
				lessonsRecord[lessonId]["content-" + content.position]["isSucceeded"] = content.isSucceeded;
				
				if (content is Exercise) {
					// Store exercise rating
					lessonsRecord[lessonId]["content-" + content.position]["rating"] = (content as Exercise).rating;
				}
			}
			
			// If needed, autosave the progression
			AutoSave();
		}
		
		/** Load all the progression data from the correct file.
		 * If the progression file doesn't exists, fails silently.
		 * 
		 * @throw Error if the user is not defined. */
		public function LoadProgression():void
		{
			if (!user)
				throw new Error("The 'user' property is not defined.");
				
			// Ensure that the progression file exists for the current user
			var file:File = GetProgressionFile(user.username);
			if (!file.exists)
				return;
			
			// Read the XML from the file
			var userProgress:XML = XMLHelper.ReadXMLFromFile(file);
			
			// Parse the XML and inject it in the object
			DecodeProgressFromXML(userProgress);
		}
		
		/** Save all the progression data to the correct file.
		 * 
		 * @throw Error if the user is not defined. */
		public function SaveProgression():void
		{
			var coder:XML;
			var file:File;
			
			// Ensure that the current user is defined
			if (!user)
				throw new Error("The 'user' property is not defined.");
				
			// Retrieve the progress filename
			file = GetProgressionFile(user.username);
			
			// Add user infos to the XML file
			coder = new XML("<userProgress></userProgress>");
			coder = EncodeProgressToXML(coder);
			
			// Write XML to file
			XMLHelper.WriteXMLToFile(coder, file);
		}
		
		
		/*
		 * Internal methods
		 */
		
		/** Return the file of the progression settings for the given user. */ 
		protected static function GetProgressionFile(username:String):File
		{
			return File.applicationStorageDirectory.resolvePath("Users/" + username + "-progress.xml"); 
		}
		
		/** Decode the progression state from an XML object. */
		protected function DecodeProgressFromXML(coder:XML):void
		{
			// Decode XML values in a Object-based array
			var progress:Object = XMLHelper.DecodeObjectFromXML(coder);
			
			// Restore own properties with decoded data
			this.lessonsRecord = progress["lessons"];
		}
		
		/** Encode the progression state to an XML object. */
		protected function EncodeProgressToXML(coder:XML):XML
		{			
			XMLHelper.EncodeObjectToXML(lessonsRecord, coder, "lessons");
			
			return coder;
		}
		
		/** If 'autosave' is activated, save the data.
		 * Returns weather the data were saved of not. */
		protected function AutoSave():void
		{
			if (autosave) {
				SaveProgression();
			}
		}
	}
}