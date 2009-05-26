package org.antigone.controllers
{
	import flash.filesystem.*;
	
	import org.antigone.models.User;
	
	/* A Login Provider whose datasource are XML files on the local filesystem. */
	public class LocalLoginProvider implements ILoginProvider
	{	
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
			var userFile:File = new File();
			
			// Create a file reference to the file
			var path:String = File.applicationStorageDirectory.nativePath + "/Users/" + username + ".xml";
			userFile = new File();
			userFile = userFile.resolvePath(path);
			
			// If the file doesn't even exists, the user is invalid
			if (!userFile.exists)
				return null;
			
			// Now read the data from the file
			userData = this.ReadUserFile(userFile);
			
			// … and convert it to a User object
			return User.decodeFromXML(userData);			
		}
		
		public function CreateUser(username:String, password:String):void {}
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
	}
}