package org.antigone.business
{
	import org.antigone.vos.User;
	
	/* Interface to be used by concrete login providers. */
	public interface ILoginProvider
	{
		function UserExists(username:String):Boolean;
		function CreateUser(username:String, password:String):Boolean;
		function ValidateUser(username:String, password:String):Boolean;
		function GetUser(username:String):User;
		function UpdateUser(user:User):User;
		function DeleteUser(username:String):Boolean;
	}
}