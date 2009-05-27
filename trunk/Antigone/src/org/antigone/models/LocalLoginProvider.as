package org.antigone.models
{
	import flash.filesystem.*;
	import org.antigone.models.User;
	
	/* A Login Provider whose datasource are XML files on the local filesystem. */
	public class LocalLoginProvider implements ILoginProvider
	{	
		/* Check whether an user file already exists. */
		public function UserExists(username:String):Boolean
		{
			var userFile:File = this.GetFileForUser(username);
			return userFile.exists;	
		}
		
		/* Check wether user credentials are valid. */
		public function ValidateUser(username:String, password:String):Boolean
		{
			// Attempt to retrieve the User object from the XML file
			var user:User = this.GetUser(username);
			
			// Check that username and password match
			return (user != null
			    && user.username == username
			    && user.password == password);
		}	
		
		/* Read an user's XML file and return the matching User object.
		 * Returns null if the file doesn't exist or if there is an error.
		 */
		public function GetUser(username:String):User
		{
			var userData:XML;
			var userFile:File = this.GetFileForUser(username);
			
			// If the file doesn't even exists, the user is invalid
			if (!userFile.exists)
				return null;
			
			// Now read the data from the file
			userData = this.ReadUserFile(userFile);
			
			// … and convert it to a User object
			return User.decodeFromXML(userData);			
		}
		
		/* Create a new user.
		 * Returns true in case of success, and false else (for instance if the
		 * user already exists). */
		public function CreateUser(username:String, password:String):Boolean
		{
			var user:User = new User();
			var userFile:File;
			
			// We will not overwrite an existing user
			if (this.UserExists(username))
				return false;
			
			// Retrieve the user infos
			userFile = this.GetFileForUser(username);			
				
			// Empty username or passwords are not allowed
			if (username == null || username == "" || password == null || password == "")
				return false;
			
			// Store properties in a User object
			user.username = username;
			user.password = password;
			
			// Prepare XML content
			var userData:XML = user.encodeToXML();
			var newXMLStr:String = "<?xml version=\"1.0\" encoding=\"UTF-8\"?>"
				+ File.lineEnding
				+ userData.toXMLString();

			// Write XML to the file
			var fs:FileStream = new FileStream();
			fs.open(userFile, FileMode.WRITE);
			fs.writeUTFBytes(newXMLStr);
			fs.close(); 
			
			return true;
		}
		
		public function UpdateUser(user:User):void {}
		public function DeleteUser(username:String):void {}
		
		/* Read the XML fragment that contains user data.
		 * Returns null if the file doesn't exist or if there is an error.
		 */
		private function ReadUserFile(userFilePath:File):XML
		{
			var userFile:XML = null;
			var stream:FileStream = new FileStream();
			
			if (userFilePath.exists) {
    			stream.open(userFilePath, FileMode.READ);
			    userFile = XML(stream.readUTFBytes(stream.bytesAvailable));
				stream.close();
			}
			
			return userFile;
		}
		
		/* Return a File poiting to the location of the user XML file 
		 * for a given user.
		 * The file itself is not guaranteed to exist.
		 */
		private function GetFileForUser(username:String):File
		{
			var path:String;
			var userFile:File = new File();
			
			path = File.applicationStorageDirectory.nativePath + "/Users/" + username + ".xml";
			return userFile.resolvePath(path);
		}
	}
}