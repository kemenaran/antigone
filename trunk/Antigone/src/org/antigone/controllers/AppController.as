package org.antigone.controllers
{
	import mx.core.Application;
	
	public class AppController
	{
		/* Shortcut getter for Application.application */
		protected function get app():Object
		{
			return Application.application;
		}
		
		/* On successful login, move to the next panel */
		public function loginSucceeded():void
		{
			app.viewstack.selectedChild = app.dashboardView;
		}
	}
}