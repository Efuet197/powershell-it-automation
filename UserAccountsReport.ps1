# User Account Report
# Created by: Efuet Joan
# Date: April 2026

$ReportPath = "$env:USERPROFILE\OneDrive\Desktop\UserAccountReport.txt"
$Date = Get-Date -Format "dd-MM-yyyy HH:mm"

$Users = Get-LocalUser

$Report = @"
====================================
     USER ACCOUNT REPORT
====================================
Date & Time   : $Date
Computer Name : $env:COMPUTERNAME
------------------------------------
"@

foreach ($User in $Users) {
    $LastLogon = if ($User.LastLogon) { $User.LastLogon.ToString("dd-MM-yyyy HH:mm") } else { "Never" }
    
    $Report += @"

Username      : $($User.Name)
Full Name     : $($User.FullName)
Enabled       : $($User.Enabled)
Last Logon    : $LastLogon
Password Set  : $($User.PasswordLastSet)
------------------------------------
"@
}

$Report | Out-File -FilePath $ReportPath
Write-Host "User Account Report saved to $ReportPath" -ForegroundColor Green
Invoke-Item $ReportPath