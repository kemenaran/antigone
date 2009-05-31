package org.antigone.controllers
{
	import flash.utils.flash_proxy;
	import flash.utils.Dictionary;
	import flash.utils.Proxy;
	import flash.utils.getDefinitionByName;
	
	/* Stores and allow access to unique controller instances.
	 * It inherits Proxy to allow property-requests redirection .
	 *
	 * Usage:
	 *	controllerRegistry.loginController;
	 *	// Retrieve a unique Logincontroller, creating it if doesn't exist.
	 */
	public dynamic class ControllerRegistry extends Proxy
	{
		/* Stores controllers, indexed by Type. */
		protected var controllers:Dictionary = new Dictionary();
		
		/* Intercepts properties requests and return or create the matching
		 * controller.
		 * Returns the unique controller, or undefined if the controller cannot be created. */
		flash_proxy override function getProperty(name:*):*
		{
			var controllerType:Class;
			
			try {
				controllerType = getDefinitionByName("org.antigone.controllers." + name.toString()) as Class;
			} catch (e:Error) {
				return undefined;
			}
			
			if (this.controllers[controllerType] == null){
				this.controllers[controllerType] = new controllerType();
			}
			return this.controllers[controllerType];
		}
	}
}