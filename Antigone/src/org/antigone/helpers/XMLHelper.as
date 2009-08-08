package org.antigone.helpers
{
	/** Various helpers for working with XML data. */
	public class XMLHelper
	{
		/** Recursively serialize a string-indexed array (i.e. an Object) into an XML structure.
		 * Basic types (String, Number) are stored in attributes, nested arrays in nested elements. */
		public static function EncodeObjectToXML(object:Object, coder:XML, elementName:String):XML
		{	
			// Create the root element
			coder.appendChild(XML("<" + elementName + "/>"));
			var element:XML = coder[elementName][0];
			
			for(var key:* in object) {
				var value:* = object[key];
				if (value is String || value is Number)
					element.@[key.toString()] = value;
				else if (value is Object)
					EncodeObjectToXML(value, element, key);
				else
					throw new Error("Unsupported type.");
			}
			
			return coder;
		}
	}
}