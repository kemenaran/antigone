package org.antigone.helpers
{
	import flash.filesystem.*;
	
	/** Various helpers for working with XML data. */
	public class XMLHelper
	{
		/** Read an XML document and put the data in an XML object.
		 * @throw The file cannot be found.
		 */
		public static function ReadXMLFromFile(file:File):XML
		{
			var data:XML = null;
			var stream:FileStream = new FileStream();
			
			// if the file doesn't exist, you failed
			if (!file.exists)
				throw new Error("The file '" + file.nativePath + "' cannot be found.");
			
			// Read the file	
			try {
				stream.open(file, FileMode.READ);
		    	data = XML(stream.readUTFBytes(stream.bytesAvailable));
			} finally {
				stream.close();
			}
		
			// Decode the data 
			return data;	
		}
		
		/** Write XML data into a file. */ 
		public static function WriteXMLToFile(data:XML, file:File):void
		{
			// Build up the full XML data as a string
			var newXMLStr:String = "<?xml version=\"1.0\" encoding=\"UTF-8\"?>"
				+ File.lineEnding
				+ data.toXMLString();
				
			// Write XML to the file
			var fs:FileStream = new FileStream();
			try {
				fs.open(file, FileMode.WRITE);
				fs.writeUTFBytes(newXMLStr);
			} finally {
				fs.close();
			}
		}
		
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