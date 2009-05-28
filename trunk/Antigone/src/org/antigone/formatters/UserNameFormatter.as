package org.antigone.formatters
{
	import mx.formatters.Formatter;
	import org.antigone.models.User;

	/* Format the name of an User as an human-readable string. */
	public class UserNameFormatter extends Formatter
	{
		/* Call User::GetDisplayName() to get the formatted string. */
		override public function format(value:Object):String
		{
			return (value as User).GetDisplayName();
		}
	}
}