function Show-Menu
{
    param(
        [string]$Title = 'My Menu'
    )
    cls
    Write-Host "================ $Testing ================"
    Write-Host "1: Is the domain reachable?"
    Write-Host "2: OS info."
    Write-Host "3: Check disk space"
    Write-Host "4: Check Bitlocker Status"
    Write-Host "5: Check IP info"   
    Write-Host "6: Check Services"
    Write-Host "Q: Press 'Q' to quit."
}

function Run-Menu
{
do{ 
    Show-Menu
    $input = Read-Host "Please make a selection"
    switch ($input)
    {
        '1'{
            cls
            'You chose option #1'
            Domain-Check
        } '2'{
            cls
            'You chose option #2'
            Hostname
        } '3'{
            cls
            'You chose option #3'
            Check-Diskspace
        } '4'{
            cls
            'You chose option #4'
            Check-Encryption             
        } '5'{
            cls
            'You selected option #5'
            Check-IP   
        } '6'{
            cls
            'You selected option #6'
            Check-Service             
        } 'q'{
            return
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
    (Get-CimInstance -Class Win32_logicaldisk -Filter "DriveType = '3'" | Select-Object -Property DeviceID, DriveType, VolumeName, 
    @{L='FreeSpaceGB';E={"{0:N2}" -f ($_.FreeSpace /1GB)}},
    @{L="Capacity";E={"{0:N2}" -f ($_.Size/1GB)}})
}

Function Check-Encryption{
    #(Get-BitLockerVolume -MountPoint "C:")
    (manage-bde -status C:)
}

Function Check-IP{
    (Get-NetIPAddress -AddressFamily IPv4 -InterfaceAlias Ethernet, Wi-Fi | Format-Table)
    (Get-DNSClientServerAddress -AddressFamily IPv4 -InterfaceAlias Ethernet, Wi-Fi | Format-Table)
}

Function Check-Service{
    $ServiceName = 'Fax'
    $ServiceCheck = Get-Service -Name $ServiceName

    if ($ServiceCheck.Status -ne 'Running'){
        (write-host $ServiceName 'is not running on this machine!')
    }
    Else{
        (write-host $ServiceName 'is running!')
    }
}

fun 
Run-Menu