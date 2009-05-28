package org.antigone.models
{
	/* Singleton class that allow access to a application-unique Login Provider.
	 * This is the visible interface of a class-cluster formed of various Login providers. */
	public class LoginProvider
	{
		/* Stores the unique Login Provider */
		protected static var __sharedLoginProvider:ILoginProvider;
		
		/* This class is a Singleton : throw an exception if someone tries to create
		 * an instance of it. */
		public function LoginProvider(){
			throw new Error("LoginProvider is a Singleton and cannot be instanciated. "
				+ "Use LoginProvider.sharedLoginProvider to retrive a login provider.");
		}
		
		/* Return the unique Login Provider.
		 * For now, LocalLoginProvider is used. If you need to change the
		 * Login Provider type, do it here.
		 */
		public static function get sharedLoginProvider():ILoginProvider
		{
			if (__sharedLoginProvider == null)
				__sharedLoginProvider = new LocalLoginProvider();
			
			return __sharedLoginProvider;
		}
	}
}