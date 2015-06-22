param (
    [string] 
    $serviceName = $(throw "-serviceName is required."),
    
    [string]
    $serviceKey = $(throw "-serviceKey is required."),

    [string] 
    $definitionName = $(throw "-definitionName is required.")
 )

 $ErrorActionPreference = "Stop"

 Import-Module (Join-Path (Join-Path $PSScriptRoot "lib") "Credentials.psm1") -DisableNameChecking
 Import-Module (Join-Path (Join-Path $PSScriptRoot "lib") "Index.psm1") -DisableNameChecking

 Set-Credentials $serviceName $serviceKey

 $definitionFile = Join-Path (Join-Path $PSScriptRoot "definitions") ($definitionName + ".json")
 $definition = (Get-Content $definitionFile) -join "`n" | ConvertFrom-Json

 $index = Get-Index $definition.name
 if ($index -ne $null)
 {
    Delete-Index $definition.name
 }

 Create-Index $definition