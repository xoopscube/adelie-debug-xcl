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

class AdelieDebug_Debug_ExceptionHandler_Abstract
{
	protected $logger = null;

	public function __construct(AdelieDebug_Debug_Logger $logger)
	{
		$this->logger = $logger;
	}

	public function register()
	{
		set_exception_handler(array($this, 'catchException'));
	}
}

if (class_exists('BaseException')) {

	class AdelieDebug_Debug_ExceptionHandler extends AdelieDebug_Debug_ExceptionHandler_Abstract
	{
		public function catchException(BaseException $exception)
		{
			$this->logger->addPhpError(strval($exception));
		}
	}

} else {

	class AdelieDebug_Debug_ExceptionHandler extends AdelieDebug_Debug_ExceptionHandler_Abstract
	{
		// #3 @gigamaster replaced Exception with Throwable
        public function catchException(\Throwable $exception)

		{
			$this->logger->addPhpError(strval($exception));
		}
	}

}
