package org.antigone.views.support
{
	import flash.events.Event;
	
	import mx.binding.utils.ChangeWatcher;
	import mx.controls.ToggleButtonBar;
	import mx.controls.buttonBarClasses.ButtonBarButton;
	import mx.events.ChildExistenceChangedEvent;
	
	/** Adds a new field to the dataProvider of a ToggleButtonBar : "enabled", which controls the state of the
	 * button. */
	public class EnabledToggleButtonBar extends ToggleButtonBar
	{
		/** Adds a new field to the dataProvider : "enabled", which controls the state of the
		 * button. */
		public override function set dataProvider(value:Object):void
		{
			super.dataProvider = value;
			UpdateEnabledStates();
		}
		
		/** Constructor. */
		public function EnabledToggleButtonBar()
		{
			// Watch for buttons creation
			addEventListener(ChildExistenceChangedEvent.CHILD_ADD, ButtonAdded);
		}
		
		/** When a new Button is added, set its correct state and register some events
		 * handlers. */
		protected function ButtonAdded(e:ChildExistenceChangedEvent):void
		{
			var button:ButtonBarButton = e.relatedObject as ButtonBarButton;
			
			SetButtonEnabled(button);
			
			// We want to be notified if the enabled status is modified by external code
			ChangeWatcher.watch(button, "enabled", WatchEnabledStatus);
		}
		
		/** The ToggleButtonBar often reset the "enabled" status of its buttons -
		 * we need to override this to restore our wanted status. */
		protected function WatchEnabledStatus(e:Event):void
		{
			SetButtonEnabled(e.target as ButtonBarButton);			
		}
		
		/** Refresh enabled status for all buttons. */
		protected function UpdateEnabledStates():void
		{
			var numChildren:uint = this.getChildren().length;
			for (var i:uint = 0; i < numChildren; i++) {
				SetButtonEnabled(this.getChildAt(i) as ButtonBarButton);
			}
		}
		
		/** Set the correct enabled status for one given button. */
		protected function SetButtonEnabled(button:ButtonBarButton):void
		{
			var buttonIndex:int = this.getChildIndex(button);
			
			try {
				button.enabled = dataProvider[buttonIndex]["enabled"] as Boolean;
			} catch (e:Error) {}
		}
	}
}