# System Health Report
# Created by: Efuet Joan
# Date: April 2026

$ReportPath = "$env:USERPROFILE\OneDrive\Desktop\SystemHealthReport.txt"

$Date = Get-Date -Format "dd-MM-yyyy HH:mm"
$ComputerName = $env:COMPUTERNAME
$OS = (Get-WmiObject Win32_OperatingSystem).Caption
$CPU = (Get-WmiObject Win32_Processor).Name
$RAMTotal = [math]::Round((Get-WmiObject Win32_ComputerSystem).TotalPhysicalMemory / 1GB, 2)
$RAMFree = [math]::Round((Get-WmiObject Win32_OperatingSystem).FreePhysicalMemory / 1MB, 2)
$Disk = Get-WmiObject Win32_LogicalDisk -Filter "DeviceID='C:'"
$DiskTotal = [math]::Round($Disk.Size / 1GB, 2)
$DiskFree = [math]::Round($Disk.FreeSpace / 1GB, 2)
$Uptime = (Get-Date) - (gcim Win32_OperatingSystem).LastBootUpTime
$UptimeFormatted = "$($Uptime.Days)d $($Uptime.Hours)h $($Uptime.Minutes)m"

$Report = @"
====================================
     SYSTEM HEALTH REPORT
====================================
Date & Time   : $Date
Computer Name : $ComputerName
OS            : $OS
CPU           : $CPU
------------------------------------
MEMORY
Total RAM     : $RAMTotal GB
Free RAM      : $RAMFree MB
------------------------------------
DISK (C: Drive)
Total Space   : $DiskTotal GB
Free Space    : $DiskFree GB
------------------------------------
UPTIME        : $UptimeFormatted
====================================
"@

$Report | Out-File -FilePath $ReportPath
Write-Host "Report saved to $ReportPath" -ForegroundColor Green
Invoke-Item $ReportPath