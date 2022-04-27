[![Project Status: Active – The project has reached a stable, usable state and is being actively developed.](https://www.repostatus.org/badges/2.0.0/active.svg)](https://github.com/xoopscube/xcl)
![License GPL](https://img.shields.io/badge/License-GPL-green)
![X-Updare Store](https://img.shields.io/badge/X--Update%20Store-Pending-red)

## ///// — Adelie Debug :: Debugging tool

![alt text](https://repository-images.githubusercontent.com/485308409/7da19feb-cc5b-43ae-bf66-6d8d24c9a2b7)
  

---

PRELOAD | Adelie Debug
------------ | -------------
Description | Adelie Debug is a powerful development tool for XCL modules, preloads and themes developers
Render Engine | Smarty v2
Version | 2022
Author | Update by @nao-pon Naoki Sawada (PHP7), @gigamaster Nuno Luciano (XCL7)
Author | Original by Suin (suin.io)
Copyright | 2011-2022 Authors
License | GPL


##### :computer: The Minimum Requirements



          Apache, Nginx, etc. PHP 7.2.x
          MySQL 5.6, MariaDB  InnoDB utf8 / utf8mb4
          XCL version 2.3.+



-----


### Features :


#### 1. Easy-to-read debug screen

* Timeline display: All PHP and SQL logs are aggregated in one timeline.  
  A device that makes it easier to understand the context of processing.
* Highlight errors: SQL and PHP errors are highlighted so they are visual.


### 2. Useful debug functions

* adump (mixed [, mixed, ...]): Enclose var_dump () in a pre tag to make it easier to see,   
  and even show where the function is written.
* atrace (): Traces the processing path. It's obvious where the function is called.
* awhich (object or class_name_string): Shows what line in which file a class or function is defined.
* asynop (object or class_name_string): Shows an overview of the class implementation.


### 3. Being a tool for XOOPS Cube Legacy

* You no longer need to add exit () after var_dump () or write <{stdout}> for the theme.   
  This is because AdelieDebug automatically bypasses the XOOPS ob_buffer.
* There is no such thing as var_dump () on the XML output screen that makes Ajax testing unsuccessful.  
  AdelieDebug automatically turns off debug output on AJAX requests and in contexts other than HTML output.

### 4. Must be a tool used in practice

* It's the tool developers use when developing modules at work.

For more detailed introductions (Japanese) :  
[XOOPS Cube & TOKYO Pen's powerful debugging tool AdelieDebug | @suin ] (https://suin.io/530).  
[XOOPS で AdelieDebug利用中はリダイレクト停止させる | @RyujiAMANO ] (http://suin.asia/2012/01/06/xoops-adelie-debug).


## Basic usage

### install

Just put the preload file **AdelieDebug.class.php** in the folder /html/preload/ 


### How to install with wget:

```
cd /path/to/your/xoopscube/html/preload
wget https://raw.github.com/suin/xoops-adelie-debug/master/build/AdelieDebug.class.php
```

### Uninstall

When you no longer need it, just remove the file **AdelieDebug.class.php** from the folder /html/preload/

## Setting

### ADELIE_DEBUG_ERROR_REPORTING

You can adjust the error reporting level of AdelieDebug by setting   
the constant `ADELIE_DEBUG_ERROR_REPORTING` in ` mainfile.php`   
If this constant is not set, it will be `error_reporting (-1)`  
That is, it notifies you of all errors.  

This setting should not be used.  
However, deprecation warnings and non-critical errors in legacy code of XOOPS2 modules   
doesn't make it easier to see more serious errors in PHP7 and later.     
You should adjust `ADELIE_DEBUG_ERROR_REPORTING` only if
it has a significant impact on efficiency in PHP7 development environment.  


```
	define('ADELIE_DEBUG_ERROR_REPORTING', E_ALL & ~E_DEPRECATED & ~E_STRICT);
```


## Compile

The following information is only relevant to those who want to customize AdelieDebug itself.

### Source code

The pre-build source code is in source.
It is convenient to use symbolic links during pre-build development.

```
ln -s ~/Projects/adelie-debug-xcl/source/AdelieDebug/Preload.php /var/www/html/preload/AdelieDebug_Preload.class.php
```


And everything should run just fine.

### Build

You can build it by running this on the command line :  
```
# php compile.php
```
The latest version of yuicompressor is placed in ~ /bin/yuicompressor-2.4.8.jar  
In case of issues with path, change the config to build with 2.4.7.jar  

## Tips

### Use adump () with Smarty

You can also dump the contents of a variable in a template :  
```<{$ variable | @adump}>```

### xContainer and xdesktop
Depending on your app stack version, Virtual Machine or BootDocker,  
both are running a customized debian distribution. Click "Open Shell"   
and install the required update of Java :

```
# apt-get update
```  
Then install Java :
```
# apt-get install default-jre
```  

? **Successfully updated**  
You will be prompt with a message of packages automatically installed   
and those who are no longer required.  
Use 'apt-get autoremove' to remove them.  
You will be prompt with a message :  
Do you want to continue? [Y/n]
In the interactive prompts, press **Y** and enter.

? **Error Message**

if you get an error message, try this :
```
# export LD_LIBRARY_PATH=/usr/lib/
# apt-get install openjdk-7-jre-headless
```    
  
Have Fun ^_^/
