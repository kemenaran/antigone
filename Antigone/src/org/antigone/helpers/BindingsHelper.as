package org.antigone.helpers
{
	import mx.events.PropertyChangeEvent;
	
	public class BindingsHelper
	{
		public static function DebugBinding(e:PropertyChangeEvent):void
		{
			trace("BindingDbg: " + e.property + " set to : " + e.newValue);
		}
	}
}