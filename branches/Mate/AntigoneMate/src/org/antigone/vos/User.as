package org.antigone.vos
{
	/* Model class representing a User. */
	[Bindable]
	public class User 
	{
		public var username:String;
		public var password:String;
		public var email:String;
		public var firstName:String;
		public var surname:String;
		public var school:String;
		
		public var progression:ProgressionStore = new ProgressionStore();
		
		/* Encode the current user into an XML fragment.
		 * Returns the XML fragment, with an added <user> node containing
		 * the user data. */
		public function EncodeToXML(coder:XML):XML
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
		
		/* Create a new User object from an XML fragment.
		 * Returns the created User object, or null if there is an error.
		 */
		public static function DecodeFromXML(coder:XML):User
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
		
		/* Check if the user is currently valid - for instance if it has a null or empty username. */
		public function IsValidUser():Boolean
		{
			return !(username == null || username == "" || password == null || password == "");
		}
	 
	 	/* This can be used as a convenient getter for GetDisplayName().
	 	 * You can bind to it, but beware : the data won't be refreshed automatically
	 	 * if one of the display name component (like the surname) changes.
	 	 */
		public function get displayName():String
		{
			return GetDisplayName();
		}
		 
		/* Returns a string suitable for displaying as a name.
		 * If possible, the firstName is used - or the username by default.
		 */
		public function GetDisplayName(longName:Boolean = false):String
		{			
			if (firstName != null && firstName != "" && firstName != "null") {
				return firstName + ((longName) ? surname : "");
			} else {
				return username.charAt(0).toLocaleUpperCase() + username.substr(1);
			}
		}
	}
}