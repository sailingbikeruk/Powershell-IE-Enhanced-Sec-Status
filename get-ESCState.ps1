# Define Environment Variables 
$ComputerName=$env:COMPUTERNAME 
$IEAdminRegistryKey="HKLM:\SOFTWARE\Microsoft\Active Setup\Installed Components\{A509B1A7-37EF-4b3f-8CFC-4F3A74704073}" 
$IEUserRegistryKey ="HKLM:\SOFTWARE\Microsoft\Active Setup\Installed Components\{A509B1A8-37EF-4b3f-8CFC-4F3A74704073}” 

Write-Host $ComputerName

# Check if the key exists
if ((Test-Path -Path $IEAdminRegistryKey) -or (Test-Path -Path $IEUserRegistryKey)) 
    { 
c Get the value for administrators
        $IEAdminRegistryValue=(Get-ItemProperty -Path $IEAdminRegistryKey -Name IsInstalled).IsInstalled
        if ($IEAdminRegistryKey -ne "" ) 
            { 
            if ($IEAdminRegistryValue -eq 0 -or $IEAdminRegistryValue -eq 1) 
                { 
                Write-Host "Currently Administrator ESC Registry Value is set to - $IEAdminRegistryValue"  
                } 
            else 
                { 
                Write-Host "$IEAdminRegistryValue IsInstalled Key Value - Is Empty"  
                } 

# Get the value for users
            $IEUserRegistryValue=(Get-ItemProperty -Path $IEUserRegistryKey -Name IsInstalled).IsInstalled 
            if ($IEUserRegistryKey -ne "" ) { if ($IEUserRegistryValue -eq 0 -or $IEUserRegistryValue -eq 1) 
                { 
                Write-Host "Currently User ESC Registry Value is set to - $IEUserRegistryValue"  
                } 
            else 
                { 
                Write-Host "$IEUserRegistryValue IsInstalled Key Value - Is Empty"  
                } 
            }  
    }
}
