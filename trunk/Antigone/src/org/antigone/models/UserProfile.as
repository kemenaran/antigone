package org.antigone.models
{	
	import flash.events.Event;
	import mx.core.Application;
	
	/* Singleton class user to store various user settings */
	public class UserProfile
	{
		/* Stores the unique User*/
		protected static var __loggedUser:User;
		
		/* This class is a Singleton : throw an exception if someone tries to create
		 * an instance of it. */
		public function UserProfile(){
			throw new Error("UserProfile is a Singleton and cannot be instanciated. "
				+ "Use UserProfile.sharedUser to retrieve a unique User object.");
		}
		
		/* Return the unique User. */
		public static function get loggedUser():User
		{
			if (__loggedUser == null)
				__loggedUser = new User();
			
			return __loggedUser;
		}
		
		/* Set the unique User.
		 * The manual binding event is here because auto-binding cannot be done with
		 * static methods. */
		[Bindable(event="loggedUserChanged")]
		public static function set loggedUser(newUser:User):void
		{
			__loggedUser = newUser;
			Application.application.dispatchEvent(new Event("loggedUserChanged", true));
		}
	}
}