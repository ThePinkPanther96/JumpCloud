# Auto remove local admin + csv report automation

## Description
JumpCloud is a great devices and users management tool. but one of the things that frustrate me the most is the fact that I can't give my end users specific permissions to a file, directory, or program, without digging deep into each user's registry or group policy. So if one of my teammates or I gave support to an end user and we needed to do all kinds of stuff on the user's computer that demands admin privileges, we always tend to forget to remove the user's Sudo/Administrator privileges. So from all the frustration, I've written this automation that generates a CSV report of all the users with administrator privileges on their device and removes it automatically, with exception of a few selected users and devices. You can place the automation in a task scheduler to run it automatically from a remote server.
## Requirements
- Windows 10 or higher 
- PowerShell 5 or higher
- JumpCloud PowerShell moudle
```nh
Install-Module JumpCloud
```
## Installation
Enter the code file and fill in the information according to the comments.
The code is divided into 3 sections:
1. Gets all of the local admins from all the devices in your tenant that are not in the excluded devices or users list.
2. Remove all local admins form the from the device that aren't in the excluded devices list.
3. Sends the report the a selected email via a SMTP server (smtp.office365.com in my case).


The excluded users and devices lists (accepts strings of the devices and usernames):
```nh
# Excluded systems and users

$Exclude_Users = @()
$Exclude_Devices = @()
```

In the Email credentials section you can set the sender email address, message description and message body.
```nh
#email credentials
$password = ConvertTo-SecureString 'Password' -AsPlainText -Force # Enter password for the sender email
$credential = New-Object System.Management.Automation.PSCredential ('Sender@Example.com', $password) # Enter sender eamil address

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
    -Subject "Subject" ` # Message Decription 
    -Credential $credential ` # Do Not Touch
    -Attachments $csvpath ` # Do Not Touch
    -Body $MailBody # Do Not Touch
```
