# ffmpeg-MMS

A PowerShell script for converting videos to the legacy 3GPP MMS video format.

This project originally used reverse-engineering of an actual iPhone MMS 3GP file. The original script was approximately 85% accurate to the observed file. This revision instead targets a historical standards-oriented MMS video profile: H.263 in a 3GP container with AMR-NB audio.

## Video profile

The encoder uses the legacy MMS interoperability profile:

- Container: 3GP
- Video codec: H.263
- Standard 4:3 resolution: 176x144 (QCIF)
- Standard 4:3 pixel aspect ratio: 12:11
- Standard 4:3 display aspect ratio: 4:3
- Pixel format: YUV 4:2:0
- Frame rate: 15 fps
- Video bitrate: 64 kbps
- Audio codec: AMR-NB
- Audio sample rate: 8 kHz
- Audio channels: mono
- Audio bitrate: 12.2 kbps

For 16:9 input, the script asks the user whether the source is widescreen and uses a separate compatibility pipeline that preserves the 16:9 composition inside a 176x144 frame rather than horizontally squashing it. This behavior is intentionally described as a compatibility path; the exact historical 16:9 MMS representation still requires further standards/interoperability research.

## Requirements

- Windows PowerShell 5.1 or PowerShell 7+
- FFmpeg available through the PATH environment variable
- An input video file supported by FFmpeg

## Usage

Run `mms.ps1` from PowerShell and enter the path to the video file when prompted. The script also accepts the input path as its first argument:

```powershell
.\mms.ps1 "C:\path\to\video.mkv"
```

PowerShell treats parentheses, brackets, spaces, and other characters in the filename as data when the path is passed as a quoted argument or read with `Read-Host`; the filename does not need Batch-style escaping.

If Windows PowerShell blocks script execution because of the execution policy, use the normal PowerShell execution-policy mechanism appropriate for your system rather than modifying the script to work around it.

The output extension is normally changed to `.3gp`. If the input is already `.3gp`, the output is named `-MMS.3gp` to avoid overwriting the source.

This project targets the **legacy MMS / H.263 era**. It is not intended to reproduce modern RCS or current 3GPP messaging profiles.

Portions of this script and README have been rewritten with the assistance of AI tools. The only use of AI was to make this script match the standard and to fix longstanding filename/argument-handling bugs.
