# Auto remove local admin + csv report automation

## Description
JumpCloud proves to be an excellent tool for managing devices and users, yet a persistent frustration lies in the inability to grant specific permissions to files, directories, or programs for end users. This often necessitates delving into intricate user registries or group policies. When providing support to users and performing tasks demanding admin privileges, the oversight of removing Sudo/Administrator privileges can be recurrent.

To address this challenge, I've developed an automation solution. This automation not only generates a comprehensive CSV report enumerating users with administrator privileges on their devices but also automatically revokes these privileges. Notably, exemptions are in place for selected users and devices. By deploying this solution within a task scheduler on a remote server, you can establish an automated process that mitigates these frustrations and ensures streamlined privilege management.
## Requirements
- Windows 10 or higher 
- PowerShell 5 or higher
- JumpCloud PowerShell module
- Active JumpCloud account 
```nh
Install-Module JumpCloud
```
## Installation
Below is the code file divided into three main sections, each serving a specific purpose:

Section 1: Get Local Admins
In this section, the script retrieves a list of all local administrators from devices within your tenant, excluding those listed in the designated exclusion devices or users list.

Section 2: Remove Local Admin
Here, the script proceeds to remove local administrator privileges from devices not included in the exclusion devices list. The exemptions still apply.

Section 3: Send Report via SMTP
This part takes care of sending a comprehensive report via an SMTP server (in this case, smtp.office365.com). The report includes details about the changes made. Make sure to provide the necessary SMTP server configuration and recipient email address.

Exclusion Lists:
Below, you can specify the excluded users and devices. You can input strings representing the device names or usernames that should not be processed by the script.

```nh
# Excluded systems and users

$Exclude_Users = @()
$Exclude_Devices = @()
```

In the Email credentials section, you can set the sender's email address, message description, and message body.
```nh
#email credentials
$password = ConvertTo-SecureString 'Password' -AsPlainText -Force # Enter password for the sender email
$credential = New-Object System.Management.Automation.PSCredential ('Sender@Example.com', $password) # Enter sender email address

#message settings 
$MailBody = "
              
Some Text...

"
# Message credentials
Send-MailMessage `
    -SmtpServer smtp.office365.com ` # SMTP Server
    -UseSsl `
    -Port 587 ` # SMTP Port
    -From "Sender@Example.com" ` # Sender address
    -to "Resever@Example.como" ` # Receiver address
    -Subject "Subject" ` # Message Description 
    -Credential $credential ` # Do Not Touch
    -Attachments $csvpath ` # Do Not Touch
    -Body $MailBody # Do Not Touch
```
