package org.antigone.models
{
	import flash.filesystem.*;
	import flash.utils.*;
	
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

			// We will not overwrite an existing user
			if (this.UserExists(username))
				return false;	
			
			// Store properties in a User object
			user.username = username;
			user.password = password;	
			
			// Empty username or passwords are not allowed
			if (!user.IsValidUser())
				return false;
			
			// Write the XML file
			return this.WriteUserFile(user);
		}
		
		/* Update the data of an User.
		 * All non-null fields will be updated. The User object must be valid.
		 * 
		 * Returns true in case of success, false else (for instance if
		 * the user does not exist).*/
		public function UpdateUser(newUserData:User):Boolean
		{
			var user:User;
			
			// Check that all required fields are here
			if (!newUserData.IsValidUser())
				return false;
			
			// Do not update a user that doesn't exists
			if (!this.UserExists(newUserData.username))
				return false;
			
			// Retrieve current user data
			user = this.GetUser(newUserData.username);
			
			// Describe User type
			var userType:XML = describeType(User);
			
			// Enumerate through User properties
			for each(var property:String in userType.factory.accessor.@name) {
				if (newUserData[property] != null)
					user[property] = newUserData[property];
			}
			
			// Write the updated User
			return this.WriteUserFile(user);
		}
		
		public function DeleteUser(username:String):Boolean
		{
			return false;
		}
		
		/*
		 --------------------------------------------------
		  Private methods
		 --------------------------------------------------
		 */
		
		
		/* Return a File poiting to the location of the user XML file 
		 * for a given user.
		 * The file itself is not guaranteed to exist.
		 */
		protected function GetFileForUser(username:String):File
		{
			var path:String;
			var userFile:File = new File();
			
			path = File.applicationStorageDirectory.nativePath + "/Users/" + username + ".xml";
			return userFile.resolvePath(path);
		}
		
		/* Read the XML fragment that contains user data.
		 * Returns null if the file doesn't exist or if there is an error.
		 */
		protected function ReadUserFile(userFilePath:File):XML
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
		
		/* Build an XML fragment from the User object, and write it
		 * to the file specified by GetFileForUser.
		 * The file is created if it does not exists. */
		protected function WriteUserFile(user:User):Boolean
		{
			var coder:XML;
			var userFile:File = this.GetFileForUser(user.username);
			
			// Add user infos to the XML file
			coder = new XML("<userProfile></userProfile>");
			coder = user.encodeToXML(coder);
			
			// Build up the full XML data as a string
			var newXMLStr:String = "<?xml version=\"1.0\" encoding=\"UTF-8\"?>"
				+ File.lineEnding
				+ coder.toXMLString();
				
			// Write XML to the file
			var fs:FileStream = new FileStream();
			try {
				fs.open(userFile, FileMode.WRITE);
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