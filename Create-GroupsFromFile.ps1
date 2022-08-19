param (
    [string]$file_path = "" #default file path here if none provided in args
)

#edit for each production run
$PostOffice = ""

$file = Get-Content -path $file_path
foreach ($line in $file)
{
    if ($line -match '.qmail-(?<NAME>.+)$')
    {
        $GroupName = $Matches.NAME
        $GroupName = $GroupName -replace ':','.'
        Write-host "Creating group $GroupName..."
        New-MailEnableGroup -Postoffice $PostOffice -GroupName $GroupName -EmailAddress $GroupName@$PostOffice
    }
    if ($line -match '^\s+(?<EMAIL>(.+)@(.+))')
    {
        $Email = $Matches.EMAIL
        Write-Host "Adding $Email to group $GroupName..."
        New-MailEnableGroupMember -PostOffice $PostOffice -GroupName $GroupName -EmailAddress $Email
    }
    if ($line -match '/home/vpopmail/domains/\w+.\w{3}/\w/(?<DirName>.+)/Maildir') #maildir path instead of email
    {
        $OtherEmail = $Matches.DirName
        $OtherEmail = $OtherEmail+"@"+$PostOffice # a little risky but we will only be moving one domain
        Write-Host "Adding $OtherEmail to $GroupName..."
        New-MailEnableGroupMember -PostOffice $PostOffice -GroupName $GroupName -EmailAddress $OtherEmail
    }
}
