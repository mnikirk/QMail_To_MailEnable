param (
    [string]$file_path = "" #default file path here if none provided in args
)

$PostOffice = "" #add these in
$BaseAddress = ""
$AddAddress = ""

$file = Get-Content -path $file_path
$sb = New-Object System.Text.StringBuilder

foreach ($line in $file)
{
    if ($line -match '/homefinder\.org/\.qmail-(?<Name>.+)$')
    {
        $Name = $Matches.Name
        $AddAddress = $Name -replace ':','.'
        Write-Host ""
        $sb.Append($AddAddress+",")
    }
    if ($line -match '^\s(?<Addr>.+)@')
    {
        $BaseAddress = $Matches.Addr
        Write-Host "" #If I don't have a write-host somewhere up here then the later sb.tostring() doesn't work
        $sb.Append($BaseAddress+"`r`n")
    }
    
    
}
$FormattedList = $sb.ToString()

Set-Content -Path .\alias_tmp.txt -Value $FormattedList
$list = Get-Content -Path .\alias_tmp.txt

foreach ($line in $list)
{
    $APoorlyNamedVar = $line -split(",")
    $NewEmail = $APoorlyNamedVar[0] + "@$PostOffice"
    $Acct = $APoorlyNamedVar[1]
    if ($NewEmail -eq $null -or $Acct -eq $null) { break; }
    #Write-Host "New-MailEnableAddressMap -EMailAddress $NewEmail -Postoffice $PostOffice -Mailbox $Acct"
    New-MailEnableAddressMap -EMailAddress $NewEmail -Postoffice $PostOffice -Mailbox $Acct
}
Remove-Item -Path .\alias_tmp.txt
