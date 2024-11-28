@echo off
set /p file=Select a video file to convert: 
ffmpeg -i %file% -b:a 12.20k -acodec libopencore_amrnb -ar 8000 -ac 1 -b:v 103k -vf scale=176x144,setsar=12/11,setdar=4/3 -pix_fmt yuv420p -r 10 %file%.3gp
echo Your output file is: %file%.3gp
