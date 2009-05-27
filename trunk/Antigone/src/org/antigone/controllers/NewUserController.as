package org.antigone.controllers
{
	import flash.events.Event;
	import flash.filesystem.*;
	import org.antigone.models.*;
	import org.antigone.views.NewUserView;
	
	public class NewUserController
	{
		public var view:NewUserView;
		protected var model:ILoginProvider = new LocalLoginProvider();
		
		public const kUserExistsMessage:String = "userExistMessage";
		public const kUserErrorMessage:String = "userErrorMessage";
		
		public function createUserClicked():void
		{	
			var success:Boolean;
			
			if (model.UserExists(view.username.text)) {
				
				// Aouch - the user already exists
				this.displayErrorMessage(kUserExistsMessage);
				
			} else {
				
				// The user doesn't exist already, let's create it
				success = model.CreateUser(view.username.text, view.password.text);
				if (success) {
					// TODO : Update user with full infos
					view.dispatchEvent(new Event('newUserCreated', true));
				} else {
					this.displayErrorMessage(kUserErrorMessage);
				}	
			}
		}
		
		public function cancelClicked():void
		{
			this.ResetForm();
			view.dispatchEvent(new Event('newUserCancel', true));
		}
		
		public function displayErrorMessage(messageType:String):void
		{
			view.username.errorString = "";
			view.createButton.errorString = "";
			
			switch(messageType) {
				case kUserExistsMessage:
					view.username.errorString = "Ce nom d'utilisateur existe " + 
							"déjà. Veuillez en choisir un autre.";
					break;
				case kUserErrorMessage:
					view.createButton.errorString = "Erreur lors de la création" +
							"de l'utilisateur. Veuillez réessayer.";
					break;
				default:
					trace("Message '" + messageType.toString() + "' not implemented.");
			}
		}
		
		public function ResetForm():void
		{
			view.username.text = "";
			view.password.text = "";
			view.email.text = "";
			view.firstName.text = "";
			view.surname.text = "";
			view.school.text = "";
		}
	}
}