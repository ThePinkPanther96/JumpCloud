#Connectong to the JumpCloud Admin console with API key
$JumpCloudAPIKey = "" # Enter API here 

Import-Module JumpCloud

#Force parameter used to auth to JumpCloud API without update check 
Connect-JCOnline -JumpCloudAPIKey $JumpCloudAPIKey -force

#CSV credentials 
$CurrentDate = Get-Date
$CurrentDate = $CurrentDate.ToString('dd-MM-yyyy')
$csvpath = "C:\Local Admins - $CurrentDate.csv"

# Inported list settings
$IT_List = @()
$sysid = Get-JcSystem

# Excluded systems and users
$Exclude_Users = @()
$Exclude_Devices = @()

# Generate a list of all users that admin priviliges
foreach ($sid in $sysid) 
{      
    
    $IT_List +=  Get-JCSystemUser -SystemID $sid._id | Where-Object {

        $_.Administrator -eq "True" ` # Take only user that have Admin priviliges  
        -and $_.DisplayName -like "*" `
        -and $_.Username -notin $Exclude_Users ` # Don't show users from excluded users list 
        -and $_.DisplayName -notin $Exclude_Devices ` # Don't show devices from excluded devices list
    }   

}

# Export list to CSV
$IT_List | Export-Csv -Path $csvpath 

# For each of the selsected systems remove admin form attached users
foreach ($sid in Get-JcSystem)
{   
   
    $usernames =  Get-JCSystemUser -SystemID $sid._id | Where-Object {
        $_.SystemID -eq $sid._id `
        -and $_.Username -notin $Exclude_Users `
        -and $_.DisplayName -notin $Exclude_Devices `
    }   
    foreach ($username in $usernames.Username)
    {   
        Set-JCSystemUser -SystemID $sid._id -Username  $username -Administrator $false
    }
}

#email credentials
$password = ConvertTo-SecureString 'Password' -AsPlainText -Force # Enter password for the sender email
$credential = New-Object System.Management.Automation.PSCredential ('Sender@Example.com', $password) # Enter sender eamil address

#message settings 
$MailBody = "
              
Some Text...

"
# Message credentials
Send-MailMessage `
    -SmtpServer smtp.office365.com `
    -UseSsl `
    -Port 587 `
    -From "Sender@Example.com" `
    -to "Resever@Example.como" `
    -Subject "Subject" `
    -Credential $credential `
    -Attachments $csvpath `
    -Body $MailBody


    break
