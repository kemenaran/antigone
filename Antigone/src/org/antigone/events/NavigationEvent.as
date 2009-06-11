package org.antigone.events
{
	import flash.events.Event;

	public class NavigationEvent extends Event
	{
		/* Constants */
		
		public static const DASHBOARD: String = "dashboardNavigationEvent";
		public static const LOGIN: String     = "loginNavigationEvent";
		public static const NEW_USER: String  = "newUserNavigationEvent";
		
		/* Constructor */	
		public function NavigationEvent(type:String, bubbles:Boolean=true, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
		
	}
}