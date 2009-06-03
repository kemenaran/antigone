package org.antigone.mediators.events
{
	import flash.events.Event;
	
	import org.antigone.models.User;

	public class UserEvent extends Event
	{
		/* The user concerned by the event */
		public var user:User;
		
		/* EventType constants */
		public static const ConnectedEvent:String = "userConnected";
		public static const DisconnectedEvent:String = "userDisconnected";
		public static const CreatedEvent:String = "userCreated";
		
		public function UserEvent(type:String, user:User, bubbles:Boolean=true)
		{
			super(type, bubbles, false);
			this.user = user;
		}
		
		public override function clone():Event
		{
			var newEvent:UserEvent = super.clone() as UserEvent;
			newEvent.user = this.user;
			
			return newEvent;
		}
		
		public override function toString():String
		{
			return formatToString("LoginEvent", "type", "bubbles", "cancelable", "eventPhase", "message");
		}		
	}
}