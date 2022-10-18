#---------------------------------------------------------[Initialisations]--------------------------------------------------------
# Init PowerShell Gui
Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

#---------------------------------------------------------------[Form]-------------------------------------------------------------
[System.Windows.Forms.Application]::EnableVisualStyles()

$mailtaitel = "JumpCloud Swiss Army Tool v1.3"
# Create a new form
$Form                             = New-Object system.Windows.Forms.Form
# Define the size, title and background color
$Form.ClientSize                  = '535,400'
$Form.text                        = $mailtaitel
$Form.BackColor                   = "#f5f5f5"

# Main Text
$Titel                            = New-Object system.Windows.Forms.Label
$Titel.text                       = "The JumpCloud Swiss Army Tool"
$Titel.AutoSize                   = $true
$Titel.width                      = 25
$Titel.height                     = 10
$Titel.location                   = New-Object System.Drawing.Point(20,20)
$Titel.Font                       = 'Microsoft Sans Serif,15'
 
$Description                      = New-Object system.Windows.Forms.Label
$Description.text                 = "This tool was costume made for automating JC users and devices creation."
$Description.AutoSize             = $false
$Description.width                = 600
$Description.height               = 20
$Description.location             = New-Object System.Drawing.Point(20,48)
$Description.Font                 = 'Microsoft Sans Serif,11'

# User
$Titel2                           = New-Object system.Windows.Forms.Label
$Titel2.text                      = "JCUser Creadentials"
$Titel2.AutoSize                  = $true
$Titel2.width                     = 25
$Titel2.height                    = 10
$Titel2.location                  = New-Object System.Drawing.Point(20,80)
$Titel2.Font                      = 'Microsoft Sans Serif,13'

# First name
$Firstname                        = New-Object system.Windows.Forms.Label
$Firstname.text                   = "First name:"
$Firstname.AutoSize               = $false
$Firstname.width                  = 100
$Firstname.height                 = 20
$Firstname.location               = New-Object System.Drawing.Point(20,110)
$Firstname.Font                   = 'Microsoft Sans Serif,10'

$Firstnametext                    = New-Object system.Windows.Forms.TextBox
$Firstnametext.multiline          = $false
$Firstnametext.width              = 100
$Firstnametext.height             = 30
$Firstnametext.location           = New-Object System.Drawing.Point(20,135)
$Firstnametext.Font               = 'Microsoft Sans Serif,12'
$Firstnametext.Visible            = $True

# Last name
$Lastname                         = New-Object system.Windows.Forms.Label
$Lastname.text                    = "Last name:"
$Lastname.AutoSize                = $false
$Lastname.width                   = 100
$Lastname.height                  = 20
$Lastname.location                = New-Object System.Drawing.Point(150,110)
$Lastname.Font                    = 'Microsoft Sans Serif,10'

$Lastnametext                     = New-Object system.Windows.Forms.TextBox
$Lastnametext.multiline           = $false
$Lastnametext.width               = 100
$Lastnametext.height              = 30
$Lastnametext.location            = New-Object System.Drawing.Point(150,135)
$Lastnametext.Font                = 'Microsoft Sans Serif,12'
$Lastnametext.Visible             = $True

# Username
$Usernamex                         = New-Object system.Windows.Forms.Label
$Usernamex.text                    = "Username:"
$Usernamex.AutoSize                = $false
$Usernamex.width                   = 100
$Usernamex.height                  = 20
$Usernamex.location                = New-Object System.Drawing.Point(280,110)
$Usernamex.Font                    = 'Microsoft Sans Serif,10'

$Usernametext                      = New-Object system.Windows.Forms.TextBox
$Usernametext.multiline            = $false
$Usernametext.width                = 100
$Usernametext.height               = 30
$Usernametext.location             = New-Object System.Drawing.Point(280,135)
$Usernametext.Font                 = 'Microsoft Sans Serif,12'
$Usernametext.Visible              = $True
 
# User ID
$User_id                           = New-Object system.Windows.Forms.Label
$User_id.text                      = "User ID:"
$User_id.AutoSize                  = $false
$User_id.width                     = 100
$User_id.height                    = 20
$User_id.location                  = New-Object System.Drawing.Point(410,110)
$User_id.Font                      = 'Microsoft Sans Serif,10'

