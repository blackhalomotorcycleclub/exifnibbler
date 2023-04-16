[CmdletBinding()]
param(
    [Parameter(Mandatory=$true)]
    [string]$DirectoryPath
)

# Define a temporary file to store the EXIF data in CSV format
$tempFile = [IO.Path]::GetTempFileName()

# Extract the EXIF data from all pictures in the specified directory and save it as CSV text to a temporary file
.\ExtractAndConvert.ps1 -DirectoryPath $DirectoryPath -OutputFile $tempFile

# Read the EXIF data from the temporary file and display it in a human-readable format
.\DisplayExif.ps1 -InputFile $tempFile

# Delete the temporary file
Remove-Item $tempFile