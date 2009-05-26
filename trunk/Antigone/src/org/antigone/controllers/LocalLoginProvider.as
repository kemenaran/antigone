package org.antigone.controllers
{
	import flash.filesystem.*;
	
	import org.antigone.models.User;
	
	public class LocalLoginProvider implements ILoginProvider
	{	
		public function ValidateUser(username:String, password:String):Boolean
		{
			var userData:XML;
			var userFile:File = new File();
			
			// Create a file reference to the file
			var path:String = File.applicationStorageDirectory.nativePath + "/Users/" + username + ".xml";
			userFile = new File();
			userFile = userFile.resolvePath(path);
			
			// If the file doesn't even exists, the user is invalid
			if (!userFile.exists)
				return false;
			
			// Now read the data from the file
			userData = this.ReadUserFile(userFile);
			
			// Check that username and password match
			var tmp:String = userData.name;
			return (userData != null
			    && userData.name == username
			    && userData.password == password);
		}
		
		public function GetUser(username:String):User
		{
			return new User();
		}
		
		public function CreateUser(username:String, password:String):void {}
		public function UpdateUser(user:User):void {}
		public function DeleteUser(username:String):void {}
		
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