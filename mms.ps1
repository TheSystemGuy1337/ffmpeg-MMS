[CmdletBinding()]
param(
    [Parameter(Position = 0)]
    [string]$InputFile
)

$ErrorActionPreference = 'Stop'

if ([string]::IsNullOrWhiteSpace($InputFile)) {
    $InputFile = Read-Host 'Select a video file to convert'
}

# Normalize a path copied or drag-dropped with surrounding quotes.
$InputFile = $InputFile.Trim()
if ($InputFile.Length -ge 2 -and $InputFile[0] -eq '"' -and $InputFile[$InputFile.Length - 1] -eq '"') {
    $InputFile = $InputFile.Substring(1, $InputFile.Length - 2)
}

if (-not (Test-Path -LiteralPath $InputFile -PathType Leaf)) {
    Write-Error "Input file not found: $InputFile"
    exit 1
}

$widescreen = Read-Host 'Is the input video 16:9? (Y/N)'

$inputPath = [System.IO.Path]::GetFullPath($InputFile)
$directory = [System.IO.Path]::GetDirectoryName($inputPath)
$baseName = [System.IO.Path]::GetFileNameWithoutExtension($inputPath)
$extension = [System.IO.Path]::GetExtension($inputPath)

$output = Join-Path $directory "$baseName.3gp"
if ($extension -ieq '.3gp') {
    $output = Join-Path $directory "$baseName-MMS.3gp"
}

$commonArgs = @(
    '-i', $inputPath,
    '-c:v', 'h263',
    '-b:v', '64k',
    '-pix_fmt', 'yuv420p',
    '-r', '15',
    '-c:a', 'libopencore_amrnb',
    '-ar', '8000',
    '-ac', '1',
    '-b:a', '12.2k',
    $output
)

if ($widescreen -match '^(?i:y|yes)$') {
    # 16:9 compatibility pipeline: preserve the widescreen composition inside QCIF.
    $filter = 'scale=176:99,pad=176:144:0:22,setsar=1,setdar=4/3'
}
else {
    # 4:3 MMS pipeline: full QCIF.
    $filter = 'scale=176:144,setsar=12/11,setdar=4/3'
}

$ffmpegArgs = @('-i', $inputPath, '-c:v', 'h263', '-b:v', '64k', '-vf', $filter,
    '-pix_fmt', 'yuv420p', '-r', '15', '-c:a', 'libopencore_amrnb',
    '-ar', '8000', '-ac', '1', '-b:a', '12.2k', $output)

try {
    & ffmpeg @ffmpegArgs
    if ($LASTEXITCODE -ne 0) {
        throw "FFmpeg exited with code $LASTEXITCODE."
    }
}
catch {
    Write-Error "Conversion failed: $($_.Exception.Message)"
    exit 1
}

Write-Host "Your output file is: $output"
