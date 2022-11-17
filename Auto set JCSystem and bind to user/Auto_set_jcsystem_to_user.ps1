#---------------------------------------------------------[Initialisations]--------------------------------------------------------
# Init PowerShell Gui
Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

#---------------------------------------------------------------[Form]-------------------------------------------------------------
[System.Windows.Forms.Application]::EnableVisualStyles()

$mailtaitel = "Auto Except JCSystem v3.1"
# Create a new form
$Form                             = New-Object system.Windows.Forms.Form
# Define the size, title and background color
$Form.ClientSize                  = '535,160'
$Form.text                        = $mailtaitel
$Form.BackColor                   = "#f5f5f5"

# Main Text
$Titel                            = New-Object system.Windows.Forms.Label
$Titel.text                       = "Auto Except JCSystem"
$Titel.AutoSize                   = $true
$Titel.width                      = 25
$Titel.height                     = 10
$Titel.location                   = New-Object System.Drawing.Point(20,20)
$Titel.Font                       = 'Microsoft Sans Serif,15'
 
$Description                      = New-Object system.Windows.Forms.Label
$Description.text                 = "This tool was custom made for automating JCSytem exception to JumpCloud."
$Description.AutoSize             = $false
$Description.width                = 600
$Description.height               = 20
$Description.location             = New-Object System.Drawing.Point(20,48)
$Description.Font                 = 'Microsoft Sans Serif,11'

# User credentails
$Usernamex                        = New-Object system.Windows.Forms.Label
$Usernamex.text                   = "Username:"
$Usernamex.AutoSize               = $false
$Usernamex.width                  = 100
$Usernamex.height                 = 20
$Usernamex.location               = New-Object System.Drawing.Point(20,80)
$Usernamex.Font                   = 'Microsoft Sans Serif,11'

$Usernametext                     = New-Object system.Windows.Forms.TextBox
$Usernametext.multiline           = $false
$Usernametext.width               = 120
$Usernametext.height              = 30
$Usernametext.location            = New-Object System.Drawing.Point(20,110)
$Usernametext.Font                = 'Microsoft Sans Serif,12'
$Usernametext.Visible             = $True

# Progress 
$status                           = New-Object system.Windows.Forms.Label
$status.text                      = ""
$status.ForeColor                 = "Red"
$status.AutoSize                  = $false
$status.width                     = 400
$status.height                    = 60
$status.location                  = New-Object System.Drawing.Point(200,117)
$status.Font                      = 'Microsoft Sans Serif,10'

$statustext                       = New-Object system.Windows.Forms.Label
$statustext.text                  = "Status: "
$statustext.AutoSize              = $false
$statustext.width                 = 57
$statustext.height                = 60
$statustext.location              = New-Object System.Drawing.Point(145,115)
$statustext.Font                  = 'Microsoft Sans Serif,12'

# Buttons
$RunBtn                           = New-Object system.Windows.Forms.Button
$RunBtn.BackColor                 = "#f5f5f5"
$RunBtn.text                      = "Run"
$RunBtn.width                     = 90
$RunBtn.height                    = 30
$RunBtn.location                  = New-Object System.Drawing.Point(420,110)
$RunBtn.Font                      = 'Microsoft Sans Serif,10'
$RunBtn.ForeColor                 = "#000"

$cancelBtn                        = New-Object system.Windows.Forms.Button
$cancelBtn.BackColor              = "#f5f5f5"
$cancelBtn.text                   = "Cancel"
$cancelBtn.width                  = 90
$cancelBtn.height                 = 30
$cancelBtn.location               = New-Object System.Drawing.Point(310,110)
$cancelBtn.Font                   = 'Microsoft Sans Serif,10'
$cancelBtn.ForeColor              = "#000"
$cancelBtn.DialogResult           = [System.Windows.Forms.DialogResult]::Cancel
#$Form.CancelButton                = $cancelBtn
#$Form.Controls.Add($cancelBtn)

# Logo
$img = [System.Drawing.Image]::Fromfile('') # Logo Image here (Optional)
$pictureBox = new-object Windows.Forms.PictureBox
$pictureBox.Width = $img.Size.Width
$pictureBox.Height = $img.Size.Height
$pictureBox.Image = $img
$Picturebox.Location = '283,27'
$Form.controls.add($pictureBox)

$MsgBoxError = [System.Windows.Forms.MessageBox]

# Add the elements to the form
$Form.controls.AddRange(@($Titel,$Description,$RunBtn,$cancelBtn,$pictureBox,$Usernamex,$Usernametext,$statustext,$status))
# THIS SHOULD BE AT THE END OF YOUR SCRIPT FOR NOW
# Display the form

