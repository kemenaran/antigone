package org.antigone.mediators
{
	import flash.events.Event;
	import flash.filesystem.*;
	
	import mx.core.Application;
	
	import org.antigone.controllers.*;
	import org.antigone.helpers.FormHelper;
	import org.antigone.events.UserEvent;
	import org.antigone.models.*;
	import org.antigone.views.LoginView;
	
	public class LoginMediator extends Mediator
	{
		/* A reference to the controlled view. */
		public var view:LoginView;
		
		protected var loginProvider:LoginProvider = Application.application.c.LoginProvider;
			
		public const kLoginErrorMessage:String = "loginErrorMessage";
		
		/* Convenience getter for the bound model defined in NewUserView. */
		public function get userModel():User
		{
			return this.view.userModel;
		}
		
		/* Check wether the supplied informations represents a valid user */
		public function PerformLogin():void
		{	
			// Try to connect the user.
			var userConnected:Boolean = this.loginProvider.ConnectUser(this.userModel);
			
			if (userConnected) {
				// Inform that we successfully connected the user
				this.view.dispatchEvent(new UserEvent(UserEvent.ConnectedEvent, this.loginProvider.currentUser));
				
				// Clear the form
				FormHelper.AutoResetForm(this.view);
			} else {
				// Show errors
				this.displayErrorMessage(kLoginErrorMessage);
			}
		}
		
		/* Send event when the "New User" button is clicked */
		public function NewUserClicked():void
		{
			FormHelper.AutoResetForm(this.view);
			view.dispatchEvent(new Event("newUserClicked"));
		}
		
		/* Display hints about the success of the login attemp */
		public function displayErrorMessage(messageType:String):void
		{
			view.loginButton.errorString = "";
			
			switch (messageType) {
				case kLoginErrorMessage:
					view.loginButton.errorString = "Non d'utilisateur ou mot de passe incorrect. " +
						" Veuillez réessayer.";
					break;
				default:
					trace("Message '" + messageType + "' is not defined.");
			}
		}
	}
}