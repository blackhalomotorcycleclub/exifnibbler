[CmdletBinding()]
param(
    [Parameter(Mandatory=$true)]
    [string]$InputFile
)

# Import the EXIF data from the CSV file
$exifData = Import-Csv -Path $InputFile

# Define a hashtable to map EXIF IDs to human-readable names
$exifNames = @{
    "0x010F" = "Make"
    "0x0110" = "Model"
    "0x0112" = "Orientation"
    "0x0132" = "Date and Time"
    "0x8769" = "Exif IFD Pointer"
    "0x9003" = "Date and Time (Original)"
    "0x9004" = "Date and Time (Digitized)"
    "0x9291" = "Subsec Time"
    "0xA002" = "Exif Image Width"
    "0xA003" = "Exif Image Height"
}

# Iterate over each EXIF data object
foreach ($exifObject in $exifData) {
    # Get the ID and value of the EXIF data
    $id = $exifObject.ID
    $value = $exifObject.Value

    # Check if the ID has a human-readable name
    if ($exifNames.ContainsKey($id)) {
        # Get the human-readable name of the ID
        $name = $exifNames[$id]

        # Display the EXIF data in a human-readable format
        Write-Host "${name}: ${value}"
    } else {
        # Display the EXIF data using its ID
        Write-Host "${id}: ${value}"
    }
}