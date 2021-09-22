#Verify IP and name
Get-NetIPConfiguration
hostname

Install-WindowsFeature AD-Domain-Services -IncludeManagementTools
Install-ADDSDomainController `
-NoGlobalCatalog:$false `
-CreateDnsDelegation:$false `
-CriticalReplicationOnly:$false `
-DatabasePath "C:\Windows\NTDS" `
-DomainName "testcorp.local" `
-InstallDns:$true `
-LogPath "C:\Windows\NTDS" `
-NoRebootOnCompletion:$false `
-ReplicationSourceDC "DC01.testcorp.local" `
-SiteName "Default-First-Site-Name" `
-SysvolPath "C:\Windows\SYSVOL" `
-Force:$true

#Set DNS settings
Set-DnsClientServerAddress -InterfaceIndex 6 -ResetServerAddresses
Set-DnsClientServerAddress -InterfaceIndex 6 -ServerAddresses 192.168.10.2,192.168.10.1
