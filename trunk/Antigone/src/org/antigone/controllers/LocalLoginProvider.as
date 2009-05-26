package org.antigone.controllers
{
	import org.antigone.models.User;
	
	public class LocalLoginProvider implements ILoginProvider
	{
		public function ValidateUser(username:String, password:String):Boolean
		{
			trace(username);
			trace(password);
			
			return true;
		}
		
		public function GetUser(username:String):User
		{
			return new User();
		}
		
		public function CreateUser(username:String, password:String):void {}
		public function UpdateUser(user:User):void {}
		public function DeleteUser(username:String):void {}
	}
}