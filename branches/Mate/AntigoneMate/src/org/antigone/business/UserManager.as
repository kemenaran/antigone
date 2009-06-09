package org.antigone.business
{
	import org.antigone.events.*;
	import org.antigone.models.User;
	
	public class UserManager extends Manager
	{
		[Bindable]
		public var currentUser:User;
		
		protected var loginProvider:LocalLoginProvider = new LocalLoginProvider();
		
		/* Constructor */
		public function UserManager(dispatcher:IEventDispatcher)
		{
			super(dispatcher);
		}
		
		/* When the "Create User" button is clicked, try to register the
		 * user, and display any error message. */
		public function CreateUser(newUser:User):Boolean
		{	
			var success:Boolean;
			var updatedUser:User;
			
			// If the user already exists, give up
			if (loginProvider.UserExists(newUser.username))
				return false;
				
			// Create the user
			success = loginProvider.CreateUser(newUser.username, newUser.username);
			if (success
				&& (updatedUser = loginProvider.UpdateUser(newUser)) != null) {
				
				// Notify that user creation is complete
				var event:UserEvent = new UserEvent(UserEvent.NEW_USER_SUCCESSFUL);
				event.user = updatedUser;
				dispatcher.dispatchEvent(event);
				
				return true;
				
			} else {
				return false;
			}				
		}
		
		public function ConnectUser(user:User):Boolean
		{
			// Check user credentials
			if (loginProvider.ValidateUser(user.username, user.password)) {
				
				// Retrieve the user and register it
				this.currentUser = loginProvider.GetUser(user.username);
				
				// Notify of our tremendous success at connecting the user
				var event:UserEvent = new UserEvent(UserEvent.LOGIN_SUCCESSFUL);
				event.user = this.currentUser;
				dispatcher.dispatchEvent(event);
				
				return true;
				
			} else {
				
				// The user's credentials are invalid
				return false;
			}
		}
		
		public function DisconnectUser():Boolean
		{
			// Save the user that was previously connected
			var previousUser:User = this.currentUser;
			
			// Unregister the user
			this.currentUser = null;
			
			// Notify that the user disconnected
			var event:UserEvent = new UserEvent(UserEvent.LOGOUT_SUCCESSFUL);
			event.user = previousUser;
			dispatcher.dispatchEvent(event);
			
			return true;
		}

	}
}