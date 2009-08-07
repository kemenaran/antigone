package org.antigone.business
{
	import flash.filesystem.*;
	import flash.utils.*;
	import org.antigone.vos.User;
		
	/** A Login Provider whose datasource are XML files on the local filesystem. */
	public class LocalLoginProvider implements ILoginProvider
	{	
		/** Check whether an user file already exists. */
		public function UserExists(username:String):Boolean
		{
			var userFile:File = GetFileForUser(username);
			return userFile.exists;	
		}
		
		/** Check wether user credentials are valid. */
		public function ValidateUser(username:String, password:String):Boolean
		{
			// Attempt to retrieve the User object from the XML file
			var user:User = this.GetUser(username);
			
			// Check that username and password match
			return (user != null
			    && user.username == username
			    && user.password == password);
		}	
		
		/** Read an user's XML file and return the matching User object.
		 * Returns null if the file doesn't exist or if there is an error.
		 */
		public function GetUser(username:String):User
		{
			var userFile:File = GetFileForUser(username);
			
			// If the file doesn't even exists, the user is invalid
			if (!userFile.exists)
				return null;
			
			// Now read the data from the file
			return ReadUserXML(username);		
		}
		
		/** Create a new user.
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
			return LocalLoginProvider.WriteUserXML(user);
		}
		
		/** Update the data of an User.
		 * All non-null fields will be updated. The User object must be valid.
		 *
		 * WARNING : this method will read the user profile from the file system
		 * before updating values. Therefore, if you maintain a global instance of a
		 * user profile, check for conflicts. A good solution is to save (i.e. write
		 * to the disk) your global user profile pbfore using UpdateUser.
		 * 
		 * Returns true in case of success, false else (for instance if
		 * the user does not exist).*/
		public function UpdateUser(user:User):User
		{
			var newUser:User;
			
			// Check that all required fields are here
			if (!user.IsValidUser())
				return null;
			
			// Do not update a user that doesn't exists
			if (!this.UserExists(user.username))
				return null;
			
			// Retrieve current user profile
			newUser = LocalLoginProvider.ReadUserXML(user.username);
			
			// Describe User type
			var userType:XML = describeType(User);
			
			// Enumerate properties, and update fields for non-null values
			for each(var property:XML in userType.factory.accessor) {
				if (user[property.@name] != null && property.@access == "readwrite")
					newUser[property.@name] = user[property.@name];
			}
			
			// Write the updated User Profile
			if (LocalLoginProvider.WriteUserXML(newUser))
				return newUser;
			else
				return null;
		}
		
		/** Delete a user profile XML file from the file system. */
		public function DeleteUser(username:String):Boolean
		{
			var userProfilePath:File = GetFileForUser(username);
			try {
				userProfilePath.deleteFile();
			} catch (error:Error) {
				return false;
			}
			
			return true;
		}
		
		
		/*-------------------------------------------------------------------------
		   Private Methods
		  -------------------------------------------------------------------------
		 */
		 
		/** Return a File poiting to the location of the user XML file 
		 * for a given user.
		 * The file itself is not guaranteed to exist.
		 */
		protected static function GetFileForUser(username:String):File
		{
			var path:String;
			var userFile:File = new File();
			
			path = File.applicationStorageDirectory.nativePath + "/Users/" + username + ".xml";
			return userFile.resolvePath(path);
		}
		
		/** Read the XML fragment that contains user data.
		 * Returns null if the file doesn't exist or if there is an error.
		 */
		protected static function ReadUserXML(username:String):User
		{
			var userFile:XML = null;
			var userFilePath:File = GetFileForUser(username);
			var stream:FileStream = new FileStream();
			
			// if the file doesn't exist, you failed
			if (!userFilePath.exists)
				return null;
			
			// Read the file	
			try {
				stream.open(userFilePath, FileMode.READ);
		    	userFile = XML(stream.readUTFBytes(stream.bytesAvailable));
			} catch (error:Error) {
				return null;
			} finally {
				stream.close();
			}
		
			// Decode the XML into a new User object
			return User.DecodeFromXML(userFile);
		}
		
		/** Build an XML fragment from the User object, and write it
		 * to the file specified by GetFileForUser.
		 * The file is created if it does not exists. */
		protected static function WriteUserXML(user:User):Boolean
		{
			var coder:XML;
			var userFile:File = GetFileForUser(user.username);
			
			// Add user infos to the XML file
			coder = new XML("<userProfile></userProfile>");
			coder = user.EncodeToXML(coder);
			
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