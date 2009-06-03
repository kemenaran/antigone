package org.antigone.mediators
{
	import flash.events.Event;
	
	import org.antigone.mediators.events.UserEvent;
	import org.antigone.views.UserFormsView;
	
	/* Mediator for the UserFormsView. */
	public class UserFormsMediator
	{
		/* A reference to the controlled view. */
		public var view:UserFormsView;
		
		/* When the NewUser button is clicked, switch tto the NewUserForm. */
		public function NewUserClicked(event:Event):void
		{
			view.selectedChild = view.newUserPanel;	
		}
		
		/* When a user has been successfully created, switch back to the LoginForm. */
		public function NewUserCreated(event:UserEvent):void
		{
			// Try to connect the new user right now
			if (event.user != null) {
				this.view.loginView.userModel = event.user;
				(this.view.loginView.mediator as LoginMediator).LoginFormSubmitted();
			}
			
			view.selectedChild = view.loginPanel;
		}
		
		/* When a user cancel the user creation, switch back to the LoginForm. */
		public function NewUserCancel(event:Event):void
		{
			view.selectedChild = view.loginPanel;
		}

	}
}