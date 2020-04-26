$baseuser = Read-Host "Please enter the username of the Base Account"
$diffuser = Read-Host "Please enter the username of the Account to compare base with"

$BaseAcct = (Get-ADPrincipalGroupMembership $baseuser|sort name).name
$DiffAcct = (Get-ADPrincipalGroupMembership $diffuser|sort name).name

#To check whether the path exists
$Testpath = Test-Path "C:/Temp"

if ($Testpath -eq $False){
    mkdir C:/Temp
}

$comparison = Compare-Object -ReferenceObject $BaseAcct -DifferenceObject $DiffAcct

if($comparison -eq $null){
    
    #This block is executed when there is no group membership difference
    "$baseuser and $diffuser have no difference in group membership.
    "|Out-File -FilePath C:\TEMP\Comparison.txt

    C:\Windows\notepad.exe C:\TEMP\Comparison.txt
}
else{

    "$baseuser is excluded from these groups but $diffuser is a member
    "|Out-File -FilePath C:\TEMP\$baseuser.txt

    "$diffuser is excluded from these groups but $baseuser is a member
    "|Out-File -FilePath C:\TEMP\$diffuser.txt

    foreach ($item in $comparison) {
        if ($item.sideindicator -eq "=>") {
            $item.InputObject|Out-File -FilePath C:\TEMP\$baseuser.txt -Append
        }
        else {
            $item.InputObject|Out-File -FilePath C:\TEMP\$diffuser.txt -Append
        }
    }

    C:\Windows\notepad.exe C:\TEMP\$baseuser.txt
    C:\Windows\notepad.exe C:\TEMP\$diffuser.txt
}