$cancelBtn.Add_Click({ cancel })
$RunBtn.Add_Click({ run })

#--------------------------------------------------------------[Functions]------------------------------------------------------------

function start_popup {

    [reflection.assembly]::loadwithpartialname('System.Windows.Forms')
    [reflection.assembly]::loadwithpartialname('System.Drawing')
    $notify = new-object system.windows.forms.notifyicon
    $notify.icon = [System.Drawing.SystemIcons]::Information
    $notify.visible = $true
    $notify.showballoontip(10000,'Auto Except JCSystem','Job started!',[system.windows.forms.tooltipicon]::Info)    
}

function end_popup {
    
    [reflection.assembly]::loadwithpartialname('System.Windows.Forms')
    [reflection.assembly]::loadwithpartialname('System.Drawing')
    $notify = new-object system.windows.forms.notifyicon
    $notify.icon = [System.Drawing.SystemIcons]::Information
    $notify.visible = $true
    $notify.showballoontip(10000,'Auto Except JCSystem','Job Finished Successfully!',[system.windows.forms.tooltipicon]::Info)    
}

# Vars
$device_groups = @("") #Device groups here

#---------------------------------------------------------------[Script]-------------------------------------------------------------
 

# Time Stamp
$CurrentDate = Get-Date
$CurrentDate = $CurrentDate.ToString('dddd dd-MM-yyyy HH:mm')

# Set SetbExecutionPolicy to be able to run scripts om local host
function Set-Execution {
    
    Set-ExecutionPolicy -ExecutionPolicy Unrestricted -Confirm:$False -Force
}

