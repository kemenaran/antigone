// ActionScript file
package org.antigone.controllers
{
	import flash.events.Event;
	import flash.filesystem.*;
	
	import org.antigone.models.*;
	import org.antigone.views.LoginView;
	
	public class LoginController
	{
		public var view:LoginView;
		protected var model:ILoginProvider = new LocalLoginProvider();
			
		public const kLoginErrorMessage:String = "loginErrorMessage";
		
		/* Check wether the supplied informations represents a valid user */
		public function LoginFormSubmitted():void
		{
			var isLoginCorrect:Boolean;
			
			isLoginCorrect = this.model.ValidateUser(this.view.username.text, this.view.password.text);
			
			if (isLoginCorrect) {
				view.dispatchEvent(new Event("loginSucceeded", true));
			} else {
				this.displayErrorMessage(kLoginErrorMessage);
			}
		}
		
		/* Send event when the "New User" button is clicked */
		public function NewUserClicked():void
		{
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