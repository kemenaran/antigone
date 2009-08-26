package org.antigone.adapters
{
	import flash.events.Event;
	
	[Bindable]
	/** Abstract base class for all adapters.
	 * Features auto-populating data, handy constructor, and callback
	 * PopulateData method. */
	public class Adapter
	{
		protected var _representedObject:*;
		
		public function get representedObject():* { return _representedObject; }
		
		[Bindable("representedObjectChanged")]
		public function set representedObject(object:*):void
		{
			_representedObject = object;
			
			PopulateData(object); 
			dispatchEvent(new Event("representedObjectChanged"));
		}
		
		/** Called when the represented object is set. This method is intended to
		 * be overriden.
		 * The default implementation does nothing. */
		protected function PopulateData(object:*):void {}
		
		/** Constructor. */
		public function Adapter(representedObject:*=null)
		{
			if (representedObject != null)
				this.representedObject = representedObject; 
		}
	}
}