package org.antigone.mediators
{
	import mx.core.Application;
	import org.antigone.views.MainContainerView;
	import org.antigone.controllers.LessonController;
	
	/* Mediator for the MainContainer view. */
	public class MainContainerMediator extends Mediator
	{
		/* A reference to the controlled view */
		public var view:MainContainerView;
		
		/* When a Login is successfully performed, switch to the Dashboard. */
		public function LoginSucceeded():void
		{
			var lessonController:LessonController = Application.application.c.LessonController;
			lessonController.LoadAllLessons();
			
			view.selectedChild = view.dashboardView;
		}
		
		/* When the User disconnects, switch to the LoginView. */
		public function UserDisconnected():void
		{
			view.selectedChild = view.loginView;
		}
	}
}