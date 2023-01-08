<?php
/**
 * A_simple_description_for_this_script.
 *
 * @package    AdelieDebug
 * @author     Suin <suinyeze@gmail.com>
 * @copyright  2011 Suin
 * @license    http://www.gnu.org/licenses/gpl-2.0.html GNU GPL v2
 *
 */

class AdelieDebug_Debug_Reporter_Html extends AdelieDebug_Debug_Reporter
{
	protected $reportable = null;

	public function setUp()
	{
		$this->reportable = new AdelieDebug_Debug_Reporter_Html_Reportable();
	}

	public function report()
	{
		if ( $this->reportable->isReportable() === false )
		{
			return;
		}

		$this->_printContents();
	}

	protected function _printContents()
	{
		// TODO >> If there is not enough memory, var_dump() is used for the bare minimum.
		$application = new AdelieDebug_Application();
		$application->setPathinfo('/debug/report');
		$application->setParameter('logger', $this->logger);
		$application->setParameter('via', __CLASS__);
		$application->setUp();
		$application->run();
		$result = $application->getResult();
		echo $result;
	}
}
