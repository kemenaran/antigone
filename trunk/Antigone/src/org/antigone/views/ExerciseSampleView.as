package org.antigone.views {

import flash.utils.Dictionary;
import flexlib.containers.FlowBox;
import org.antigone.vos.ExerciseAnswer;

/** Display a sample from a Exercise in a flow-resizable box. */
public class ExerciseSampleView extends FlowBox
{
	import flash.display.DisplayObject
	import mx.binding.utils.ChangeWatcher;
	import mx.controls.Label;
	import mx.controls.TextInput;
	import org.antigone.vos.ExerciseSample;
	
	[Bindable]
	/** The sample that must be displayed. */
	public var sample:ExerciseSample;
	
	[Bindable]
	/** Wheather to show the error messages and halos around the controls. */
	public var showValidation:Boolean = false;
	
	/** A list of all the editable controls of the sample. */
	protected var answerElements:Dictionary = new Dictionary();
	
	/** Observe changes to the "sample" property. */
	public function ExerciseSampleView():void
	{
		ChangeWatcher.watch(this, "sample", BuildSampleElements);
		ChangeWatcher.watch(this, "showValidation", ApplyValidation);
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
		this.height = maxHeight + getStyle("paddingBottom");
	}
	
	/** When the sample changes, rebuild the elements tree. */
	public function BuildSampleElements(e:Event):void
	{
		// Split words of the sample
		var sampleWords:Array = sample.sentence.split(" ");
		
		// Add an element (label or textfield) for each word
		for each(var word:String in sampleWords) {
			
			var newElement:DisplayObject;
			var answersIndex:Number = 0;
						
			switch (word) {
				case "%answer%":
					newElement = new TextInput();
					ChangeWatcher.watch(newElement, "text", AnswerChanged);
					break;
				default:
					newElement = new Label();
					(newElement as Label).text = word;
			}
			
			this.addChild(newElement);
			
			if (!(newElement is Label)) {
				 answerElements[newElement] = sample.answers[answersIndex];
				 answersIndex++;
			}
		}
	}
	
	/** Update the given answer with the value of an UI item. */
	protected function AnswerChanged(e:Event):void
	{
		var source:TextInput = (e.target as TextInput);
		
		var answer:ExerciseAnswer = answerElements[source];
		answer.given = source.text;
	}
	
	/** Changes the visual status of answers, based on the validation result. */
	protected function ApplyValidation(e:Event):void
	{
		var error:String;
		var answer:ExerciseAnswer;
		
		for(var answerElement:* in answerElements) {
			answer = answerElements[answerElement];
			error = (this.showValidation && !answer.isAnswerCorrect) ? "Mauvaise réponse" : "";
			(answerElement as TextInput).errorString = error;
		}
	}
}
}