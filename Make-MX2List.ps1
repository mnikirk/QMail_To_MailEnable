$password_file = Get-Content file.txt
$out_file = ""

$sb = New-Object System.Text.StringBuilder
foreach ($line in $password_file)
{
    if ($line -match '^name:\s+(?<Name>(\w+)([\.|-]\w+)?)$')
    {
        $sb.Append($Matches.Name + ",")
    }
    if ($line -match '^clear passwd:\s(?<Password>.+)$')
    {
        $sb.Append($Matches.Password + ",")
    }
    if ($line -match '^dir:\s+/home/vpopmail/domains/(?<Domain>(\w+)(\..+)?(\.\w{3}))/(.+)$')
    {
        $sb.Append($Matches.Domain + "`r`n")
    }
}


Write-Host $sb.ToString()

Set-Content -Path $out_file -Value $sb.ToString().TrimEnd("`r`n`r`n`r`n`r`n")



# ^dir:\s+/home/vpopmail/domains/((\w+)(\..+)?(\.\w{3}))/(.+)$