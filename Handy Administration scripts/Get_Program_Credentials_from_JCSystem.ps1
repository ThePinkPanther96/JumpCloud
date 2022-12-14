## This simple script allows you to easily search for a specific program or software that is installed on multiple systems, 
## for all kinds of administration purposes. ##

#Install-Module JumpCloud
Import-Module JumpCloud
Connect-JCOnline "" # Enter API here

$systemsIDs=@{}

$systemsIDs = Get-JCSystem 
    
foreach ($i in  $systemsIDs ) 
{
    #write-output $i._id
    $b =  Get-JCSystemInsights -Table Program -id $i._id | Where-Object {$_.Name -like  "**" } # Enter the name or a part of the name of the program that you want to search
    
    write-output  $b.hostname "" $b.version $b.UninstallString 

}
