# ffmpeg-MMS

A simple Windows batch script for converting videos to the legacy 3GPP MMS video format.

This project originally used reverse-engineering of an actual iPhone MMS 3GP file. The original script was approximately 85% accurate to the observed file. This revision instead targets the historical standards-based MMS video profile: H.263 in a 3GP container with AMR-NB audio.

## Video profile

The encoder is constrained to the legacy MMS interoperability profile:

- Container: 3GP
- Video codec: H.263
- Resolution: 176x144 (QCIF)
- Pixel aspect ratio: 12:11
- Display aspect ratio: 4:3
- Pixel format: YUV 4:2:0
- Frame rate: 15 fps
- Video bitrate: 64 kbps
- Audio codec: AMR-NB
- Audio sample rate: 8 kHz
- Audio channels: mono
- Audio bitrate: 12.2 kbps

These settings are based on the historical 3GPP/GSMA MMS interoperability profile rather than attempting to reproduce one particular handset's encoder output.

## Requirements

- Windows
- FFmpeg available through the PATH environment variable (optional, but recommended for convenience purposes)
- An input video file supported by FFmpeg

## Usage

Run `mms.bat` and enter the path to the video file when prompted.

This project targets the **legacy MMS / H.263 era**. It is not intended to reproduce modern RCS or current 3GPP messaging profiles.


Portions of this script and README have been rewritten with the assistance of AI tools. The only use of AI was to make this script match the standard and to fix a longstanding bug.
