param (
    [string]$file_path = "" #default file path here if none provided in args
)


$file = Get-Content -path $file_path
foreach ($line in $file)
{
    $dataInLine = $line -split(",")
    $name = $dataInLine[0]
    $password = $dataInLine[1]
    $domain = $dataInLine[2]
    
    try
    {
        Write-Host "Creating mailbox for: $name@$domain, password: $password"
        New-MailEnableMailbox -Mailbox $name -Domain $domain -Password $password -Right "USER"
        Write-Host "Setting mailbox quota..."
        Set-MailEnableMailbox -Postoffice $domain -Mailbox $name -Setting mailboxLimit -Value 2500000
    }
    catch
    {
        Write-Host "Could not create $name"
    }
}
