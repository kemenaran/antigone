package org.antigone.adapters
{
	import org.antigone.vos.Course;
	import org.antigone.vos.Exercise;
	import org.antigone.vos.LessonContent;
	
	/** Umbrella class for ExerciseAdapter and CourseAdapter. */
	public class ContentAdapter extends Adapter
	{
		[Bindable("representedObjectChanged")]
		/** Typped getter for representedObject. */
		public function get representedContent():LessonContent { return representedObject as LessonContent; }
		
		/** Constructor. */
		public function ContentAdapter(representedObject:*=null)
		{
			super(representedObject);
		}
		
		/** Create a subclass of ContentAdapter from the content given.
		 * For instance, given a Course, will create a CourseAdapter populated with the course's data. */
		public static function InitFromContent(content:LessonContent):ContentAdapter
		{
			if (content is Course)
				return new CourseAdapter(content as Course);
			else
			if (content is Exercise)
				return new ExerciseAdapter(content as Exercise);
			else
				throw new Error("Unsupported type.");
		}
	}
}