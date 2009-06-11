package org.antigone.adapters
{
	import org.antigone.vos.User;
	
	[Bindable]
	public class UserToolboxAdapter
	{
		public var isUserConnected:Boolean;
		public var displayName:String;
		
		private var _currentUser:User;
		
		public function set currentUser(newUser:User):void
		{
			isUserConnected = !(newUser == null);
			
			if (isUserConnected) {
				displayName = newUser.GetDisplayName();
			} else {
				// The represented user data are not valid : reset all fields
				displayName = "";
			}
		}
	}
}