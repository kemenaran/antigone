package org.antigone.business
{
	import flash.events.IEventDispatcher;
	
	/* Abstract class for Managers - used mainly to declare an IEventDispatcher.
	 * The best way to retrieve a suitable EventDispatcher is to use "scope.dispatcher"
	 * in an <ObjectBuilder> declaration, in the EventMap. */
	public class Manager
	{
		protected var dispatcher:IEventDispatcher;
		
		public function Manager(dispatcher:IEventDispatcher)
		{
			this.dispatcher = dispatcher;
		}
	}
}