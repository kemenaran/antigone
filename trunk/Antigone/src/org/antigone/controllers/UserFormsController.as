package org.antigone.controllers
{
	import org.antigone.views.UserFormsView;
	
	public class UserFormsController
	{
		public var view:UserFormsView;
		
		public function NewUserClicked():void
		{
			view.selectedChild = view.newUserView;	
		}
		
		public function NewUserCreated():void
		{
			view.selectedChild = view.loginView;
		}
		
		public function NewUserCancel():void
		{
			view.selectedChild = view.loginView;
		}

	}
}