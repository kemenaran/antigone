package org.antigone.helpers
{
	import flash.display.DisplayObject;
	import flash.utils.getQualifiedClassName;
	
	import mx.containers.Form;
	import mx.controls.TextInput;
	import mx.core.Container;
	
	/* Collection of helper functions for working with Forms. */
	public class FormHelper
	{
		protected var _targetForm:Form;
		
		public function set targetForm(newTargetForm:Form):void
		{
			_targetForm = newTargetForm;
		}
		
		public function AutoResetForm():void
		{
			FormHelper.AutoResetForm(_targetForm);
		}
		
		/* Reset all the fields of a Form.
		 * For now, only TextInput fields are supported. */
		public static function AutoResetForm(form:Form):void
		{
			var fields:Array = FormHelper.FindFields(form);
			
			// For each TextInput field, clear the text and the error message
			if (fields.length > 0) {
				for each(var field:TextInput in fields) {
					field.text = "";
					field.errorString = "";
				}
			}
		}
		
		protected static function FindFields(container:Container):Array
		{
			var results:Array = new Array();
			var className:String;
			
			for each(var child:DisplayObject in container.getChildren()) {
				className = getQualifiedClassName(child);
				if (className.indexOf("TextInput") != -1)
					results.push(child);
				else if (className.match(/container/)) {
					results = results.concat(FindFields(child as Container));
				}
			}
			
			return results;
		}
	}
}