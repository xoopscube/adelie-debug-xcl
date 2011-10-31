<?php
/**
 * A_simple_description_for_this_script.
 *
 * @package    AdelieDebugCompiler
 * @author     Suin <suinyeze@gmail.com>
 * @copyright  2011 Suin
 * @license    http://www.gnu.org/licenses/gpl-2.0.html GNU GPL v2
 *
 */

class AdelieDebugCompiler_Application
{
	protected $dir = '';

	protected $config = array(
		'phpCommand' => 'php',
		'outputFile' => 'build/AdelieDebug.class.php',
	);

	protected $temporaryFileManager = null;
	protected $syntaxChecker = null;

	protected $source = '';

	public function __construct(array $config = array())
	{
		$this->config = array_merge($this->config, $config);
	}

	public function __get($name)
	{
		return $this->$name;
	}

	public function setUp()
	{
		$this->_setUpPaths();
		$this->_setUpTemporaryFileManager();
		$this->_setUpSyntaxChecker();
	}

	public function run()
	{
		try
		{
			$this->_combinePhpFiles();
			$this->_combineConfigFiles();
			$this->_combineTemplateFiles();
			$this->_minimize();
			$this->_outputFile();
		}
		catch ( Exception $e )
		{
			echo $e;
			die(1);
		}
	}

	public function getResult()
	{
	}

	public function config($name)
	{
		return $this->config[$name];
	}

	protected function _setUpPaths()
	{
		$this->dir       = dirname(__FILE__);
		$this->targetDir = dirname(dirname(__FILE__)).'/AdelieDebug';
	}

	protected function _setUpTemporaryFileManager()
	{
		$this->temporaryFileManager = new AdelieDebugCompiler_TemporaryFileManager();
	}

	protected function _setUpSyntaxChecker()
	{
		$this->syntaxChecker = new AdelieDebugCompiler_SyntaxChecker($this);
	}

	protected function _combinePhpFiles()
	{
		$combiner = new AdelieDebugCompiler_Combiner_PHP($this);
		$combiner->run();
		$this->source .= $combiner->getContents();
	}

	protected function _combineConfigFiles()
	{
		$combiner = new AdelieDebugCompiler_Combiner_Config($this);
		$combiner->run();
		$this->source .= $combiner->getContents();
	}

	protected function _combineTemplateFiles()
	{
		$combiner = new AdelieDebugCompiler_Combiner_Template($this);
		$combiner->run();
		$this->source .= $combiner->getContents();
	}

	protected function _minimize()
	{
		$now    = time();
		$source = "<?php define('ADELIE_DEBUG_BUILD', true); define('ADELIE_DEBUG_BUILD_TIME', $now);".$this->source;
		$compresser = new AdelieDebugCompiler_Compresser($this);
		$this->source = $compresser->compressPHP($source);
	}

	protected function _outputFile()
	{
		$filename = $this->config('outputFile');
		$writtenBytes = file_put_contents($filename, $this->source);
		
		if ( $writtenBytes === false )
		{
			throw new RuntimeException("Failed to write file: $filename");
		}
	}
}
