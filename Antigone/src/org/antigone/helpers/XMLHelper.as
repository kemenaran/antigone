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
				
				else if (value is Boolean)
					element.@[key.toString()] = (value) ? "true" : "false";
				
				else if (object.propertyIsEnumerable(key as String))
					EncodeObjectToXML(value, element, key);
				
				else
					throw new Error("Unsupported type.");
			}
			
			return coder;
		}
		
		/** Recursively deserialize an XML structure into a string-indexed array (i.e. an Object).
		 * Basic types (String, Number) are stored in properties, nested elements in nested arrays. */
		public static function DecodeObjectFromXML(coder:XML):Object
		{
			var object:Object = new Object();
			
			// Decode element attributes (if any) 
			var attributes:XMLList = coder.attributes();
			for each(var attribute:XML in attributes){
				
					// Set the value as a String
					var key:String = attribute.name();
					var value:String = attribute.toString();
					object[key] = value;
					
					// Attempt to coerce values to specific types instead of String
					if (value == "true")
						object[key] = true;
					
					else if (value == "false")
						object[key] = false;
					
					else {
						try { object[key] = new Number(value) }
						catch (e:Error) { object[key] = value }
					}
			}
			
			// Decode child elements (if any)
			for each(var child:XML in coder.children()) {
				object[child.name()] = DecodeObjectFromXML(child);
			}
			
			return object;
		}
	}
}