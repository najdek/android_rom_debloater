@echo off
color 0c
mode con:cols=80 lines=27
if exist _other\kitchen_github del _other\kitchen_github
if not exist _other\kitchen (
set version=unknown
goto START
)
_other\wget.exe -O _other\kitchen_github https://github.com/mateo1111/mateo1111_Kitchen/raw/master/_other/kitchen --no-check-certificate
if not exist _other\kitchen_github goto UPDATECHECK-ERROR

for /f "usebackq tokens=2 delims==" %%a in (`findstr version _other\kitchen`) do set version=%%a
for /f "usebackq tokens=2 delims==" %%a in (`findstr version _other\kitchen_github`) do set version_github=%%a
del _other\kitchen_github

if [%version_github%lolxD]==[lolxD] goto UPDATECHECK-ERROR
if %version%==%version_github% goto START
cls
color 0e
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
color 0e
echo Error: Can't get info about updates
echo.
echo Skipping..
echo.
timeout 3
goto START


:START
@title = mateo1111 ROM Kitchen - %version%
set yyyy=%date:~0,4%
set yy=%date:~2,2%
set mm=%date:~5,2%
set dd=%date:~8,2%
set pdate=%yyyy%%mm%%dd%
color 0e



:CLEAN
color 0c
echo CLEANING..
rmdir /S /Q out
if exist *.tmp del *.tmp
if not exist BASE\system\build.prop rmdir /S /Q BASE
if exist overlay\THESE_FILES_DONT_EXIST.txt del overlay\THESE_FILES_DONT_EXIST.txt
if exist overlay\list.txt del overlay\list.txt
if exist overlay_theme\THESE_APPS_DONT_EXIST.txt del overlay_theme\THESE_APPS_DONT_EXIST.txt
if exist overlay_theme\THESE_FRAMEWORKS_DONT_EXIST.txt del overlay_theme\THESE_FRAMEWORKS_DONT_EXIST.txt
if exist overlay_theme\app-list.txt del overlay_theme\app-list.txt
if exist overlay_theme\framework-list.txt del overlay_theme\framework-list.txt



:MENU
cls
set GO-BACK-TO-MENU=0
if exist BASE\system\build.prop (set BASE=1) else (set BASE=0)
color 0e
echo.
echo       mateo1111 ROM Kitchen - %version%
echo      ------------------------------------
echo.
echo.
echo.
echo   1] Create new ROM
echo.
if %BASE% == 1 ( echo   2] Remove current BASE ROM ) else ( echo. )
if %BASE% == 1 ( echo   3] Show info about current base ) else ( echo. )
echo.
echo.
echo   9] Clean everything
echo.
echo.
echo.
set /p type=Choose (1-9) and confirm with ENTER: 
if [%type%.]==[.] goto MENU

if %type% == 1 goto CHECK-BASE
if %type% == 9 goto CLEAN-EVERYTHING

if %BASE% == 1 (
if %type% == 2 goto CHANGE-BASE
if %type% == 3 (
set GO-BACK-TO-MENU=1
goto GET-BASE-INFO
)
)

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
color 0c
rmdir /S /Q BASE
cls
color 0e
echo.
echo When you will choose option to create new ROM,
echo Kitchen will ask you for .zip package with new base ROM..
echo.
echo.
echo Press any key to return to menu..
pause >nul
goto MENU


:CLEAN-EVERYTHING
cls
color 0e
call _other\clean.bat
goto MENU




:CHECK-BASE
cls
color 0e
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
color 0c
rmdir /S /Q BASE
mkdir BASE
_other\7za.exe x %customzip% -oBASE
echo.
echo.
goto CHECK-BASE


:GET-BASE-INFO
color 0c
set buildprop=BASE\system\build.prop

