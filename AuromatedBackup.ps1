# Automated Backup Script
# Created by: Efuet Joan
# Date: April 2026

$Source = "$env:USERPROFILE\OneDrive\Desktop\TestBackup"
$Destination = "$env:USERPROFILE\OneDrive\Desktop\BackupOutput"
$Date = Get-Date -Format "dd-MM-yyyy_HH-mm"
$BackupFolder = "$Destination\Backup_$Date"
$LogPath = "$env:USERPROFILE\OneDrive\Desktop\BackupLog.txt"

# Create test source folder and files if they don't exist
if (!(Test-Path $Source)) {
    New-Item -ItemType Directory -Path $Source | Out-Null
    "This is test file 1" | Out-File "$Source\file1.txt"
    "This is test file 2" | Out-File "$Source\file2.txt"
    "This is test file 3" | Out-File "$Source\file3.txt"
    Write-Host "Created test source folder with sample files" -ForegroundColor Yellow
}

# Create destination folder
New-Item -ItemType Directory -Path $BackupFolder | Out-Null

# Copy files
Copy-Item -Path "$Source\*" -Destination $BackupFolder -Recurse

# Count backed up files
$FileCount = (Get-ChildItem $BackupFolder).Count

# Create log
$Log = @"
====================================
     AUTOMATED BACKUP REPORT
====================================
Date & Time  : $Date
Source       : $Source
Destination  : $BackupFolder
Files Backed : $FileCount
Status       : ✅ Backup Completed Successfully
====================================
"@

$Log | Out-File -FilePath $LogPath
Write-Host "Backup completed! $FileCount files backed up." -ForegroundColor Green
Write-Host "Log saved to $LogPath" -ForegroundColor Green
Invoke-Item $LogPath