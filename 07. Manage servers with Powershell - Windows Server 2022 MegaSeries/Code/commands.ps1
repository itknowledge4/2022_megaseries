#Get a list of modules
Get-Module -ListAvailable

#Get the commands that are part of a module
Get-Command -Module ServerManager

#Manage local server features and roles
Get-WindowsFeature
Get-WindowsFeature | Where-Object {$_.InstallState -eq 'Installed'}
Install-WindowsFeature -Name Telnet-Client
Get-WindowsFeature -Name Telnet-Client
Uninstall-WindowsFeature -Name Telnet-Client

#Get events
Get-EventLog -LogName System -EntryType Error
Get-EventLog -LogName System -EntryType Warning -Newest 3
Get-EventLog -LogName System -EntryType Warning -Message "*time service*"
Get-EventLog -LogName system -Source Microsoft-Windows-Kernel-General

#Manage services
Get-Service
Get-Service -Name BITS
Start-Service -Name BITS
Stop-Service -Name BITS

#Most commands have a ComputerName parameter so they can executed on remote machines
#I prefer to use Powershell Remoting with Invoke-Command in most cases
#PS Remoting can also be used in a SSH style with Enter-PSSession

#Run some commands in an interactive PS remoting session
Enter-PSSession -ComputerName DC02
HOSTNAME
ipconfig
Get-Service
Get-WindowsFeature
Exit-PSSession

#With Invoke-Command we can execute commands on multiple servers and in parallel
Invoke-Command -ComputerName 'localhost','DC02' -ScriptBlock {Get-Service BITS}
Invoke-Command -ComputerName 'localhost','DC02' -ScriptBlock {Get-EventLog -LogName System -EntryType Warning -Newest 3}

Invoke-Command -ComputerName 'localhost','DC02' -ScriptBlock {Install-WindowsFeature -Name Telnet-Client}
Invoke-Command -ComputerName 'localhost','DC02' -ScriptBlock {Get-WindowsFeature -Name Telnet-Client}
Invoke-Command -ComputerName 'localhost','DC02' -ScriptBlock {Uninstall-WindowsFeature -Name Telnet-Client}