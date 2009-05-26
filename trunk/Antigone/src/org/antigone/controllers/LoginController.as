// ActionScript file
package org.antigone.controllers
{
	import org.antigone.models.User;
	import org.antigone.views.Login;
	
	public class LoginController
	{
		protected var model:ILoginProvider = new LocalLoginProvider();
		protected var view:Login;
		
		public function LoginController(view:Login)
		{
			this.view = view;
		}
		
		public function LoginFormSubmitted(user:User):void
		{
			var isLoginCorrect:Boolean;
			
			isLoginCorrect = this.model.ValidateUser(user.username, user.password);
			view.validateLogin(isLoginCorrect);		
		}
	}
}