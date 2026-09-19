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

for %%F in ("%file%") do (
    set "output=%%~dpnF.3gp"
    if /I "%%~xF"==".3gp" set "output=%%~dpnF-MMS.3gp"
)

ffmpeg -i "%file%" -c:v h263 -b:v 64k -vf "scale=176:144,setsar=12/11,setdar=4/3" -pix_fmt yuv420p -r 15 -c:a libopencore_amrnb -ar 8000 -ac 1 -b:a 12.2k "%output%"

if errorlevel 1 (
    echo Conversion failed.
    exit /b 1
)

echo Your output file is: "%output%"
