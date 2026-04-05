# Disk Space Monitor
# Created by: Efuet Joan
# Created by: Your Name
# Date: April 2026

$Threshold = 20
$ReportPath = "$env:USERPROFILE\OneDrive\Desktop\DiskSpaceReport.txt"

$Date = Get-Date -Format "dd-MM-yyyy HH:mm"
$Disks = Get-WmiObject Win32_LogicalDisk -Filter "DriveType=3"

$Report = @"
====================================
     DISK SPACE MONITOR REPORT
====================================
Date & Time: $Date
------------------------------------
"@

foreach ($Disk in $Disks) {
    $Total = [math]::Round($Disk.Size / 1GB, 2)
    $Free = [math]::Round($Disk.FreeSpace / 1GB, 2)
    $Used = [math]::Round($Total - $Free, 2)
    $PercentFree = [math]::Round(($Free / $Total) * 100, 1)

    if ($PercentFree -le $Threshold) {
        $Status = "⚠️ WARNING - Low Disk Space!"
    } else {
        $Status = "✅ OK"
    }

    $Report += @"

Drive         : $($Disk.DeviceID)
Total Space   : $Total GB
Used Space    : $Used GB
Free Space    : $Free GB
% Free        : $PercentFree%
Status        : $Status
------------------------------------
"@
}

$Report | Out-File -FilePath $ReportPath
Write-Host "Disk Space Report saved to $ReportPath" -ForegroundColor Green
Invoke-Item $ReportPath
# Date: April 2026

$Threshold = 20
$ReportPath = "$env:USERPROFILE\OneDrive\Desktop\DiskSpaceReport.txt"

$Date = Get-Date -Format "dd-MM-yyyy HH:mm"
$Disks = Get-WmiObject Win32_LogicalDisk -Filter "DriveType=3"

$Report = @"
====================================
     DISK SPACE MONITOR REPORT
====================================
Date & Time: $Date
------------------------------------
"@

foreach ($Disk in $Disks) {
    $Total = [math]::Round($Disk.Size / 1GB, 2)
    $Free = [math]::Round($Disk.FreeSpace / 1GB, 2)
    $Used = [math]::Round($Total - $Free, 2)
    $PercentFree = [math]::Round(($Free / $Total) * 100, 1)

    if ($PercentFree -le $Threshold) {
        $Status = "⚠️ WARNING - Low Disk Space!"
    } else {
        $Status = "✅ OK"
    }

    $Report += @"

Drive         : $($Disk.DeviceID)
Total Space   : $Total GB
Used Space    : $Used GB
Free Space    : $Free GB
% Free        : $PercentFree%
Status        : $Status
------------------------------------
"@
}

$Report | Out-File -FilePath $ReportPath
Write-Host "Disk Space Report saved to $ReportPath" -ForegroundColor Green
Invoke-Item $ReportPath