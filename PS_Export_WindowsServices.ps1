<#
# CITRA IT - EXCELÊNCIA EM TI
# SCRIPT PARA BACKUP DO FIREWALL PFSENSE VIA BACKUP EXPORT
# AUTOR: luciano@citrait.com.br
# DATA: 22/10/2021
# Homologado para executar no Windows 7 ou Server 2008R2+
# EXAMPLO DE USO: Powershell -ExecutionPolicy ByPass -File C:\scripts\PS_Export_WindowsServices.ps1
#>

# Changing directory. defaults to documents
CD $env:UserProfile\Documents

# Deleting old export if it exists. Create a new one.
[System.IO.File]::Delete("$PWD\$env:Computername`_services.csv")
$csv_file = New-Item -ItemType File -Path "$pwd\$env:computername`_services.csv"

# Adding .csv headers
Add-Content -Path $csv_file -Value "HABILITAR;SERVICO;INICIALIZACAO;DESCRICAO"


# Get windows services and saiving to .csv
Get-WMIObject Win32_Service | %{
    $line = [String]::Format(";{0};{1};{2}",$_.Name, $_.StartMode, $_.Description)
    Add-Content -Path $csv_file -Value $line
}

# Opening explorer at the end...
# explorer $env:userprofile\documents

# Finished
Write-Host -ForegroundColor Green "Finished"