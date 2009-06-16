package org.antigone.vos
{
	/* Abstract subclass for all lesson content : courses, exercises, etc. */
	[Bindable]
	public class LessonContent
	{
		/* Position of this content item within the lesson. */
		public var position:uint;
		
		/* Title of the content item */
		public var title:String;
	}
}