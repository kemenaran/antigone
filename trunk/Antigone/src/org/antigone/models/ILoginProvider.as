package org.antigone.models
{
	import org.antigone.models.User;
	
	/* Interface for generic login providers */
	public interface ILoginProvider
	{
		function UserExists(username:String):Boolean;
		function CreateUser(username:String, password:String):Boolean;
		function ValidateUser(username:String, password:String):Boolean;
		function GetUser(username:String):User;
		function UpdateUser(user:User):void;
		function DeleteUser(username:String):void;
	}
}