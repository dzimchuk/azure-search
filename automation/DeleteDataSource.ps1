param (
    [string] 
    $serviceName = $(throw "-serviceName is required."),
    
    [string]
    $serviceKey = $(throw "-serviceKey is required."),

    [string] 
    $dataSourceName = $(throw "-dataSourceName is required.")
 )
 
 Import-Module (Join-Path (Join-Path $PSScriptRoot "lib") "Credentials.psm1") -DisableNameChecking
 Import-Module (Join-Path (Join-Path $PSScriptRoot "lib") "DataSource.psm1") -DisableNameChecking

 Set-Credentials $serviceName $serviceKey

 $dataSource = Get-DataSource $dataSourceName
 if ($dataSource -ne $null)
 {
    Delete-DataSource $dataSourceName
 }
 else
 {
    Write-Host "Data source $dataSourceName was not found"
 }