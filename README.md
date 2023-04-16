EXIF Data Extractor and Converter
This repository contains three PowerShell scripts that can be used to extract EXIF data from pictures, convert it to a human-readable format, and display it.

ExtractAndConvert.ps1
The ExtractAndConvert.ps1 script extracts EXIF data from all pictures in a specified directory and saves it as CSV text to a file.

Usage
To use this script, you must have PowerShell installed on your computer.

Open a PowerShell prompt and navigate to the directory where the ExtractAndConvert.ps1 script is located.
Run the script by invoking it like this:
.\ExtractAndConvert.ps1 -DirectoryPath "C:\Path\To\Directory" -OutputFile "C:\Path\To\OutputFile.csv"
Replace C:\Path\To\Directory with the path to the directory containing the pictures from which to extract the EXIF data. Replace C:\Path\To\OutputFile.csv with the path to the output file where the CSV text will be written.

The script will extract the EXIF data from all pictures in the specified directory that have a file extension that contains EXIF data (e.g., .jpg, .jpeg, .tif, .tiff) and save it as CSV text to a file.

DisplayExif.ps1
The DisplayExif.ps1 script reads EXIF data from a CSV file and displays it in a human-readable format.

Usage
To use this script, you must have PowerShell installed on your computer.

Open a PowerShell prompt and navigate to the directory where the DisplayExif.ps1 script is located.
Run the script by invoking it like this:
.\DisplayExif.ps1 -InputFile "C:\Path\To\InputFile.csv"
Replace C:\Path\To\InputFile.csv with the path to the input file containing the EXIF data in CSV format.

The script will read the EXIF data from the specified CSV file and display it in a human-readable format.

Main.ps1
The Main.ps1 script combines the functionality of both the ExtractAndConvert.ps1 and DisplayExif.ps1 scripts into a single script that extracts EXIF data from pictures, converts it to a human-readable format, and displays it.

Usage
To use this script, you must have PowerShell installed on your computer.

Open a PowerShell prompt and navigate to the directory where the Main.ps1 script is located.
Run the script by invoking it like this:
.\Main.ps1 -DirectoryPath "C:\Path\To\Directory"
Replace C:\Path\To\Directory with the path to the directory containing the pictures from which to extract the EXIF data.

The script will extract the EXIF data from all pictures in the specified directory, convert it to a human-readable format, and display it.
