#Get a list of all reparse points in the Windows.old folder
C:\Users\administrator.TESTCORP\Desktop\Junction\junction64.exe -accepteula -s -q C:\Windows.old | out-file C:\junction.txt
#Go through each of the junctions and delete it
foreach ($line in [System.IO.File]::ReadLines("C:\junction.txt"))
{
     if ($line -match "^\\\\")
     {
         $file = $line -replace "(: JUNCTION)|(: SYMBOLIC LINK)",""
         & C:\Users\administrator.TESTCORP\Desktop\Junction\junction64.exe -d "$file"
     }
}

#Take ownership of all folders/files and give the Administrators Full Control
takeown /F c:\Windows.old\* /R /A /D Y
echo y | cacls C:\windows.old /T /G BUILTIN\Administrators:F

#Delete the Windows.old folder
Remove-Item C:\windows.old -recurse -force

