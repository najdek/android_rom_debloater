@echo off

if exist _other\kitchen_github del _other\kitchen_github
if not exist _other\kitchen goto START
_other\wget.exe -O _other\kitchen_github https://github.com/mateo1111/mateo1111_Kitchen/raw/master/_other/kitchen --no-check-certificate
if not exist _other\kitchen_github goto UPDATECHECK-ERROR

for /f "usebackq tokens=2 delims==" %%a in (`findstr version _other\kitchen`) do set version=%%a
for /f "usebackq tokens=2 delims==" %%a in (`findstr version _other\kitchen_github`) do set version_github=%%a
del _other\kitchen_github

if [%version_github%lolxD]==[lolxD] goto UPDATECHECK-ERROR
if %version%==%version_github% goto START
cls
echo.
echo NEW VERSION FOUND !
echo.
echo.
echo Newest version: %version_github%
echo Your current version: %version%
echo.
echo You can update Kitchen with git pull or clone/download repository again from:
echo https://github.com/mateo1111/mateo1111_Kitchen
echo.
echo.
echo Press any key to launch outdated version of Kitchen..
pause >nul
goto START


:UPDATECHECK-ERROR
cls
echo Error: Can't get info about updates
echo.
echo Skipping..
echo.
timeout 3
goto START


:START
set yyyy=%date:~0,4%
set yy=%date:~2,2%
set mm=%date:~5,2%
set dd=%date:~8,2%
set pdate=%yyyy%%mm%%dd%
color 0e



:MENU
cls
echo.
echo mateo1111's Kitchen
echo.
echo.
echo.
echo What you want to do ?
echo.
echo 1] Create new ROM
echo 2] Remove current BASE ROM
echo.
echo 3] Settings
echo.
echo.
set /p type=Choose (1-3) and confirm with ENTER: 
if %type% == 1 goto CHECK-BASE
if %type% == 2 goto CHANGE-BASE
if %type% == 3 goto SETTINGS
if [%type%haha]==[haha] goto MENU
goto MENU



:CHANGE-BASE
cls
if exist BASE\system\build.prop (
echo.
echo Current base ROM will be removed from Kitchen directory..
echo.
echo.
echo Press any key to remove current base ROM..
pause >nul
)
rmdir /S /Q BASE
cls
echo.
echo When you will choose option to create new ROM,
echo Kitchen will ask you for .zip package with new base ROM..
echo.
echo.
echo Press any key to return to menu..
pause >nul
goto MENU


:SETTINGS
cls
echo.
echo.
echo WORK IN PROGRESS...
echo.
echo.
echo Press any key to return to menu..
pause >nul
goto MENU




:CHECK-BASE
cls
if exist BASE\system\build.prop goto GET-BASE-INFO
echo.
echo.
echo.
echo Base ROM not found..
echo Move .zip with stock ROM to this window and press ENTER..
echo.
echo.
echo.
SET /P customzip=
cls
if [%customzip%lol]==[lol] goto CHECK-BASE
if %customzip%==%customzip:.zip=% (
echo This is not a .ZIP file 
pause
goto CHECK-BASE
)
echo.
echo.
echo You will use this ROM as new base:
echo %customzip%
echo.
echo.
echo.
pause
rmdir /S /Q BASE
mkdir BASE
_other\7za.exe x %customzip% -oBASE
echo.
echo.
goto CHECK-BASE


:GET-BASE-INFO
set buildprop=BASE\system\build.prop

for /f "usebackq tokens=2 delims==" %%a in (`findstr ro.build.id %buildprop%`) do set build_id=%%a
for /f "usebackq tokens=2 delims==" %%a in (`findstr ro.build.display.id %buildprop%`) do set display_id=%%a
for /f "usebackq tokens=2 delims==" %%a in (`findstr ro.build.version.incremental %buildprop%`) do set rom_version=%%a
for /f "usebackq tokens=2 delims==" %%a in (`findstr ro.build.version.release %buildprop%`) do set rom_android=%%a
for /f "usebackq tokens=2 delims==" %%a in (`findstr ro.product.model %buildprop%`) do set model=%%a
for /f "usebackq tokens=2 delims==" %%a in (`findstr ro.product.brand %buildprop%`) do set brand=%%a
for /f "usebackq tokens=2 delims==" %%a in (`findstr ro.product.device %buildprop%`) do set device=%%a


cls
echo.
echo.
echo This ROM will be used as base
echo.
echo.
echo %rom_version% (%build_id%)
echo Android %rom_android%
echo.
echo for device: %brand% %model% (%device%)
echo.
echo.
pause



:CLEAN
echo CLEANING..
rmdir /S /Q out
if exist overlay\THESE_FILES_DONT_EXIST.txt del overlay\THESE_FILES_DONT_EXIST.txt
if exist overlay\list.txt del overlay\list.txt

if exist %rom_version%_%pdate%_mateo1111.zip (
cls
echo %rom_version%_%pdate%_mateo1111.zip already exist..
echo.
echo Press any key to overwrite this file..
pause >nul
del %rom_version%_%pdate%_mateo1111.zip
)

:STOCK_TO_OUT
mkdir out
xcopy BASE out /e /y


:REMOVE_BLOATWARE

if not exist overlay\not_needed_files.txt (
echo.
echo.
echo File not found: overlay\not_needed_files.txt
echo Debloating will be skipped...
echo.
pause
goto OVERLAYS
)

for /f "delims=" %%f in (overlay\not_needed_files.txt) do (
if not exist out\%%f echo %%f>>overlay\THESE_FILES_DONT_EXIST.txt
if exist out\%%f del "out\%%f"
)

:OVERLAYS

for /f "usebackq tokens=*" %%a in (`dir /b/a:d overlay`) do (
    echo:%%~nxa
	echo:%%~nxa>>overlay\list.txt
)

for /f "delims=" %%f in (overlay\list.txt) do (
xcopy overlay\%%f out /e /y
)

if exist overlay\list.txt del overlay\list.txt

:ZIP
_other\7za.exe u -up0q0r2x2y2z1w2 -mx9 %rom_version%_%pdate%_mateo1111.zip ".\out\META-INF" ".\out\system" ".\out\boot.img"

:END
pause