$User_idtext                       = New-Object system.Windows.Forms.TextBox
$User_idtext.multiline             = $false
$User_idtext.width                 = 100
$User_idtext.height                = 30
$User_idtext.location              = New-Object System.Drawing.Point(410,135)
$User_idtext.Font                  = 'Microsoft Sans Serif,12'
$User_idtext.Visible               = $True

# Groups
$Titel4                            = New-Object system.Windows.Forms.Label
$Titel4.text                       = "Groups Credentials"
$Titel4.AutoSize                   = $true
$Titel4.width                      = 25
$Titel4.height                     = 10
$Titel4.location                   = New-Object System.Drawing.Point(310,180)
$Titel4.Font                       = 'Microsoft Sans Serif,13'

$Groupname                         = New-Object system.Windows.Forms.Label
$Groupname.text                    = "Group:"
$Groupname.AutoSize                = $false
$Groupname.width                   = 100
$Groupname.height                  = 20
$Groupname.location                = New-Object System.Drawing.Point(310,210)
$Groupname.Font                    = 'Microsoft Sans Serif,10'

$Groupdropmenu                     = New-Object system.Windows.Forms.ComboBox
$Groupdropmenu.text                = ""
$Groupdropmenu.width               = 120
$Groupdropmenu.autosize            = $true
# Add the items in the dropdown list
## HERE YOU CAN ADD GROUPS TO THE DROPDOWN MENU
@('Group 1','Group 2','Group 3','Group 4') | ForEach-Object {[void] $Groupdropmenu.Items.Add($_)}
# Select the default value
$Groupdropmenu.SelectedIndex       = -1
$Groupdropmenu.location            = New-Object System.Drawing.Point(310,235)
$Groupdropmenu.Font                = 'Microsoft Sans Serif,10'

# Device
$Titel3                            = New-Object system.Windows.Forms.Label
$Titel3.text                       = "JCSystem Credentials"
$Titel3.AutoSize                   = $true
$Titel3.width                      = 25
$Titel3.height                     = 10
$Titel3.location                   = New-Object System.Drawing.Point(20,180)
$Titel3.Font                       = 'Microsoft Sans Serif,13'

$Devicename                        = New-Object system.Windows.Forms.Label
$Devicename.text                   = "Hostname:"
$Devicename.AutoSize               = $false
$Devicename.width                  = 100
$Devicename.height                 = 20
$Devicename.location               = New-Object System.Drawing.Point(20,210)
$Devicename.Font                   = 'Microsoft Sans Serif,10'

$deviceetext                       = New-Object system.Windows.Forms.TextBox
$deviceetext.multiline             = $false
$deviceetext.width                 = 120
$deviceetext.height                = 30
$deviceetext.location              = New-Object System.Drawing.Point(20,235)
$deviceetext.Font                  = 'Microsoft Sans Serif,12'
$deviceetext.Visible               = $True

# Progress 
$status                            = New-Object system.Windows.Forms.Label
$status.text                       = ""
$status.ForeColor                  = "Red"
$status.AutoSize                   = $false
$status.width                      = 400
$status.height                     = 60
$status.location                   = New-Object System.Drawing.Point(77,280)
$status.Font                       = 'Microsoft Sans Serif,10'

$statustext                       = New-Object system.Windows.Forms.Label
$statustext.text                  = "Status: "
$statustext.AutoSize              = $false
$statustext.width                 = 60
$statustext.height                = 60
$statustext.location              = New-Object System.Drawing.Point(20,280)
$statustext.Font                  = 'Microsoft Sans Serif,12'

# Buttons
$RunBtn                           = New-Object system.Windows.Forms.Button
$RunBtn.BackColor                 = "#f5f5f5"
$RunBtn.text                      = "Run"
$RunBtn.width                     = 90
$RunBtn.height                    = 30
$RunBtn.location                  = New-Object System.Drawing.Point(420,350)
$RunBtn.Font                      = 'Microsoft Sans Serif,10'
$RunBtn.ForeColor                 = "#000"

