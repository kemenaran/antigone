package org.antigone.controllers
{
	import org.antigone.models.User;
	
	/* Used as a placeholder for the concrete ILoginprovider implementation
	 * used by the application.
	 * If you need to change the ILoginProvider provider, do it here. */
	public class LoginProvider extends LocalLoginProvider
	{
		[Bindable]
		public var currentUser:User;
	}
}