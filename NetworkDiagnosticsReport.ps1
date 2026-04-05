# Network Diagnostics Report
# Created by: Efuet Joan
# Date: April 2026

$ReportPath = "$env:USERPROFILE\OneDrive\Desktop\NetworkDiagnosticsReport.txt"
$Date = Get-Date -Format "dd-MM-yyyy HH:mm"

# Gather network info
$IPConfig = Get-NetIPAddress -AddressFamily IPv4 | Where-Object { $_.InterfaceAlias -notlike "*Loopback*" }
$DNSServers = Get-DnsClientServerAddress -AddressFamily IPv4 | Where-Object { $_.ServerAddresses }
$DefaultGateway = (Get-NetRoute -DestinationPrefix "0.0.0.0/0").NextHop
$PingGoogle = Test-Connection -ComputerName "8.8.8.8" -Count 2 -Quiet
$PingDNS = Test-Connection -ComputerName "google.com" -Count 2 -Quiet

$InternetStatus = if ($PingGoogle) { "✅ Connected" } else { "❌ No Internet" }
$DNSStatus = if ($PingDNS) { "✅ Working" } else { "❌ DNS Failed" }

$Report = @"
====================================
   NETWORK DIAGNOSTICS REPORT
====================================
Date & Time     : $Date
Computer Name   : $env:COMPUTERNAME
------------------------------------
IP CONFIGURATION
"@

foreach ($IP in $IPConfig) {
    $Report += @"

Interface       : $($IP.InterfaceAlias)
IP Address      : $($IP.IPAddress)
Prefix Length   : $($IP.PrefixLength)
------------------------------------
"@
}

$Report += @"
DEFAULT GATEWAY : $DefaultGateway
------------------------------------
DNS SERVERS
"@

foreach ($DNS in $DNSServers) {
    $Report += @"

Interface       : $($DNS.InterfaceAlias)
DNS Servers     : $($DNS.ServerAddresses -join ", ")
------------------------------------
"@
}

$Report += @"
CONNECTIVITY
Internet Status : $InternetStatus
DNS Status      : $DNSStatus
====================================
"@

$Report | Out-File -FilePath $ReportPath
Write-Host "Network Diagnostics Report saved to $ReportPath" -ForegroundColor Green
Invoke-Item $ReportPath