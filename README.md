# QMail_To_MailEnable
 
These are scripts I used to migrate a lot of email accounts from an ancient (in computer years) qmail server to a Windows-based MailEnable server.  If anyone else on the internet ever has to do this too, here you go.  Run the Perl scripts first on qmail, creates output files of email addresses, aliases and groups, then copy the Powershell scripts and generated files on the Windows machine.  Depends on [imapsync](https://github.com/imapsync/imapsync)

The actual transfer went smoothly.  The only problem was, which would happen on any email server migration, was that a lot of real estate agents (the primary clients) had their emails set up on their iPhones as POP accounts.  Nothing good happens with POP on iPhones.

*Perl & Powershell*
