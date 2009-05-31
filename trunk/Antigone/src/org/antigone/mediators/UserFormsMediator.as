package org.antigone.mediators
{
	import org.antigone.views.UserFormsView;
	
	/* Mediator for the UserFormsView. */
	public class UserFormsMediator
	{
		/* A reference to the controlled view. */
		public var view:UserFormsView;
		
		/* When the NewUser button is clicked, switch tto the NewUserForm. */
		public function NewUserClicked():void
		{
			view.selectedChild = view.newUserView;	
		}
		
		/* When a user has been successfully created, switch back to the LoginForm. */
		public function NewUserCreated():void
		{
			view.selectedChild = view.loginView;
		}
		
		/* When a user cancel the user creation, switch back to the LoginForm. */
		public function NewUserCancel():void
		{
			view.selectedChild = view.loginView;
		}

	}
}