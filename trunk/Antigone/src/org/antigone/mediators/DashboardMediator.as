package org.antigone.mediators
{
	import flash.events.Event;
	import mx.core.Application;
	
	import org.antigone.controllers.LoginProvider;
	import org.antigone.views.DashboardView;
	
	/* Mediator for the DashboardView */
	public class DashboardMediator extends Mediator
	{
		public var view:DashboardView;
		
		public function DisconnectButtonClicked():void
		{
			var controller:LoginProvider = Application.application.c.LoginProvider;
			controller.DisconnectUser();
			
			view.dispatchEvent(new Event("userDisconnected", true));
		}
	}
}