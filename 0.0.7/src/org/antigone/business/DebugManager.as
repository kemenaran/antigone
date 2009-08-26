package org.antigone.business
{
	import flash.events.IEventDispatcher;
	
	import mx.core.Application;
	
	import org.antigone.events.UserEvent;
	import org.antigone.vos.User;
	
	/* Debugger central point.
	 * Helpfull to manage debug tasks from the EventMap. */
	public class DebugManager extends Manager
	{
		public function DebugManager(dispatcher:IEventDispatcher=null):void
		{
			if (dispatcher == null) dispatcher = Application.application as IEventDispatcher;
			super(dispatcher);
		}
		
		CONFIG::debug
		public function ConnectUser(username:String, password:String):void
		{
			var user:User = new User();
			user.username = username;
			user.password = password;
			
			dispatcher.dispatchEvent(new UserEvent(UserEvent.LOGIN, user)); 
		}

	}
}