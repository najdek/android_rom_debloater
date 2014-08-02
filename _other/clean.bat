@echo off
if exist clean.bat (
color 4f
echo.
echo ERROR
echo.
echo This script should be started from Kitchen menu ..
echo.
echo.
pause >nul
exit
)

cls
echo.
echo.
echo IT WILL REMOVE CURRENT BASE ROM
echo.
echo IT WILL ALSO REMOVE ALL CREATED .ZIP PACKAGES...
echo.
echo.
pause


rmdir /S /Q out

if exist _other\CURRENT_BASE del _other\CURRENT_BASE
if exist overlay\THIS_BLOAT_DOES_NOT_EXIST.txt del overlay\THIS_BLOAT_DOES_NOT_EXIST.txt
if exist overlay\list.txt del overlay\list.txt
if exist overlay_theme\THESE_APPS_DONT_EXIST.txt del overlay_theme\THESE_APPS_DONT_EXIST.txt
if exist overlay_theme\THESE_FRAMEWORKS_DONT_EXIST.txt del overlay_theme\THESE_FRAMEWORKS_DONT_EXIST.txt
if exist overlay_theme\app-list.txt del overlay_theme\app-list.txt
if exist overlay_theme\framework-list.txt del overlay_theme\framework-list.txt

if exist *_mateo1111.zip del *_mateo1111.zip

rmdir /S /Q BASE

cls
echo.
echo.
echo DONE. Press any key to return to menu..
echo.
echo.
pause>nul