package org.antigone.models
{
	[Bindable]
	public class User
	{
		public var username:String;
		public var password:String;
		//public var progression:ProgressionStore;
		
		/* Create a new User object from an XML fragment.
		 * Returns the created User object, or null if there is an error.
		 */
		public static function decodeFromXML(coder:XML):User
		{
			var user:User = new User();
		
			if (coder == null)
				return null;
					
			user.username = coder.name;
			user.password = coder.password;
			
			return user;
		}
		
		/* Encode the current user into an XML fragment. */
		public function encodeToXML():XML
		{
			var coder:XML = new XML('<user></user>');
			coder.name = username;
			coder.password = password;
			
			return coder;
		}
	}
}