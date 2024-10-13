# ffmpeg-MMS
Simple batch script to convert videos to MMS quality used by the GSM standard which Android users had to endure for over a decade thanks to Apple being Apple. This era of low quality videos are coming to an end with Apple finally adopting RCS instead of hanging onto a 20 year old standard for dear life. This was made using reverse engineering efforts of an actual MMS 3gp file sent by an iPhone using ffprobe. I tried to make it 100% accurate, but I was only able to make it 85% accurate. 

# Known issues
File extensions are duplicated. This is an issue I tried to fix but was unable to.

# How do I even use this?

This was designed with ffmpeg being a enviroment variable in mind. Place the batch script along side ffmpeg and run it. Follow the on-screen instuctions.
