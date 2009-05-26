// ActionScript file
package org.antigone.controllers
{
	import flash.events.Event;
	
	import org.antigone.views.LoginView;
	
	public class LoginController
	{
		public var view:LoginView;
		public const kLoginSucceededEvent:String = "loginSucceeded";
		protected var model:ILoginProvider = new LocalLoginProvider();	
		
		/* Check wether the supplied informations represents a valid user */
		public function LoginFormSubmitted():void
		{
			var isLoginCorrect:Boolean;
			
			isLoginCorrect = this.model.ValidateUser(this.view.username.text, this.view.password.text);
			
			if (isLoginCorrect) {
				view.dispatchEvent(new Event("loginSucceeded"));
			} else {
				this.displayLoginMessage(isLoginCorrect);
			}
		}
		
		/* Display hints about the success of the login attemp */
		public function displayLoginMessage(isLoginCorrect:Boolean):void
		{		
			view.loginSuccessLabel.visible = isLoginCorrect;
			view.loginSuccessLabel.includeInLayout = isLoginCorrect;
			
			view.loginErrorLabel.visible = !isLoginCorrect;
			view.loginErrorLabel.includeInLayout = !isLoginCorrect;	
		}
	}
}