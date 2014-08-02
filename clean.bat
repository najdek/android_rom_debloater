@echo off
cls
echo.
echo IT WILL REMOVE CURRENT BASE ROM
echo IT WILL ALSO REMOVE ALL CREATED .ZIP PACKAGES...
pause


rmdir /S /Q out

if exist overlay\THIS_BLOAT_DOES_NOT_EXIST.txt del overlay\THIS_BLOAT_DOES_NOT_EXIST.txt
if exist overlay\list.txt del overlay\list.txt
if exist overlay_theme\THESE_APPS_DONT_EXIST.txt del overlay_theme\THESE_APPS_DONT_EXIST.txt
if exist overlay_theme\THESE_FRAMEWORKS_DONT_EXIST.txt del overlay_theme\THESE_FRAMEWORKS_DONT_EXIST.txt
if exist overlay_theme\app-list.txt del overlay_theme\app-list.txt
if exist overlay_theme\framework-list.txt del overlay_theme\framework-list.txt

del *_mateo1111.zip

rmdir /S /Q BASE

cls
echo.
echo DONE. Press any key to close..
pause>nul