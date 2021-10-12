$Services=Get-CimInstance Win32_Service
$Services | select Name,StartMode,DisplayName,Description,State,PathName | Export-Csv -Path C:\Services.csv -NoTypeInformation