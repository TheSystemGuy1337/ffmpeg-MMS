@echo off
setlocal DisableDelayedExpansion

set /p "file=Select a video file to convert: "

if not defined file (
    echo No input file was specified.
    exit /b 1
)

rem Normalize drag-and-drop input by removing one surrounding pair of quotes.
for /f "delims=" %%F in ("%file%") do set "file=%%~F"

if not exist "%file%" (
    echo Input file not found: "%file%"
    exit /b 1
)

set /p "widescreen=Is the input video 16:9? (Y/N): "

for %%F in ("%file%") do (
    set "output=%%~dpnF.3gp"
    if /I "%%~xF"==".3gp" set "output=%%~dpnF-MMS.3gp"
)

if /I "%widescreen%"=="Y" goto :widescreen
if /I "%widescreen%"=="YES" goto :widescreen
goto :standard

:widescreen
rem 16:9 MMS pipeline: preserve the widescreen composition inside QCIF.
ffmpeg -i "%file%" -c:v h263 -b:v 64k -vf "scale=176:99,pad=176:144:0:22,setsar=1,setdar=4/3" -pix_fmt yuv420p -r 15 -c:a libopencore_amrnb -ar 8000 -ac 1 -b:a 12.2k "%output%"
goto :result

:standard
rem 4:3 MMS pipeline: full QCIF.
ffmpeg -i "%file%" -c:v h263 -b:v 64k -vf "scale=176:144,setsar=12/11,setdar=4/3" -pix_fmt yuv420p -r 15 -c:a libopencore_amrnb -ar 8000 -ac 1 -b:a 12.2k "%output%"

:result
if errorlevel 1 (
    echo Conversion failed.
    exit /b 1
)

echo Your output file is: "%output%"
