param (
    [string] 
    $serviceName = $(throw "-serviceName is required."),
    
    [string]
    $serviceKey = $(throw "-serviceKey is required."),

    [string] 
    $indexName = $(throw "-indexName is required.")
 )

 $ErrorActionPreference = "Stop"

 Import-Module (Join-Path (Join-Path $PSScriptRoot "lib") "Credentials.psm1") -DisableNameChecking
 Import-Module (Join-Path (Join-Path $PSScriptRoot "lib") "Index.psm1") -DisableNameChecking

 Set-Credentials $serviceName $serviceKey

 $index = Get-Index $indexName
 if ($index -ne $null)
 {
    Delete-Index $indexName
 }
 else
 {
    Write-Host "Index $indexName was not found"
 }