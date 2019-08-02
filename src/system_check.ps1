
function Show-Menu
{
    param(
        [string]$Title = 'My Menu'
    )
    cls
    Write-Host "================ $Testing ================"

     Write-Host "1: Is the domain reachable?"
     Write-Host "2: OS info."
     Write-Host "3: Checking disk space"
     Write-Host "4: Network Info"
     Write-Host "5: Checking Software Installs"
     Write-Host "6: Checking desktop shortcuts"
     Write-Host "7: Checking BitLocker Status"
     Write-Host "Q: Press 'Q' to quit."
}

function Run-Menu
{
do{ 
    Show-Menu
    $input = Read-Host "Please make a selection"
    switch ($input){
    '1'{
        cls
        'You chose option #1'
        Domain-Check
       } 
    '2'{
        cls
        'You chose option #2'
        Hostname
       } 
    '3'{
        cls
        'You chose option #3'
        Check-Diskspace
       }  
    '4'{
        cls
        'You chose option #4'
        Get-NetIPAddress -AddressFamily IPv4 | Select-Object IPAddres                 
       }  
    '5'{
        Get-Service -Name "Sense"
       }  
    '6'{
        Get-Childitem C:\Users\Public\Desktop
       } 
    'q'{
        return
       }
    default{
        cls
        'Please enter 1-5'
           }
                    }
    pause
  }
    until ($input -eq 'q')
}

##Functions
Function Domain-Check{
##you can put your company's domain info here
    Test-ComputerSecureChannel -Server "test.domain" 
    if ('True'){
        'You can reach our domain!'
               } 
    Else{
        'Cannot reach it :('
               }
}

Function Hostname{
    (Get-CimInstance win32_operatingsystem).name
    (Get-CimInstance Win32_OperatingSystem).OSArchitecture
    (Get-CimInstance Win32_OperatingSystem).CSName
}

Function Check-Diskspace{
    (Get-CimInstance -Class Win32_logicaldisk -Filter "DriveType = '3'" | 
    Select-Object -Property DeviceID, DriveType, VolumeName, 
    @{L='FreeSpaceGB';E={"{0:N2}" -f ($_.FreeSpace /1GB)}},
    @{L="Capacity";E={"{0:N2}" -f ($_.Size/1GB)}})
}

fun 
Run-Menu