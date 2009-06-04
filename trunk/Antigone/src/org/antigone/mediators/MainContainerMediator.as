package org.antigone.mediators
{
	import mx.core.Application;
	
	import org.antigone.controllers.LessonController;
	import org.antigone.events.LessonEvent;
	import org.antigone.views.MainContainerView;
	
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
		
		public function LessonSelected(event:LessonEvent):void
		{
			view.lessonView.model = event.lesson;
			
			view.selectedChild = view.lessonView;
		}
		
		/* When the User disconnects, switch to the LoginView. */
		public function UserDisconnected():void
		{
			view.selectedChild = view.loginView;
		}
	}
}