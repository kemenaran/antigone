package org.antigone.mediators
{
	import mx.core.WindowedApplication;
	import org.antigone.views.MainContainerView;
	
	/* Mediator for the MainContainer view. */
	public class MainContainerMediator extends Mediator
	{
		/* A reference to the controlled view */
		public var view:MainContainerView;
		
		/* When a Login is successfully performed, switch to the Dashboard. */
		public function LoginSucceeded():void
		{
			view.selectedChild = view.dashboardView;
		}
	}
}