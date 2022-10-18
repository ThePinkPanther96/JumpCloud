## This is the raw code for the JumpCloud Swiss Army Tool. it contains only functions.


# Inport Variables
# Device Groups 
$device_group = @()

# User Groups
$user_group = @()

# Vars
$device = ""
$Firstname = ""
$Lastname = ""
$Username = ""
$User_id = ""

#---------------------------------------------------------------[Script]-------------------------------------------------------------

function connect {
    
    #Connectong to the JumpCloud Admin console with API key
    Import-Module JumpCloud
    $JumpCloudAPIKey = "" # Enter API Here
    Connect-JCOnline -JumpCloudAPIKey $JumpCloudAPIKey -force
    
}

# Create JCUser
function create_user {
    
    $email = $email
    $display_name = [string]::Concat($Firstname, " ", $Lastname)
    $url = "@Example.com"  ## SET THE EMAIL URL ADDRESS HERE. 
    $email = [string]::Concat($Username, $url)
    try {
        if (!(Get-JCUser -username $Username)){

            New-JCUser -Username $Username `
            -firstname $Firstname `
            -lastname $Lastname `
            -displayname $display_name `
            -email $email `
            -employeeIdentifier $User_id `
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
         
        Write-Host "Error" -BackgroundColor "Red" -ForegroundColor "DarkRed"
    }
    
} 

# Bind JCUser to groups
function bind_user () {
    
    Try {
        if ($user_group){

            foreach ($group in $user_group){
    
                Add-JCUserGroupMember -GroupName $group -Username $Username
            } 
            Write-Host "User bind to group!" -ForegroundColor "Yellow" -BackgroundColor "DarkGreen"
        }
    }
    catch {
        Write-Host "Error" -BackgroundColor "Red" -ForegroundColor "DarkRed"
    } 
}

function create_device () {
    
    try {

        if ($device){

            $new_device = Get-JCSystemInsights -Table SystemInfo | Where-Object {$_.hostname -eq $device}
            $new_devicedisplayname = [string]::Concat("PC-", $Username.ToUpper(), "-LP")
            
            if ((Get-JCSystem -hostname $device)){  
                
                foreach ($device in $new_device){
                    $new_device = $device | Where-Object {$_.hostname -eq $device}
                }
                foreach ($i in $new_device){
                Set-JCSystem -displayName $new_devicedisplayname -SystemID $i.SystemID
                }
                
                Write-Host "Display Name set!" -ForegroundColor "Yellow" -BackgroundColor "DarkGreen"
            }
            else {
                Write-Host "Error" -BackgroundColor "Red" -ForegroundColor "DarkRed"
            }
        }
    }
    catch [System.SystemException] {
        Write-Host "Error" -BackgroundColor "Red" -ForegroundColor "DarkRed"
    }  
}

# Bind Device to groups
function bind_device () {

    $device_bind = Get-JCSystemInsights -Table SystemInfo | Where-Object {$_.hostname -eq $device}
    try {
        if (Get-JCSystem -hostname $device) {
            
            if ($device_group){
                
                foreach ($group in $device_group){
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
        Write-Host "Error" -BackgroundColor "Red" -ForegroundColor "DarkRed"
    }
       
}

# Bind user to device
function bind_user_to_device () {
    
    try {
        $device = Get-JCSystemInsights -Table SystemInfo | Where-Object {$_.hostname -eq $device}

        if ((Get-JCUser -username $Username) -and (Get-JCSystem -hostname $device)){
            
            Add-JCSystemUser -Username $Username -SystemID $device.SystemID -Administrator $false 
            
            Write-Host "Device and user bind!" -ForegroundColor "Yellow" -BackgroundColor "DarkGreen"
        }
        else {
            return; 
        }
    }
    catch [System.SystemException] {
        Write-Host "Error" -BackgroundColor "Red" -ForegroundColor "DarkRed"
    }
}

# Tinme stamp
$CurrentDate = Get-Date
$CurrentDate = $CurrentDate.ToString('dddd dd-MM-yyyy HH:mm')

# Send summary
function send_message () {
    #chamail credentials
    $password = ConvertTo-SecureString 'Password' -AsPlainText -Force
    $credential = New-Object System.Management.Automation.PSCredential ('chnmail@chainreaction11.onmicrosoft.com', $password)

    if (!($device)){$device_name = "None"}
    else {$device_name = $device}

    $username = $Username
    $name = [string]::Concat($Firstname, " ", $Lastname) 

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
        -From "sender@Example.com" `
        -to "reseaver@Example.com" `
        -Subject "Some Subject..." `
        -Credential $credential `
        -Body $MailBody `
        #-Attachments
}

## Calling Functions by order 

connect
create_user
bind_user
create_device
bind_device
bind_user_to_device
send_message
