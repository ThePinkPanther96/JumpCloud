#Connectong to the JumpCloud Admin console with API key
$JumpCloudAPIKey = "6c7e0e03c6715107a01c7083064c7cc8ebc13cac"

Import-Module JumpCloud

#Force parameter used to auth to JumpCloud API without update check 
Connect-JCOnline -JumpCloudAPIKey $JumpCloudAPIKey -force

#csv credentials 
$CurrentDate = Get-Date
$CurrentDate = $CurrentDate.ToString('dd-MM-yyyy')
$csvpath = "C:\Admins - $CurrentDate.csv"

#inported list settings
$IT_List = @()
$sysid = Get-JcSystem

#excluded systems and users
$Exclude_Users = @("chnadm", "centos", "designadm", "danielt", "galr", "romang", "bobk", "Chain-Reaction571")
$Exclude_Devices = @("ILTLV-SWRSHAY-LP", "ILTLV-SWKOR-LP", "ILTLV-SWSMICHAL-LP", 
"ILTLV-SWMUDI-LP", "ILYK-SWMYAKIR-LP", "SFTP", "ILTLV-SWKOGTAL-LP", "ILTLV-SWEELINOY-LP",
"ILTLV-LAB-DESK", "ILTLV-SWKNOAM-LP")

foreach ($sid in $sysid) 
{      
    
    $IT_List +=  Get-JCSystemUser -SystemID $sid._id | Where-Object {

        $_.Administrator -eq "True" `
        -and $_.DisplayName -like "*" `
        -and $_.Username -notin $Exclude_Users `
        -and $_.DisplayName -notin $Exclude_Devices `
    }   

}

$IT_List | Export-Csv -Path $csvpath 

#chamail credentials
$password = ConvertTo-SecureString 'Ch756125!' -AsPlainText -Force
$credential = New-Object System.Management.Automation.PSCredential ('chnmail@chainreaction11.onmicrosoft.com', $password)

#message settings 
$MailBody = "Please find the attached file to see a list of systems with local admins enabled.

Cahin-Reaction IT Depaerment."

Send-MailMessage `
    -SmtpServer smtp.office365.com `
    -UseSsl `
    -Port 587 `
    -From "chnmail@chainreaction11.onmicrosoft.com" `
    -to "ITTeam@chain-reaction.io" `
    -Subject "ITAutoMessage - Daily Local Admins Report" `
    -Credential $credential `
    -Attachments $csvpath `
    -Body $MailBody

break
