
Function Get-DirectReports{

    [CmdletBinding()]Param([Parameter(Mandatory=$True)]  $SAMUserName)

    $directreportslist = Get-ADUser $SAMUserName -Properties directreports | Select-Object -ExpandProperty directreports

    foreach($item in $directreportslist){
    $item;

    $SamName = Get-ADUser $item | select SAMAccountName
    
    $directreportslisttemp = Get-ADUser $SamName.SAMAccountName -Properties directreports | Select-Object -ExpandProperty directreports

        if($directreportslisttemp -eq $null){
            
            $SAMemployeeid = Get-ADUser $SamName.SAMAccountName -Properties employeeid | select employeeid 

            if($SAMemployeeid.employeeid -ne $null){
            $SamName.SAMAccountName|Out-File -FilePath C:\TEMP\DirectReports.txt -Append
            }
        }
        else{
            $SAMemployeeid = Get-ADUser $SamName.SAMAccountName -Properties employeeid | select employeeid 

            if($SAMemployeeid.employeeid -ne $null){
            $SamName.SAMAccountName|Out-File -FilePath C:\TEMP\DirectReports.txt -Append
            }
            Get-DirectReports -SAMUserName $SamName.SAMAccountName
        }
    }

}