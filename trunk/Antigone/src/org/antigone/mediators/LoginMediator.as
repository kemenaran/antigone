package org.antigone.mediators
{
	import flash.events.Event;
	import flash.filesystem.*;
	import mx.core.Application;
	
	import org.antigone.models.*;
	import org.antigone.controllers.*;
	import org.antigone.views.LoginView;
	import org.antigone.helpers.FormHelper;
	
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
		public function LoginFormSubmitted():void
		{
			var isLoginCorrect:Boolean;
			
			isLoginCorrect = this.loginProvider.ValidateUser(this.userModel.username, this.userModel.password);
			
			if (isLoginCorrect) {
				this.LoginSucceeded();
			} else {
				this.displayErrorMessage(kLoginErrorMessage);
			}
		}
		
		/* Triggered when a Login was successfully performed */
		protected function LoginSucceeded():void
		{
			// Retrieve the logged user and register it
			var loggedUser:User = this.loginProvider.GetUser(this.userModel.username);
			this.loginProvider.ConnectUser(loggedUser);
			
			// Clean the form
			FormHelper.AutoResetForm(this.view);
			
			// Inform that we successfully logged in
			view.dispatchEvent(new Event("loginSucceeded", true));
		}
		
		/* Send event when the "New User" button is clicked */
		public function NewUserClicked():void
		{
			FormHelper.AutoResetForm(this.view);
			view.dispatchEvent(new Event("newUserClicked", true));
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