package org.antigone.mediators
{
	import mx.containers.ViewStack;
	import mx.core.Application;
	import mx.events.*;
	import mx.controls.Alert;
	
	import org.antigone.controllers.*;
	import org.antigone.events.LessonEvent;
	import org.antigone.views.MainContainerView;
	
	/* Mediator for the MainContainer view. */
	public class MainContainerMediator extends Mediator
	{
		/* A reference to the controlled view */
		public var view:MainContainerView;
		
		public function get mainViewStack():ViewStack
		{
			return this.view.mainViewStack;
		}
		
		/* When a Login is successfully performed, switch to the Dashboard. */
		public function LoginSucceeded():void
		{
			var lessonController:LessonController = Application.application.c.LessonController;
			lessonController.LoadAllLessons();
			
			mainViewStack.selectedChild = view.dashboardView;
		}
		
		public function LessonSelected(event:LessonEvent):void
		{
			view.lessonView.model = event.lesson;
			
			mainViewStack.selectedChild = view.lessonView;
		}
		
		/* When the User disconnects, switch to the LoginView. */
		public function UserDisconnected():void
		{
			mainViewStack.selectedChild = view.loginView;
		}
		
		/* When the user request to be disconnected, ask for a confirmation. */
		public function DisconnectButtonClicked():void
		{
			var a:Alert = Alert.show("Êtes-vous sûr de vouloir vous déconnecter ?",
			                         "Confirmation",
			                         Alert.YES | Alert.NO,
			                         this.view,
			                         DisconnectConfirmHandler,
			                         null,
			                         Alert.NO);
		}
		
		/* If the user confirms deconnection, disconnect. */
		protected function DisconnectConfirmHandler(event:CloseEvent):void
		{
			// If the user clicked the YES confirm button…
			if (event.detail == Alert.YES) {
				
				// Disconnect
				var controller:LoginProvider = Application.application.c.LoginProvider;
				controller.DisconnectUser();
				
				//view.dispatchEvent(new Event("userDisconnected", true));
				this.UserDisconnected();
			}
		}
	}
}