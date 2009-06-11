package org.antigone.events
{
	import flash.events.Event;
	
	import org.antigone.vos.User;

	public class UserEvent extends Event
	{
		/* Constants */
		public static const LOGIN: String 			= "loginEvent";
		public static const LOGIN_SUCCESSFUL:String = "loginSuccessfulEvent";
		public static const LOGOUT: String 			= "logoutEvent";
		public static const LOGOUT_SUCCESSFUL: String = "logoutSuccessfulEvent";
		public static const NEW_USER: String        = "newUserEvent";
		public static const NEW_USER_SUCCESSFUL:String = "newUserSuccessfulEvent";
		
		/* Properties */
		public var user:User;

		/* Constructor */
		public function UserEvent(type:String, bubbles:Boolean=true, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
		
	}
}