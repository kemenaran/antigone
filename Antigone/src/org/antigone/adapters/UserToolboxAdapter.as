package org.antigone.adapters
{
	import org.antigone.vos.User;
	
	[Bindable]
	/** Adapter for the UserToolbox view. */
	public class UserToolboxAdapter extends Adapter
	{
		public var isUserConnected:Boolean;
		public var displayName:String;
		
		[Bindable("representedObjectChanged")]
		/** Typed getter. */
		public function get representedUser():User { return representedObject as User; }
		
		/** Constructor. */
		public function UserToolboxAdapter(user:User=null):void
		{
			super(user);
		}
		
		/** Called when the representedObject changes ; update represented data. */
		override protected function PopulateData(object:*):void
		{
			isUserConnected = !(representedUser == null);
			
			if (isUserConnected) {
				displayName = representedUser.GetDisplayName();
			} else {
				// The represented user data are not valid : reset all fields
				displayName = "";
			}
		}
	}
}