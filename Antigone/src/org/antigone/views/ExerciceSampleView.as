package org.antigone.views {

import flexlib.containers.FlowBox;
	
public class ExerciceSampleView extends FlowBox
{
	import flash.display.DisplayObject
	import mx.binding.utils.ChangeWatcher;
	import mx.controls.Label;
	import mx.controls.TextInput;
	import org.antigone.vos.ExerciseSample;
	
	[Bindable]
	/** A sentence from an Exercise. */
	public var sample:ExerciseSample;
	
	/** Observe changes to the "sample" property. */
	public function ExerciceSampleView():void
	{
		ChangeWatcher.watch(this, "sample", BuildSampleElements);
	}
	
	/** Auto-adjust the line height. */
	override protected function updateDisplayList( unscaledWidth:Number, unscaledHeight:Number ):void
	{
		super.updateDisplayList( unscaledWidth, unscaledHeight );
		
		// Auto adjust height
		var maxHeight:Number = 0;
		for each(var child:DisplayObject in this.getChildren()) {
			maxHeight = Math.max(maxHeight, child.y + child.height);
		}
		this.height = maxHeight;
	}
	
	/** When the sample changes, rebuild the elements tree. */
	public function BuildSampleElements(e:Event):void
	{
		// Split words of the sample
		var sampleWords:Array = sample.sentence.split(" ");
		
		// Add an element (label or textfield) for each word
		for each(var word:String in sampleWords) {
			
			var newElement:DisplayObject;
			
			switch (word) {
				case "%answer%":
					newElement = new TextInput();
					break;
				default:
					newElement = new Label();
					(newElement as Label).text = word;
			}
			
			this.addChild(newElement);
		}
	}
}
}