$csvfile = Import-Csv -Path .\groupslist.csv;

Function Get-GroupMembers{

    [CmdletBinding()]Param([Parameter(Mandatory=$True)]  $GroupName)

    $list_of_members = Get-ADGroupMember -Identity $GroupName;
     $GroupName|Out-File -FilePath C:\TEMP\userlist.txt -Append
     " "|Out-File -FilePath C:\TEMP\userlist.txt -Append;

    foreach($item in $list_of_members){
        if($item.objectClass -eq "group"){
            Get-GroupMembers -GroupName $item.name
        }
        elseif($item.objectClass -eq "user"){
            $item.name|Out-File -FilePath C:\TEMP\userlist.txt -Append
        }
    }
    " "|Out-File -FilePath C:\TEMP\userlist.txt -Append;
    " "|Out-File -FilePath C:\TEMP\userlist.txt -Append;
}

foreach($element in $csvfile){
Get-GroupMembers -GroupName $element.GroupsList
}