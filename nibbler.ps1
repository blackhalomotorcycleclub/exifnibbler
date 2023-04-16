#Requires -Version 3.0
[CmdletBinding()]
param(
    [Parameter(Mandatory=$false)]
    [string]$folderPath,
    [Parameter(Mandatory=$false)]
    [string]$picturePath,
    [Parameter(Mandatory=$false)]
    [switch]$help,
    [Parameter(Mandatory=$false)]
    [switch]$version,
    [Parameter(Mandatory=$false)]
    [string]$outputType = "single"
)

if ($help) {
    Write-Host "This script extracts EXIF data from pictures and outputs it to a file."
    Write-Host "You can specify a folder containing pictures using the -folderPath parameter or a single picture using the -picturePath parameter."
    Write-Host "You can also specify the output type using the -outputType parameter. Valid values are 'single' and 'multiple'."
    Write-Host "Use the -version switch to display version information."
    exit
}

if ($version) {
    Write-Host "EXIF Nibbler v0.01b"
    exit
}

if (-not $folderPath -and -not $picturePath) {
    Write-Error "You must specify either a folder path or a picture path"
    exit
}

if ($folderPath -and $picturePath) {
    Write-Error "You cannot specify both a folder path and a picture path"
    exit
}

Add-Type -AssemblyName System.Drawing

if ($folderPath) {
    if (-not (Test-Path $folderPath)) {
        Write-Error "The specified folder does not exist"
        exit
    }

    $pictures = Get-ChildItem $folderPath -Filter *.jpg
} else {
    if (-not (Test-Path $picturePath)) {
        Write-Error "The specified picture does not exist"
        exit
    }

    $pictures = Get-Item $picturePath
}

if ($outputType -eq "single") {
    if ($folderPath) {
        $outputFile = Join-Path $folderPath "EXIFData.txt"
    } else {
        $outputFile = Join-Path (Split-Path $picturePath) "EXIFData.txt"
    }
    
    $pictures | ForEach-Object {
        $image = New-Object System.Drawing.Bitmap $_.FullName
        $propertyItems = $image.PropertyItems
        $exifData = $propertyItems | ForEach-Object {
            $encoding = New-Object System.Text.ASCIIEncoding
            $value = $encoding.GetString($_.Value)
            "$($_.Id) :$value"
        }
        Out-File -FilePath$outputFile -InputObject$exifData -Append
    }
} elseif ($outputType -eq "multiple") {
    $pictures | ForEach-Object {
        $image = New-Object System.Drawing.Bitmap $_.FullName
        $propertyItems = $image.PropertyItems
        $exifData = $propertyItems | ForEach-Object {
            $encoding = New-Object System.Text.ASCIIEncoding
            $value = $encoding.GetString($_.Value)
            "$($_.Id) :$value"
        }
        
        if ($folderPath) {
            # Generate file name using specified naming schema
            # (name of picture) - (date and time) - (hostname of computer) - (file extension).txt
            # Example: Picture1 - 2022_04_15 05_36_24 MyComputer.txt
            # Note: The date and time format used here is yyyy_MM_dd HH_mm_ss to avoid issues with invalid characters in file names.
            # You can modify this format if desired.
            # The hostname is obtained using the built-in environment variable COMPUTERNAME.
            # You can modify this if desired.
            # The file extension is always .txt for text files.
            # You can modify this if desired.
            
            # Get picture name without extension
            $pictureName = [IO.Path]::GetFileNameWithoutExtension($_.Name)
            
            # Get current date and time in desired format
            $dateTime = Get-Date -Format "yyyy_MM_dd HH_mm_ss"
            
            # Get hostname of computer
            $hostname = $env:COMPUTERNAME
            
            # Generate file name using naming schema
            $fileName = "$pictureName -$dateTime$hostname.txt"
            
            # Generate full path to output file by combining folder path and file name
            $outputFile = Join-Path$folderPath$fileName
            
            Out-File -FilePath$outputFile -InputObject$exifData
        }