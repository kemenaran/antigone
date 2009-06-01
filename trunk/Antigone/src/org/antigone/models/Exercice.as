package org.antigone.models
{
	public class Exercice
	{
		public var title:String;
		
		public static function DecodeFromXML(coder:XML):Exercice
		{
			var exercice:Exercice = new Exercice();
			
			if (coder == null)
				return null;
				
			exercice.title = coder.@title;
			
			return exercice;
		}

	}
}