$cancelBtn                        = New-Object system.Windows.Forms.Button
$cancelBtn.BackColor              = "#f5f5f5"
$cancelBtn.text                   = "Cancel"
$cancelBtn.width                  = 90
$cancelBtn.height                 = 30
$cancelBtn.location               = New-Object System.Drawing.Point(310,350)
$cancelBtn.Font                   = 'Microsoft Sans Serif,10'
$cancelBtn.ForeColor              = "#000"
$cancelBtn.DialogResult           = [System.Windows.Forms.DialogResult]::Cancel
#$Form.CancelButton                = $cancelBtn
#$Form.Controls.Add($cancelBtn)

# Logo
$img = [System.Drawing.Image]::Fromfile('') ## PUT YOUR LOGO PATH HERE ##
$pictureBox = new-object Windows.Forms.PictureBox
$pictureBox.Width = $img.Size.Width
$pictureBox.Height = $img.Size.Height
$pictureBox.Image = $img
$Picturebox.Location = '20,330'
$Form.controls.add($pictureBox)

$MsgBoxError = [System.Windows.Forms.MessageBox]

# Add the elements to the form
$Form.controls.AddRange(@($Titel,$Description,$Titel2,$Titel3,$Firstname,$Lastname,
$Firstnametext,$Lastnametext,$Usernametext,$deviceetext,$Groupdropmenu,$Devicename,$Titel4,$Groupname, 
$RunBtn,$cancelBtn,$pictureBox,$Usernamex,$User_id,$User_idtext,$statustext, $status))
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
    $notify.showballoontip(10000,'The JumpCloud Swiss Army Tool','Job started!',[system.windows.forms.tooltipicon]::Info)    
}

function end_popup {
    
    [reflection.assembly]::loadwithpartialname('System.Windows.Forms')
    [reflection.assembly]::loadwithpartialname('System.Drawing')
    $notify = new-object system.windows.forms.notifyicon
    $notify.icon = [System.Drawing.SystemIcons]::Information
    $notify.visible = $true
    $notify.showballoontip(10000,'The JumpCloud Swiss Army Tool','Job Finished Successfully!',[system.windows.forms.tooltipicon]::Info)    
}

# Inport Variables

## PUT YOUR DEVICE GROUPS HERE
## According to the to bind_device function
# Device Groups 
$device_group1 = @()
$device_group2 = @()
$device_group3 = @()
$device_group4 = @()

## PUT YOUR USER GROUPS HERE
## According to the to bind_user function
# User Groups
$user_group1 = @()
$user_group2 = @()
$user_group3 = @()
$user_group4 = @()

#---------------------------------------------------------------[Script]-------------------------------------------------------------

function connect {
    
    #Connectong to the JumpCloud Admin console with API key
    Import-Module JumpCloud
    $JumpCloudAPIKey = "" ## PUT YOUR API HERE
    Connect-JCOnline -JumpCloudAPIKey $JumpCloudAPIKey -force
    
}

