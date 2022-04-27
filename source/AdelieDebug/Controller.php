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

abstract class AdelieDebug_Controller extends AdelieDebug_Core_Controller
{
	protected function _getTemplateValues()
	{
		$root =& XCube_Root::getSingleton();
		$isBuild = $this->app->isBuild();
		return array_merge(parent::_getTemplateValues(), array(
			'xoopsUrl'  => XOOPS_URL,
			'isBuild'   => $isBuild,
			'buildTime' => $this->app->getBuildTime(),
			'isAdmin'   => $root->mContext->mUser->isInRole('Site.Administrator'),
			'htmlDir'   => XOOPS_ROOT_PATH,
			'trustDir'  => XOOPS_TRUST_PATH,
			'sqlPrefix' => XOOPS_DB_PREFIX,
			'sourceDir' => $isBuild? '' : dirname(__FILE__, 2),
		));
	}
}
