[CmdletBinding()]
param(
    [Parameter(Mandatory=$true)]
    [string]$DirectoryPath,
    [Parameter(Mandatory=$true)]
    [string]$OutputFile
)

function Extract-ExifData {
    param(
        [Parameter(Mandatory=$true)]
        [string]$DirectoryPath
    )

    Add-Type -AssemblyName System.Drawing

    # Define an array of file extensions that contain EXIF data
    $exifFileExtensions = @("*.jpg", "*.jpeg", "*.tif", "*.tiff")

    # Get all the pictures in the specified directory that have a file extension that contains EXIF data
    $pictures = Get-ChildItem $DirectoryPath -Include $exifFileExtensions -Recurse

    # Create an array to store the EXIF data for all pictures
    $allExifData = @()

    # Iterate over each picture
    foreach ($picture in $pictures) {
        $image = New-Object System.Drawing.Bitmap $picture.FullName
        $propertyItems = $image.PropertyItems
        $exifData = $propertyItems | ForEach-Object {
            $encoding = New-Object System.Text.ASCIIEncoding
            $value = $encoding.GetString($_.Value)
            "$($_.Id) :$value"
        }

        # Add the EXIF data for this picture to the array
        $allExifData += $exifData
    }

    return $allExifData
}

function ConvertTo-Csv {
    param(
        [Parameter(Mandatory=$true)]
        [string[]]$ExifData,
        [Parameter(Mandatory=$true)]
        [string]$OutputFile
    )

    # Create an array to store the EXIF data as objects
    $exifObjects = @()

    # Iterate over each line in the EXIF data
    foreach ($line in $ExifData) {
        # Split the line into its ID and value parts
        $parts = $line.Split(":", 2)
        $id = $parts[0].Trim()
        $value = $parts[1].Trim()

        # Create an object to represent the EXIF data
        $exifObject = New-Object PSObject -Property @{
            "ID" = $id
            "Value" = $value
        }

        # Add the object to the array
        $exifObjects += $exifObject
    }

    # Export the EXIF data to a CSV file
    $exifObjects | Export-Csv -Path $OutputFile -NoTypeInformation
}

# Extract the EXIF data from all pictures in the specified directory
$exifData = Extract-ExifData -DirectoryPath $DirectoryPath

# Convert the EXIF data to CSV and save it to a file
ConvertTo-Csv -ExifData $exifData -OutputFile $OutputFile