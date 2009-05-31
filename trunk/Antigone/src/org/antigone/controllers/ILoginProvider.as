package org.antigone.controllers
{
	import org.antigone.models.User;
	
	/* Interface to be used by concrete login providers. */
	public interface ILoginProvider
	{
		function UserExists(username:String):Boolean;
		function CreateUser(username:String, password:String):Boolean;
		function ValidateUser(username:String, password:String):Boolean;
		function GetUser(username:String):User;
		function UpdateUser(user:User):Boolean;
		function DeleteUser(username:String):Boolean;
	}
}