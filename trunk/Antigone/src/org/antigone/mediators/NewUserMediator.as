package org.antigone.mediators
{
	import flash.events.Event;
	import flash.filesystem.*;
	
	import mx.controls.Alert;
	import mx.core.Application;
	
	import org.antigone.controllers.*;
	import org.antigone.helpers.FormHelper;
	import org.antigone.events.UserEvent;
	import org.antigone.models.*;
	import org.antigone.views.NewUserView;
	
	
	/* Mediator for the NewUserView form. */
	public class NewUserMediator extends Mediator
	{
		/* A reference to the controlled view. */
		public var view:NewUserView;
		
		protected var loginProvider:ILoginProvider = Application.application.c.LoginProvider;
		
		protected const kUserExistsMessage:String = "userExistMessage";
		protected const kUserErrorMessage:String = "userErrorMessage";
		
		/* Convenience getter for the bound model defined in NewUserView. */
		public function get userModel():User
		{
			return this.view.userModel;
		}
		
		/* When the "Create User" button is clicked, try to register the
		 * user, and display any error message. */
		public function createUserClicked():void
		{	
			var success:Boolean;
			var updatedUser:User;
			
			// If the user already exists, give up
			if (loginProvider.UserExists(view.username.text)) {
				this.displayErrorMessage(kUserExistsMessage);
				return;
			}
				
			// Create the user
			success = loginProvider.CreateUser(userModel.username, userModel.password);
			if (success
				&& (updatedUser = loginProvider.UpdateUser(userModel)) != null) {
				
				// Display a welcome message				
				Alert.show("L'utilisateur a été correctement créé.\n\n" +
					"Bienvenue, " + updatedUser.GetDisplayName() + "!");
				
				// Clean the form
				FormHelper.AutoResetForm(this.view);
				
				// Notify that user creation is complete				
				view.dispatchEvent(new UserEvent(UserEvent.CreatedEvent, updatedUser));
				
			} else {
				this.displayErrorMessage(kUserErrorMessage);
			}	
		}
		
		/* When the "Cancel" button is clicked, reset the form and send an event. */
		public function cancelClicked():void
		{
			FormHelper.AutoResetForm(this.view);
			
			view.dispatchEvent(new Event('newUserCancel', true));
		}
		
		/* Display error messages based on class constants. */
		protected function displayErrorMessage(messageType:String):void
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
	}
}