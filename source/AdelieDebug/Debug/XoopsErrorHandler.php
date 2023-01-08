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

$reflectionMethod = new ReflectionMethod('XoopsErrorHandler', 'getInstance');

if ( $reflectionMethod->isStatic() === true )
{
	class AdelieDebug_Debug_XoopsErrorHandler extends XoopsErrorHandler
	{
		public function __construct()
		{
			// Block parent constructor processing
		}
		// must be compatible by & reference
		public static function &getInstance()
		{
			static $instance = null;

			if ( $instance === null )
			{
				$instance = new self();
			}

			return $instance;
		}

		public static function &getInstanceWrapper()
		{
			return self::getInstance();
		}
	}
}
else
{
	class AdelieDebug_Debug_XoopsErrorHandler extends XoopsErrorHandler
	{
		public function __construct()
		{
			// Block parent constructor processing
		}

		public function &getInstance()
		{
			static $instance = null;

			if ( $instance === null )
			{
				$instance = new self();
			}

			return $instance;
		}

		public static function &getInstanceWrapper()
		{
			$obj = new self();
			return $obj->getInstance();
		}
	}
}



