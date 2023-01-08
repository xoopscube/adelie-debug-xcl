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

/**
 * @property AdelieDebug_Debug_Logger $logger
 */
class AdelieDebug_Debug_Main
{
	/** @var AdelieDebug_Debug_Logger */
	protected $logger           = null;
	protected $errorHandler     = null;
	protected $exceptionHandler = null;
	protected $reporter         = null;
	protected $shutdown         = null;

	public function __construct()
	{
		// なんもしない
	}

	public function __isset($name)
	{
		return isset($this->$name);
	}

	public function __get($name)
	{
		return $this->$name;
	}

	public function run()
	{
		$this->enableErrorReporting();
		$this->_setUp();
	}

	public function enableErrorReporting()
	{
		if ( defined('ADELIE_DEBUG_ERROR_REPORTING') )
		{
			error_reporting(ADELIE_DEBUG_ERROR_REPORTING);
		}
		else
		{
			error_reporting(-1);
		}

		ini_set('log_errors', defined('ADELIE_DEBUG_LOG_ERRORS')? ADELIE_DEBUG_LOG_ERRORS : true);
		ini_set('display_errors', defined('ADELIE_DEBUG_DISPLAY_ERRORS')? ADELIE_DEBUG_DISPLAY_ERRORS : false);

		if ( defined('ADELIE_DEBUG_ERROR_LOG') )
		{
			ini_set('error_log', ADELIE_DEBUG_ERROR_LOG);
		}
	}

	protected function _setUp()
	{
		$this->_setUpLogger();
		$this->_setUpErrorHandler();
		$this->_setUpExceptionHandler();
		$this->_setUpReporter(); // If the Reporter is renewed at shutdown, it may have already run out of memory, so reserve memory in advance.
		$this->_setUpShutdown();
		$this->_setUpFunctions();
//		$this->_setUpDelegateManagerProxy();
	}

	protected function _setUpLogger()
	{
		$this->logger = new AdelieDebug_Debug_Logger();
	}

	protected function _setUpErrorHandler()
	{
		$this->errorHandler = new AdelieDebug_Debug_ErrorHandler($this->logger);
		$this->errorHandler->register();
	}

	protected function _setUpExceptionHandler()
	{
		$this->exceptionHandler = new AdelieDebug_Debug_ExceptionHandler($this->logger);
		$this->exceptionHandler->register();
	}

	protected function _setUpReporter()
	{
		$this->reporter = new AdelieDebug_Debug_Reporter_Html($this->logger); // TODO >> Allow setting of reporter type
		$this->reporter->setUp();
	}

	protected function _setUpShutdown()
	{
//		$consoleReporter = new AdelieDebug_Debug_Reporter_Console($this->logger);

		$this->shutdown = new AdelieDebug_Debug_Shutdown($this->logger);
		$this->shutdown->add(array($this->errorHandler, 'catchFatal'));
		$this->shutdown->add(array($this->reporter, 'report'));
//		$this->shutdown->add($consoleReporter);
		$this->shutdown->register();
	}

	protected function _setUpFunctions()
	{
		AdelieDebug_Debug_Dump::setLogger($this->logger);
		AdelieDebug_Debug_Trace::setLogger($this->logger);
		AdelieDebug_Debug_Synopsys::setLogger($this->logger);
		$this->_loadFunctions();
	}

	protected function _setUpDelegateManagerProxy()
	{
		$root = XCube_Root::getSingleton();
		$root->mDelegateManager = new AdelieDebug_Debug_DelegateManagerProxy($root->mDelegateManager, $this->logger);
	}

	protected function _loadFunctions()
	{
		if ( defined('ADELIE_DEBUG_BUILD') === true )
		{
			eval(AdelieDebug_Archive::$archive['/AdelieDebug/Debug/Function.php']);
		}
		else
		{
			require_once dirname(__FILE__).'/Function.php';
		}
	}
}
