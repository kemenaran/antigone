package org.antigone.mediators
{
	import flash.events.Event;
	import mx.events.CloseEvent;
	import mx.controls.Alert;
	import mx.core.Application;
	
	import org.antigone.controllers.LoginProvider;
	import org.antigone.views.DashboardView;
	
	/* Mediator for the DashboardView */
	public class DashboardMediator extends Mediator
	{
		/* Reference to the controller view. */
		public var view:DashboardView;

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