#Installing the JumpCloud PS module on
function Install_Jumpcloud {
    while ($True) {
        if (!(Get-InstalledModule | Where-Object {$_.name -like "JumpCloud"})) {
            try {
            
                Write-Host "Installing JumpClud Module..." -ForegroundColor "Yellow"
            
                Install-PackageProvider -Name NuGet -MinimumVersion 2.8.5.201 -Force
                
                Install-Module JumpCloud -Force -Confirm:$False

                Write-Host "JumpCloud Module installed!" -ForegroundColor "Yellow" -BackgroundColor "DarkGreen"
             
            }
            catch [System.SystemException] {
                $MsgBoxError::Show("Something went wrong while trying to Install JumpCloud Module.
        
        Try Running The Program Agian.", $mailtaitel, "OK", "Error")
        
                Exit
            }   
        }
        else {
            Write-Host "JumpCloud Module Already Exists!" -ForegroundColor "Black" -BackgroundColor "Red"

            return;
        }  
    }
    else {
        $MsgBoxError::Show("Could Not Install JumpCloud!

        Check your Internet Connection And Click OK.", $mailtaitel, "OK", "Warning")
    }
}

# Installing the JCAgent
function Install_JCAgent {
    
    try {
        Write-Host "Installing JumpCloud Agent..." -ForegroundColor "Yellow"

        ## Installing JumpCloud agent
        cd $env:temp | Invoke-Expression; Invoke-RestMethod `
        -Method Get -URI https://raw.githubusercontent.com/TheJumpCloud/support/master/scripts/windows/InstallWindowsAgent.ps1 `
        -OutFile InstallWindowsAgent.ps1 | Invoke-Expression; ./InstallWindowsAgent.ps1 `
        -JumpCloudConnectKey "" # JumpCLoud agent installation API here
    
        Write-Host "JumpCloud Agent installed!" -ForegroundColor "Yellow" -BackgroundColor "DarkGreen"
    }
    catch [System.SystemException] {
        
        $MsgBoxError::Show("Something went wrong while trying to Install JumpCloud Agent.

Try Running The Program Agian or contact your System Administrator.", $mailtaitel, "OK", "Error")

    }

}

# Connecting to JumpCloud API
function Impot_Jumpcloud {
    
    Write-Host "Imporing JumpCloud Module..." -ForegroundColor "Yellow"

    #Connectong to the JumpCloud Admin console with API key
    $JumpCloudAPIKey = "" # JumpCloud Administrator API hrer
 
    Import-Module JumpCloud

    #Force parameter used to auth to JumpCloud API without update check 
    Connect-JCOnline -JumpCloudAPIKey $JumpCloudAPIKey -force

    Write-Host "Connected to JumpCloud!" -ForegroundColor "Yellow" -BackgroundColor "DarkGreen" 
}

# Getting the Hostname
$hostname = @()
$hostname = hostname  

# Get JCSystem and bind with user
function new_device {

    param (
        $hostname = $hostname
    )
    
    try {
        $device_bind = Get-JCSystemInsights -Table SystemInfo | Where-Object {$_.hostname -eq $hostname}
  
        if (Get-JCSystem -hostname $hostname) {
            foreach ($group in $device_groups){
                Add-JCSystemGroupMember -GroupName $group -SystemID $device_bind.SystemID
            }
            Write-Host "Divice bind with groups!" -ForegroundColor "Yellow" -BackgroundColor "DarkGreen"    

            $sys_id = Get-JcSystem | Where-Object { $_.hostname -eq $hostname }
            Add-JCSystemUser -SystemID $sys_id._id -Username $Usernametext.Text -Administrator $False

            Write-Host "JCUser added to JCSystem" -ForegroundColor "Yellow" -BackgroundColor "DarkGreen"
        }   
        else {
            $MsgBoxError::Show("JumpCloud was not installed currectlly!
    
    Please run the program again.", $mailtaitel, "OK", "Error")
    
            Exit
        }    
    }
    catch [System.SystemException] {
        $MsgBoxError::Show("Something went wrong while trying to create device.

Please contact your System Administrator.", $mailtaitel, "OK", "Error")
    }
}

# Change Host dispaly name on JumpCloud
function change_device_name {

    param (
        $hostname = $hostname
    )
    
    try {
        $new_device = Get-JCSystemInsights -Table SystemInfo | Where-Object {$_.hostname -eq $hostname}
        $new_devicedisplayname = [string]::Concat("USSJ-", $Usernametext.Text.ToUpper(), "-LP")

    if ((Get-JCSystem -hostname $hostname)){  
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
        
        $MsgBoxError::Show("Could not get device while tying to change the hostname!", $mailtaitel, "OK", "Error")
    }
    }
    catch [System.SystemException] {
        $MsgBoxError::Show("Something went wrong while trying to name device.

Please contact your System Administrator.", $mailtaitel, "OK", "Error")
    }
}   

# Sending job summary alert to email
function Send_meassage {
    param (
        $hostname = $hostname.ToString(),
        $username = $Usernametext.Text
    )
    
    #chamail credentials
    $password = ConvertTo-SecureString 'Ch756125!' -AsPlainText -Force
    $credential = New-Object System.Management.Automation.PSCredential ('chnmail@chainreaction11.onmicrosoft.com', $password)

    $MailBody = " 
    New System Online.

    Hostname: $new_devicedisplayname
    Username: $usernametext

    Creation time: $CurrentDate

    Cahin-Reaction IT Depaerment."

    Send-MailMessage `
        -SmtpServer smtp.office365.com `
        -UseSsl `
        -Port 587 `
        -From "chnmail@chainreaction11.onmicrosoft.com" `
        -to "galr@chain-reaction.io" `
        -Subject "ITAutoMessage - New System Online" `
        -Credential $credential `
        -Body $MailBody
        #-Attachments
}


#-------------------------------------------------------------[Show form]------------------------------------------------------------

function cancel () {
    $null
    Write-Host 'User pressed Cancel' -ForegroundColor 'Black' -BackgroundColor 'Red'
}

function run ()
{   
    Write-Host 'User pressed Run' -ForegroundColor 'Green' -BackgroundColor 'Yellow'    
    if (($Usernametext.Text)){

        $status.text = "Job Strating..."
        Start-Sleep -Seconds 1
        start_popup
        $status.text = "Setting Execution..."
        Start-Sleep -Seconds 1
        Set-Execution
        $status.text = "Installing JCAgent..."
        Start-Sleep -Seconds 1
        Install_JCAgent
        $status.text = "Installing JumpCoud..."
        Start-Sleep -Seconds 1
        Install_Jumpcloud
        $status.text = "Importing JumpCloud..."
        Start-Sleep -Seconds 1
        Impot_Jumpcloud
        run1
    }
    else {
        $MsgBoxError::Show("Missing Parameters! Please fill Username.", $mailtaitel, "OK", "Warning")
    }  
}

function run1 {
    if((Get-JCUser -username $Usernametext.Text)){
       
        $status.text = "Adding Device..."
        Start-Sleep -Seconds 1
        new_device
        $status.text = "Changing Device Name..."
        Start-Sleep -Seconds 1
        change_device_name
        $status.text = "Finnishin Job..."
        Start-Sleep -Seconds 1
        send_meassage
        Start-Sleep -Seconds 1
        end_popup
        closeForm
        
    }
    else {
        $MsgBoxError::Show("User Was Not Found! Please Enter a New Username.", $mailtaitel, "OK", "Error")
    }
}
function closeForm(){$Form.close()}

[void]$Form.ShowDialog()
