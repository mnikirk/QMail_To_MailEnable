param (
    [string]$file_path = ""
)

$Start = Get-Date

$OldSrvIP = ""
$NewSrvIP = "6"


$file = Get-Content -path $file_path

 foreach ($line in $file)
 {
    $dataInLine = $line -split(",")
    $Name = $dataInLine[0]
    $Password = $dataInLine[1]
    $domain = $dataInLine[2]
    $Email = $Name + "@$domain"

    .\imapsync.exe --host1 $OldSrvIP --user1 $Email --password1 $Password --host2 $NewSrvIP --user2 $Email --password2 $Password --useuid --delete2 --nofoldersizes --nofoldersizesatend --syncflagsaftercopy --tmpdir "w:"

    #Shouldn't need these as long as you don't log into webmail before sync
    #$IndexPath = 'E:\Program Files (x86)\Mail Enable\Postoffices\'+$TargetPostOffice+'\MAILROOT\'+$name+'\Inbox\_index.xml'
    #Write-Host 'Deleting mailbox index file to make migration work in webmail...'
    #Remove-Item -Path $IndexPath
       
 }

$End = Get-Date
New-TimeSpan -Start $Start -End $End
