package org.antigone.controllers
{
	import mx.core.Application;
	
	import org.antigone.mediators.events.UserEvent;
	import org.antigone.models.User;
	
	/* Used as a placeholder for the concrete ILoginprovider implementation
	 * used by the application.
	 * If you need to change the ILoginProvider provider, do it here. */
	public class LoginProvider extends LocalLoginProvider
	{
		[Bindable]
		public var currentUser:User;
		
		public function ConnectUser(user:User):Boolean
		{
			// Check user credentials
			if (this.ValidateUser(user.username, user.password)) {
				
				// Retrieve the user and register it
				this.currentUser = this.GetUser(user.username);
				
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
			
			// Inform that we successfully disconnected the user
			Application.application.dispatchEvent(new UserEvent(UserEvent.DisconnectedEvent, previousUser));
			
			return true;
		}
	}
}