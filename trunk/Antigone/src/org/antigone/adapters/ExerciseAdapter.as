package org.antigone.adapters
{
	import org.antigone.vos.Exercise;
	
	/** Adapter class for Exercises.
	 * Created for parity with CourseAdapter - but otherwise useless for now. */
	public class ExerciseAdapter extends ContentAdapter
	{
		[Bindable("representedObjectChanged")]
		/** Typped getter for representedObject. */
		public function get representedExercise():Exercise { return representedObject as Exercise; }
		
		/** Constructor. */
		public function ExerciseAdapter(representedObject:*=null)
		{
			super(representedObject);
		}	
	}
}