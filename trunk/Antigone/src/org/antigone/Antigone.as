// Extends WindowedApplication
import org.antigone.controllers.ControllerRegistry;

protected var _c:ControllerRegistry = new ControllerRegistry();

/* Retrieve an unique reference to a specific controller.
 * The controller is created if it does not exists yet.
 */
public function get c():ControllerRegistry
{
	return _c;
}