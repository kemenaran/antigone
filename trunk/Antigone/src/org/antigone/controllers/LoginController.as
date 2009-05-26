// ActionScript file
package org.antigone.controllers
{
	import org.antigone.views.LoginView;
	
	public class LoginController
	{
		protected var view:LoginView;
		protected var model:ILoginProvider = new LocalLoginProvider();
		
		/* Controller constructor
		 * Intended to be called from LoginView.
		 */
		public function LoginController(view:LoginView)
		{
			this.view = view;
		}		
		
		/* Check wether the supplied informations represents a valid user */
		public function LoginFormSubmitted():void
		{
			var isLoginCorrect:Boolean;
			
			isLoginCorrect = this.model.ValidateUser(this.view.username.text, this.view.password.text);
			
			this.displayLoginMessage(isLoginCorrect);	
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