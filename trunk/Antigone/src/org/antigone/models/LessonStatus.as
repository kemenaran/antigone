package org.antigone.models
{
	/* Enumeration for Lesson::status. */
	public final class LessonStatus
	{
		/* The lesson hasn't been ever touched. */
		public static const Untouched:int    = 0;
		
		/* Exercise stage one has not been passed. */
		public static const NotLearned:int   = 2;
		
		/* Excercise stage two has been passed */
		public static const BeingLearned:int = 3;
		
		/* Exercise stage three has been passed, lesson is OK. */
		public static const Learned:int     = 4;
		
	}
}