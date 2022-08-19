param (
    [string]$file_path = ""
)

$MX2IP = ""
$MX2Port = "143"
$TargetPostOffice =""

$file = Get-Content -path $file_path
foreach ($line in $file)
{
    $dataInLine = $line -split(",")
    $name = $dataInLine[0]
    $password = $dataInLine[1]
    $domain = $dataInLine[2]
    $OldEmail = $name + "@domain1" #just for now
    $NewEmail = $name + "@domain2" #delete in production

    .\imapsync.exe --host1 $MX2IP --port1 $MX2Port --user1 $OldEmail --password1 $password --host2 68.68.80.13 --user2 $NewEmail --password2 $password --addheader

    #Shouldn't need these as long as you don't log into webmail before sync
    #$IndexPath = 'E:\Program Files (x86)\Mail Enable\Postoffices\'+$TargetPostOffice+'\MAILROOT\'+$name+'\Inbox\_index.xml'
    #Write-Host 'Deleting mailbox index file to make migration work in webmail...'
    #Remove-Item -Path $IndexPath
       
}
