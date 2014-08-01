@echo off
cls
echo.
echo IT WILL REMOVE CURRENT BASE ROM
echo IT WILL ALSO REMOVE ALL CREATED .ZIP PACKAGES...
pause


rmdir /S /Q out

if exist overlay\THIS_BLOAT_DOES_NOT_EXIST.txt del overlay\THIS_BLOAT_DOES_NOT_EXIST.txt
if exist overlay\list.txt del overlay\list.txt

del *_mateo1111.zip

rmdir /S /Q BASE

cls
echo.
echo DONE. Press any key to close..
pause>nul