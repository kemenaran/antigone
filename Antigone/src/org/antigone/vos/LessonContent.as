package org.antigone.vos
{
	[Bindable]
	/** Abstract subclass for all lesson content : courses, exercises, etc. */
	public class LessonContent
	{
		/** Position of this content item within the lesson. */
		public var position:uint;
		
		/** Title of the content item */
		public var title:String;
		
		/** A reference to the lesson object containing this content.
		 * May be null. */
		public var parent:Lesson;
	}
}