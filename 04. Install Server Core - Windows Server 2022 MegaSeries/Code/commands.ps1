#Configure network settings
#Get a list of network adapters
Get-NetAdapter
#Set IP settings
New-NetIPAddress -IPAddress 192.168.10.2 -DefaultGateway 192.168.10.254 -PrefixLength 24 -InterfaceIndex 6
#Configure DNS servers
Set-DnsClientServerAddress -InterfaceIndex 6 -ServerAddresses 192.168.10.1

#Enable firewall rules
#You can check if they are enabled first with the following CmdLets
Get-NetFirewallRule FPS-ICMP4-ERQ-In | Select-Object -ExpandProperty Enabled
Get-NetFirewallRule FPS-SMB-In-TCP | Select-Object -ExpandProperty Enabled
#Ping rule
Enable-NetFirewallRule FPS-ICMP4-ERQ-In
#File sharing rule
Enable-NetFirewallRule FPS-SMB-In-TCP

#Enable RDP
Set-ItemProperty -Path 'HKLM:\System\CurrentControlSet\Control\Terminal Server' -name "fDenyTSConnections" -value 0
$NLA = Get-CimInstance -ClassName Win32_TSGeneralSetting -Namespace root\cimv2\terminalservices -Filter "TerminalName='RDP-tcp'"
$NLA | Invoke-CimMethod -MethodName SetUserAuthenticationRequired -Arguments @{ UserAuthenticationRequired = $true }
Enable-NetFirewallRule -DisplayGroup "Remote Desktop"

#Rename server
Rename-Computer -NewName DC02 -Restart

#Join domain
Add-Computer -Credential (Get-Credential) -DomainName testcorp.local -Restart
