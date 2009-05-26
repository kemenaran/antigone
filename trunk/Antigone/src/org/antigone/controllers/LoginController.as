// ActionScript file
package org.antigone.controllers
{
	import org.antigone.models.User;
	
	public class LoginController
	{
		protected var model:ILoginProvider = new LocalLoginProvider();
		
		public function LoginFormSubmitted(user:User):void
		{
			this.model.ValidateUser(user.username, user.password);
		}
	}
}