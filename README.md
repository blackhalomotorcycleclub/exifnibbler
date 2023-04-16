# exifnibbler
Powershell script to process pictures and output EXIF data to text

This PowerShell script extracts EXIF data from pictures and outputs it to a file. You can specify a folder containing pictures using the -folderPath parameter or a single picture using the -picturePath parameter. You can also specify the output type using the -outputType parameter. Valid values for this parameter are single and multiple. When using the single output type, all EXIF data is written to a single file named EXIFData.txt. When using the multiple output type, individual text files are created for each picture using the following naming schema: (name of picture) - (date and time) (hostname of computer) (file extension).txt.

You can use the -help switch to display a help message that explains how to use the script. You can also use the -version switch to display version information.

Here is an example of how to run this script with parameters:

# Extract EXIF data from all pictures in a folder and output data to a single file
.\Nibbler.ps1 -folderPath "C:\Pictures" -outputType "single"

# Extract EXIF data from all pictures in a folder and output data to individual files
.\Nibbler.ps1 -folderPath "C:\Pictures" -outputType "multiple"

# Extract EXIF data from a single picture and output data to a single file
.\Nibbler.ps1 -picturePath "C:\Pictures\Picture1.jpg" -outputType "single"

# Extract EXIF data from a single picture and output data to an individual file
.\Nibbler.ps1 -picturePath "C:\Pictures\Picture1.jpg" -outputType "multiple"

# Display help message
.\Nibbler.ps1 -help

# Display version information
.\Nibbler.ps1 -version