for /f "usebackq tokens=2 delims==" %%a in (`findstr ro.build.id %buildprop%`) do set build_id=%%a
for /f "usebackq tokens=2 delims==" %%a in (`findstr ro.build.display.id %buildprop%`) do set display_id=%%a
for /f "usebackq tokens=2 delims==" %%a in (`findstr ro.build.version.incremental %buildprop%`) do set rom_version=%%a
for /f "usebackq tokens=2 delims==" %%a in (`findstr ro.build.version.release %buildprop%`) do set rom_android=%%a
for /f "usebackq tokens=2 delims==" %%a in (`findstr ro.product.model %buildprop%`) do set model=%%a
for /f "usebackq tokens=2 delims==" %%a in (`findstr ro.product.brand %buildprop%`) do set brand=%%a
for /f "usebackq tokens=2 delims==" %%a in (`findstr ro.product.device %buildprop%`) do set device=%%a


cls
color 0e
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
if %GO-BACK-TO-MENU% == 1 (
goto MENU
)



:STOCK_TO_OUT
color 0c
mkdir out
xcopy BASE out /e /y


:REMOVE_BLOATWARE

if not exist overlay\not_needed_files.txt (
color 0e
echo.
echo.
echo File not found: overlay\not_needed_files.txt
echo Debloating will be skipped...
echo.
pause
goto OVERLAY
)
color 0c
for /f "delims=" %%f in (overlay\not_needed_files.txt) do (
if not exist out\%%f echo %%f>>overlay\THESE_FILES_DONT_EXIST.txt
if exist out\%%f del "out\%%f"
)

:OVERLAY
color 0c
for /f "usebackq tokens=*" %%a in (`dir /b/a:d overlay`) do (
    echo:%%~nxa
	echo:%%~nxa>>overlay\list.txt
)

for /f "delims=" %%f in (overlay\list.txt) do (
xcopy overlay\%%f out /e /y
)

if exist overlay\list.txt del overlay\list.txt


:OVERLAY_THEME
color 0c
for /f "usebackq tokens=*" %%a in (`dir /b/a:d overlay_theme\app`) do (
    echo:%%~nxa
	echo:%%~nxa>>overlay_theme\app-list.txt
)

for /f "delims=" %%f in (overlay_theme\app-list.txt) do (
if exist out\system\app\%%f (
move out\system\app\%%f out\system\app\%%f.zip
_other\7za.exe u -up1q1r2x2y2z2w2 -mx9 out\system\app\%%f.zip ".\overlay_theme\app\%%f\*"
move out\system\app\%%f.zip out\system\app\%%f
) else echo %%f>>overlay_theme\THESE_APPS_DONT_EXIST.txt
)



for /f "usebackq tokens=*" %%a in (`dir /b/a:d overlay_theme\framework`) do (
    echo:%%~nxa
	echo:%%~nxa>>overlay_theme\framework-list.txt
)

for /f "delims=" %%f in (overlay_theme\framework-list.txt) do (
if exist out\system\framework\%%f (
move out\system\framework\%%f out\system\framework\%%f.zip
_other\7za.exe u -up1q1r2x2y2z2w2 -mx9 out\system\framework\%%f.zip ".\overlay_theme\framework\%%f\*"
move out\system\framework\%%f.zip out\system\framework\%%f
) else echo %%f>>overlay_theme\THESE_FRAMEWORKS_DONT_EXIST.txt
)



if exist overlay_theme\app-list.txt del overlay_theme\app-list.txt
if exist overlay_theme\framework-list.txt del overlay_theme\framework-list.txt



:ZIP
if exist %rom_version%_%pdate%_mateo1111.zip (
color 0e
cls
echo.
echo %rom_version%_%pdate%_mateo1111.zip already exist..
echo.
echo Press any key to overwrite this file..
pause >nul
if exist %rom_version%_%pdate%_mateo1111.zip del %rom_version%_%pdate%_mateo1111.zip
)
color 0c
_other\7za.exe u -up0q0r2x2y2z1w2 -mx9 %rom_version%_%pdate%_mateo1111.zip ".\out\META-INF" ".\out\system" ".\out\boot.img"



:END
color 0e
echo.
echo.
echo %rom_version%_%pdate%_mateo1111.zip has been created..
echo Press any key to exit..
pause >nul
exit