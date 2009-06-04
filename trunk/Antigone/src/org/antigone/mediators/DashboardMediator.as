package org.antigone.mediators
{
	import flash.events.Event;
	
	import mx.controls.Alert;
	import mx.core.Application;
	import mx.events.*;
	
	import org.antigone.controllers.LessonController;
	import org.antigone.controllers.LoginProvider;
	import org.antigone.events.LessonEvent;
	import org.antigone.models.Lesson;
	import org.antigone.views.DashboardView;
	import org.antigone.views.LessonItemRenderer;
	
	/* Mediator for the DashboardView */
	public class DashboardMediator extends Mediator
	{
		/* Reference to the controller view. */
		public var view:DashboardView;

		/* When a lesson item is clicked, dispatch a "lessonSelected" event. */
		public function LessonClicked(event:ListEvent):void
		{
			var item:LessonItemRenderer;
			var lesson:Lesson;
			var controller:LessonController = Application.application.c.LessonController;
			
			// Retrieve the Lesson associated to the item clicked
			item = event.itemRenderer as LessonItemRenderer;
			lesson = controller.GetLessonById(item.lessonId.text);
			
			// Dispatch the event
			this.view.dispatchEvent(new LessonEvent(LessonEvent.LessonSelectedEvent, lesson));
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
				
				view.dispatchEvent(new Event("userDisconnected", true));
			}
		}
	}
}