mateo1111's ROM Kitchen
==============

My batch script for fast debloating and customizing ROMS, 
I've tested it only with 4.3 Galaxy S3 ROMs, 
but it should work with every ROM (for every device) which uses simple .zip structure 
(only META-INF\, system\ and boot.img inside .zip package) 



Currently there's only batch version for Windows, maybe I'll make UNIX shell script soon..

.


At first start it will ask you for .zip package you want to use as base ROM.

For my current overlay for I9300 I recommend using JustArchi's stock I9300UBUGNE1:

http://forum.xda-developers.com/galaxy-s3/general/rom-justarchis-sammy-stock-deodex-root-t2833121

.


If you want to remove your current base ROM - use "clean.bat"
(this script will also delete all created .zip packages and clean working directories).




Overlays
--------------

Script is copying all content from sub-directories in overlay\ to out\ directory..
(see current look of overlay\ for example)




Debloat / remove not needed files
--------------

You can list all files you want to remove from ROM here:
*overlay\not_needed_files.txt*

**List one file in one line, like this:**

	system\app\Dropbox.apk
	
	system\app\Hangouts.apk
	
	system\app\SamsungApps.apk
	
	system\lib\libChatOnAMSImageFilterLibs-1.0.2.so
	
	system\app\ChatON_MARKET.apk
	
	
If you will change base ROM, and some files from debloat list will not exist anymore in new base,
they'll be automatically listed here:

*overlay\THESE_FILES_DONT_EXIST.txt*
