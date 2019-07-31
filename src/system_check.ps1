
function Show-Menu
{
    param(
        [string]$Title = 'My Menu'
    )
    cls
    Write-Host "================ $Testing ================"

     Write-Host "1: Is the Domain reachable?"
     Write-Host "2: OS info."
     Write-Host "3: Disk Space Check"
     Write-Host "4: Network Info"
     Write-Host "5: Check software installs"
     Write-Host "6: Are the desktop shortcuts okay?"
     Write-Host "7: Are the desktop shortcuts okay?"
     Write-Host "Q: Press 'Q' to quit."
}

function Select
{
do
{ 
     Show-Menu
     $input = Read-Host "Please make a selection"
     switch ($input)
     {
           '1' {
                cls
                'You chose option #1'
                Domain-Check
              
           } '2' {
                cls
                'You chose option #2'
                Hostname
      
           } '3' {
                cls
                'You chose option #3'
                Get-PSDrive
           }  '4' {
                cls
                'You chose option #4'
                Get-NetIPAddress –AddressFamily IPv4 | Select-Object IPAddres                 
           }  
              '5'{
                Get-Service -DisplayName "Windows Defnder Advanced Thread Protection Service"

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
    Test-ComputerSecureChannel -Server "testing" 
    if ('True'){
        'You can reach our domain!'
               } Else{
                    'Cannot reach it :('
                     }
                     }

Function Hostname{
    (Get-WMIObject win32_operatingsystem).name
    (Get-WmiObject Win32_OperatingSystem).OSArchitecture
    (Get-WmiObject Win32_OperatingSystem).CSName
                 }


fun
Select