# Create JCUser
function create_user {
    
    $email = $email
    $display_name = [string]::Concat($Firstnametext.Text, " ", $Lastnametext.Text)
    $url = "@Example.com"  ## ENTER THE EMAIL ADDRESS HERE
    $email = [string]::Concat($Usernametext.Text, $url)
    try {
        if (!(Get-JCUser -username $Usernametext.Text)){

            New-JCUser -Username $Usernametext.Text `
            -firstname $Firstnametext.Text `
            -lastname $Lastnametext.Text `
            -displayname $display_name `
            -email $email `
            -employeeIdentifier $User_idtext.Text `
            -password_never_expires $false `
            -ldap_binding_user $true
            # -Password               
            
            Write-Host "User created successfully!" -ForegroundColor "Yellow" -BackgroundColor "DarkGreen"
        } 
        else{
            Write-Host "User already exists!" -BackgroundColor "Red" -ForegroundColor "DarkRed"

            $MsgBoxError::Show("User already exists.

Click OK to cuntinue the job.", $mailtaitel, "OK", "Warning")
        }
    }
    catch [System.SystemException] {
        $MsgBoxError::Show("Something went wrong while trying to create user.

Please contact your System Administrator.", $mailtaitel, "OK", "Error")

    }
    
} 

# Bind JCUser to groups

## NOTE!! If you changed the names of the groups in the Dropdown menu, 
#  you also need to change them accordingly here.
function bind_user () {
    
    Try {
        if ($Groupdropmenu.Text -eq "Group 1"){

            foreach ($group in $user_group1){
    
                Add-JCUserGroupMember -GroupName $group -Username $Usernametext.Text
            } 
            Write-Host "User bind to group!" -ForegroundColor "Yellow" -BackgroundColor "DarkGreen"
        }
        elseif ($Groupdropmenu.Text -eq "Group 2") {
            
            foreach ($group in $user_group2){
    
                Add-JCUserGroupMember -GroupName $group -Username $Usernametext.Text
            }
            
            Write-Host "User bind to group!" -ForegroundColor "Yellow" -BackgroundColor "DarkGreen"
        }
        elseif ($Groupdropmenu.Text -eq "Group 3") {
            
            foreach ($group in $user_group3){
    
                Add-JCUserGroupMember -GroupName $group -Username $Usernametext.Text
            }
            
            Write-Host "User bind to group!" -ForegroundColor "Yellow" -BackgroundColor "DarkGreen"
        }
        elseif ($Groupdropmenu.Text -eq "Group 4") {
            
            foreach ($group in $user_group4){
    
                Add-JCUserGroupMember -GroupName $group -Username $Usernametext.Text
            } 
            
            Write-Host "User bind to group!" -ForegroundColor "Yellow" -BackgroundColor "DarkGreen"
        }

    }
    catch {
        $MsgBoxError::Show("Unexpected Error!

Can't bind user to group.", $mailtaitel, "OK", "Error")
    } 
}

function create_device () {
    
    try {

        if ($deviceetext.Text){

            $new_device = Get-JCSystemInsights -Table SystemInfo | Where-Object {$_.hostname -eq $deviceetext.Text}
            $new_devicedisplayname = [string]::Concat("PC-", $Usernametext.Text.ToUpper(), "-LP")
            
            if ((Get-JCSystem -hostname $deviceetext.Text)){  
                
                foreach ($device in $new_device){
                    $new_device = $device | Where-Object {$_.hostname -eq $deviceetext.Text}
                }
                foreach ($i in $new_device){
                Set-JCSystem -displayName $new_devicedisplayname -SystemID $i.SystemID
                }
                
                Write-Host "Display Name set!" -ForegroundColor "Yellow" -BackgroundColor "DarkGreen"
            }
            else {
                $MsgBoxError::Show("Host Nmae was not found!
                
Finnishing the job. (User created)", $mailtaitel, "OK", "Error")

            }

        }
    }
    catch [System.SystemException] {
        $MsgBoxError::Show("Something went wrong while trying to create device.

Please contact your System Administrator.", $mailtaitel, "OK", "Error")
    }  
}

# Bind Device to groups

## NOTE!! If you changed the names of the groups in the Dropdown menu, 
#  you also need to change them accordingly here.
function bind_device () {

    $device_bind = Get-JCSystemInsights -Table SystemInfo | Where-Object {$_.hostname -eq $deviceetext.Text}
    try {
        if (Get-JCSystem -hostname $deviceetext.Text) {
            
            if ($Groupdropmenu.text -eq "Group 1"){
                
                foreach ($group in $device_group1){
                    Add-JCSystemGroupMember -GroupName $group -SystemID $device_bind.SystemID
                }
                
                Write-Host "Divice bind with groups!" -ForegroundColor "Yellow" -BackgroundColor "DarkGreen"
            }
            elseif ($Groupdropmenu.text -eq "Group 2") {
                
                foreach ($group in $device_group2){
                    Add-JCSystemGroupMember -GroupName $group -SystemID $device_bind.SystemID
                }
                
                Write-Host "Divice bind with groups!" -ForegroundColor "Yellow" -BackgroundColor "DarkGreen"
            }
            elseif ($Groupdropmenu.text -eq "Group 3") {
                
                foreach ($group in $device_group3){
                    Add-JCSystemGroupMember -GroupName $group -SystemID $device_bind.SystemID
                }
                
                Write-Host "Divice bind with groups!" -ForegroundColor "Yellow" -BackgroundColor "DarkGreen"
            }
            elseif ($Groupdropmenu.text -eq "Group 4") {
                
                foreach ($group in $device_group4){
                    Add-JCSystemGroupMember -GroupName $group -SystemID $device_bind.SystemID
                }
                
                Write-Host "Divice bind with groups!" -ForegroundColor "Yellow" -BackgroundColor "DarkGreen"
            }   
        }
        else {
            return;
        } 
    }
    catch [System.SystemException] {
        $MsgBoxError::Show("Something went wrong while trying to bind user and device.

Please contact your System Administrator.", $mailtaitel, "OK", "Error")
    }
       
}

#bind user to device
function bind_user_to_device () {
    
    try {
        $device = Get-JCSystemInsights -Table SystemInfo | Where-Object {$_.hostname -eq $deviceetext.Text}

        if ((Get-JCUser -username $Usernametext.Text) -and (Get-JCSystem -hostname $deviceetext.Text)){
            
            Add-JCSystemUser -Username $Usernametext.Text -SystemID $device.SystemID -Administrator $false 
            
            Write-Host "Device and user bind!" -ForegroundColor "Yellow" -BackgroundColor "DarkGreen"
        }
        else {
            return; 
        }
    }
    catch [System.SystemException] {
        $MsgBoxError::Show("Something went wrong while trying to bind user and device.

Please contact your System Administrator.", $mailtaitel, "OK", "Error")
    }
}

# Tinme stamp
$CurrentDate = Get-Date
$CurrentDate = $CurrentDate.ToString('dddd dd-MM-yyyy HH:mm')

# Send summary
function send_message () {
    #chamail credentials
    $password = ConvertTo-SecureString 'password' -AsPlainText -Force
    $credential = New-Object System.Management.Automation.PSCredential ('Sender@Example.com', $password)

    if (!($deviceetext.Text)){$device_name = "None"}
    else {$device_name = $deviceetext.Text}

    $username = $Usernametext.text
    $name = [string]::Concat($Firstnametext.text, " ", $Lastnametext.Text) 

    $MailBody = (" 
    Job Summary:

    Host Name: $device_name
    User:            $name
    Username:  $username

    Creation time: $CurrentDatey

    IT Depaerment."
    )

    Send-MailMessage `
        -SmtpServer smtp.office365.com `
        -UseSsl `
        -Port 587 `
        -From "Sender@Example.com" `
        -to "Reseaver@Example.com" `
        -Subject "Some Sobject" `
        -Credential $credential `
        -Body $MailBody `
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
    if (($Firstnametext.text -and $Lastnametext.Text -and $Usernametext.Text -and $User_idtext.Text  -and $Groupdropmenu.Text)){

        connect
        run1
        send_message
        end_popup
        closeForm
    }
    else {
        $MsgBoxError::Show("One or more parameters are missing.

Please fill all text boxes.", $mailtaitel, "OK", "Warning")

    }  
}

function run1 ()
{   

    Write-Host 'User pressed Run' -ForegroundColor 'Green' -BackgroundColor 'Yellow'
    if (($deviceetext.Text)){
        
        $status.text = "Job Strating..."
        Start-Sleep -Seconds 1
        start_popup
        $status.text = "Creating User..."
        Start-Sleep -Seconds 1
        create_user
        $status.text = "Binding User with Groups..." 
        Start-Sleep -Seconds 1
        bind_user
        $status.text = "Creating Device..."
        Start-Sleep -Seconds 1
        create_device
        $status.text = "Binding Device with Groups..."
        Start-Sleep -Seconds 1
        bind_device
        $status.text = "Binding Device and user..."
        Start-Sleep -Seconds 1
        bind_user_to_device
        $status.text = "Finnishing the Job..."
        Start-Sleep -Seconds 1 
    }
    else {
        $MsgBoxError::Show("Host Name was not imputed!.

The job will only create a user!", $mailtaitel, "OK", "Warning")
        
        $status.text = "Job Strating..."
        Start-Sleep -Seconds 1
        start_popup
        $status.text = "Creating User..."
        Start-Sleep -Seconds 1
        create_user
        $status.text = "Binding User with Groups..." 
        Start-Sleep -Seconds 1
        bind_user
        $status.text = "Finnishing the Job..."
        Start-Sleep -Seconds 1 
    }
    
}

function closeForm(){$Form.close()}

[void]$Form.ShowDialog()
