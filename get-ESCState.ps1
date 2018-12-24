#$ADSession = New-PSSession -ComputerName graf-dc-01
#Import-Module activedirectory -PSSession $ADSession
#$domains = Get-ADForest | select -ExpandProperty domains
#$Servers = @()
#foreach($r in $domains)
#{
#    $Servers += Get-ADComputer -Filter {OperatingSystem -like "*server*"} -Server $r | select Name, DNSHostName
#}
#$servers = $servers | ? DNSHostName -ne ""
$Servers = Import-Csv C:\Scripts\JT1servers.txt
$out = Invoke-Command -ComputerName $Servers.DNSHostName -ScriptBlock {
    $ComputerName=$env:COMPUTERNAME
    $IEAdminRegistryKey="HKLM:\SOFTWARE\Microsoft\Active Setup\Installed Components\{A509B1A7-37EF-4b3f-8CFC-4F3A74704073}" 
    $IEUserRegistryKey ="HKLM:\SOFTWARE\Microsoft\Active Setup\Installed Components\{A509B1A8-37EF-4b3f-8CFC-4F3A74704073}” 
    #Write-Host $ComputerName
    
    if ((Test-Path -Path $IEAdminRegistryKey) -or (Test-Path -Path $IEUserRegistryKey)) 
    { 
    # Get the value for administrators
        $IEAdminRegistryValue=(Get-ItemProperty -Path $IEAdminRegistryKey -Name IsInstalled).IsInstalled
        if ($IEAdminRegistryKey -ne "" ) 
            { 
            if ($IEAdminRegistryValue -eq 0 -or $IEAdminRegistryValue -eq 1) 
                { 
                $IEAdmin = "Currently Administrator ESC Registry Value is set to - $IEAdminRegistryValue"  
                } 
            else 
                { 
                $IEAdmin = "$IEAdminRegistryValue IsInstalled Key Value - Is Empty"  
                } 

# Get the value for users
            $IEUserRegistryValue=(Get-ItemProperty -Path $IEUserRegistryKey -Name IsInstalled).IsInstalled 
            if ($IEUserRegistryKey -ne "" ) { if ($IEUserRegistryValue -eq 0 -or $IEUserRegistryValue -eq 1) 
                { 
                $IEUser = "Currently User ESC Registry Value is set to - $IEUserRegistryValue"  
                } 
            else 
                { 
                $IEUser = "$IEUserRegistryValue IsInstalled Key Value - Is Empty"  
                } 
            }  
    }
    return "$ComputerName,$IEAdmin,$IEUser"
}

}

$out | Out-File -FilePath C:\Scripts\IE-ESCStatus\IERegOut.csv 
