package org.antigone.controllers
{
	import org.antigone.models.User;
	
	/* Interface for generic login providers */
	public interface ILoginProvider
	{
		function CreateUser(username:String, password:String):void;
		function ValidateUser(username:String, password:String):Boolean;
		function GetUser(username:String):User;
		function UpdateUser(user:User):void;
		function DeleteUser(username:String):void;
	}
}