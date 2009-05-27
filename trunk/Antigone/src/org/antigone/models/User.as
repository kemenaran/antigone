package org.antigone.models
{
	[Bindable]
	public class User
	{
		public var username:String;
		public var password:String;
		public var email:String;
		public var firstName:String;
		public var surname:String;
		public var school:String;
		//public var progression:ProgressionStore;
		
		/* Create a new User object from an XML fragment.
		 * Returns the created User object, or null if there is an error.
		 */
		public static function decodeFromXML(coder:XML):User
		{
			var user:User = new User();
		
			if (coder == null)
				return null;
					
			user.username = coder.user.name;
			user.password = coder.user.password;
			user.email = coder.user.email;
			user.firstName = coder.user.firstName;
			user.surname = coder.user.surname;
			user.school = coder.user.school;
			
			return user;
		}
		
		/* Encode the current user into an XML fragment.
		 * Returns the XML fragment, with an added <user> node containing
		 * the user data. */
		public function encodeToXML(coder:XML):XML
		{
			if (coder == null)
				return null;
			
			coder.user.name = username;
			coder.user.password = password;
			coder.user.email = email;
			coder.user.firstName = firstName;
			coder.user.surname = surname;
			coder.user.school = school;
			
			return coder;
		}
		
		/* Check if the user is currently valid - for instance if it has a null or empty username. */
		public function IsValidUser():Boolean
		{
			return !(username == null || username == "" || password == null || password == "");
		}
	}
}