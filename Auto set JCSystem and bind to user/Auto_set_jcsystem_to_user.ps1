# Enter Device Groups Here.
# Include the device gropus you that want your new device to bind with.
$device_groups = @() 

# Time Stamp
$CurrentDate = Get-Date
$CurrentDate = $CurrentDate.ToString('dddd dd-MM-yyyy HH:mm')

# Set SetbExecutionPolicy to be able to run scripts om local host
function Set-Execution {
    
    Set-ExecutionPolicy -ExecutionPolicy Unrestricted -Force -Confirm:$False
}

#Installing the JumpCloud PS module on
function Install_Jumpcloud {
    
    if (Get-InstalledModule | Where-Object {$_.name -like "JumpCloud"}) {

        Write-Host "JumpCloud Module already exists!" -BackgroundColor "Red" -ForegroundColor "DarkRed"
    }
    else {
        Write-Host "Installing JumpClud Module..." -ForegroundColor "Yellow"

        Install-Module JumpCloud -Force -Confirm:$False 
        
        Write-Host "JumpCloud Module installed!" -ForegroundColor "Yellow" -BackgroundColor "DarkGreen"
    } 
}

# Installing the JCAgent
function Install_JCAgent{
    
    Write-Host "Installing JumpCloud Agent..." -ForegroundColor "Yellow"

    ## Installing JumpCloud agent
    cd $env:temp | Invoke-Expression; Invoke-RestMethod `
    -Method Get -URI https://raw.githubusercontent.com/TheJumpCloud/support/master/scripts/windows/InstallWindowsAgent.ps1 `
    -OutFile InstallWindowsAgent.ps1 | Invoke-Expression; ./InstallWindowsAgent.ps1 `
    -JumpCloudConnectKey "" # Enter JCAgent installation script API here

    Write-Host "JumpCloud Agent installed!" -ForegroundColor "Yellow" -BackgroundColor "DarkGreen"
}

# Connecting to JumpCloud API
function Impot_Jumpcloud {
    
    Write-Host "Imporing JumpCloud Module..." -ForegroundColor "Yellow"

    #Connectong to the JumpCloud Admin console with API key
    $JumpCloudAPIKey = "" # Anter Administrator API here

    Import-Module JumpCloud

    #Force parameter used to auth to JumpCloud API without update check 
    Connect-JCOnline -JumpCloudAPIKey $JumpCloudAPIKey -force

    Write-Host "Connected to JumpCloud!" -ForegroundColor "Yellow" -BackgroundColor "DarkGreen" 
}

# Getting the Hostname
$hostname = hostname  

# Get JCSystem and bind with user
function new_device {
    
    $device_bind = Get-JCSystemInsights -Table SystemInfo | Where-Object {$_.hostname -eq $hostname}
    (
        [string]$device_groups,
        [string]$hostname
    )
    if (Get-JCSystem -hostname $hostname) {
        Write-Host "Binding device to groups..." -ForegroundColor "Yellow"

        foreach ($group in $device_groups){
            Add-JCSystemGroupMember -GroupName $group -SystemID $device_bind.SystemID
        }
        Write-Host "Divice bind with groups!" -ForegroundColor "Yellow" -BackgroundColor "DarkGreen"    
    }
    Write-Host "Binding device to user..." -ForegroundColor "Yellow"

    $sys_id = Get-JcSystem | Where-Object { $_.hostname -eq $hostname }
    Add-JCSystemUser -SystemID $sys_id._id -Username $username -Administrator $False

    Write-Host "JCUser added to JCSystem" -ForegroundColor "Yellow" -BackgroundColor "DarkGreen"    
}

# Change Host dispaly name on JumpCloud
function change_device_name {
    $new_device = Get-JCSystemInsights -Table SystemInfo | Where-Object {$_.hostname -eq $hostname}
    # You can setup the new displayname here
    $new_devicedisplayname = [string]::Concat("DEPARTMENT-", $username.ToUpper(), "-DESK")

    (   
        [string]$hostname,
        [string]$username
    )   
    if ((Get-JCSystem -hostname $hostname)){  
        Write-Host "Setting Dispalay Name..." -ForegroundColor "Yellow"

        foreach ($device in $new_device){
            $new_device = $device | Where-Object {$_.hostname -eq $hostname}
        }
        foreach ($i in $new_device){
        Set-JCSystem -displayName $new_devicedisplayname -SystemID $i.SystemID
        }
        Write-Host "Display Name set!" -ForegroundColor "Yellow" -BackgroundColor "DarkGreen"
    }
    else {
        Write-Host "Could not get device!" -BackgroundColor "Red" -ForegroundColor "DarkRed"
    }
}   

# Sending job summary alert to email
function Send_meassage {
    param (
        $hostname = $hostname.ToString(),
        $username = $username.ToString()
    )
    
    # Enter your sender email credentials 
    $password = ConvertTo-SecureString 'Password' -AsPlainText -Force
    $credential = New-Object System.Management.Automation.PSCredential ('chnmail@chainreaction11.onmicrosoft.com', $password)

    $MailBody = " 
    New System Online.

    Hostname: $hostname
    Username: $username

    Job time: $CurrentDate

    IT Depaerment."

    Send-MailMessage `
        -SmtpServer smtp.office365.com `
        -UseSsl `
        -Port 587 `
        -From "sender@example.com" `
        -to "reseaver@example.com" `
        -Subject "ITAutoMessage - New System Online" `
        -Credential $credential `
        -Body $MailBody
        #-Attachments
}

# User Imput + Function excecution
while ($True) {
    
    [string]$username = Read-Host "Enter Username: " 
    
    if ($username){
        Write-Host "Job Started..." -ForegroundColor "Yellow"
        
        Set-Execution
        Install_JCAgent
        Install_Jumpcloud
        Impot_Jumpcloud
        new_device
        change_device_name
        send_meassage

        Write-Host "Job Ended
        Closing program..." -ForegroundColor "Yellow"
        Start-Sleep -Seconds 2
        exit

    }
    else {
        Write-Host "No Input." -ForegroundColor "Red"
    }

}  
