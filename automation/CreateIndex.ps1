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
 Import-Module (Join-Path (Join-Path $PSScriptRoot "lib") "Definition.psm1") -DisableNameChecking

 $ErrorActionPreference = "Stop"

 Set-Credentials $serviceName $serviceKey
  
 $definition = Get-Definition $definitionName

 $index = Get-Index $definition.name
 if ($index -ne $null)
 {
    Delete-Index $definition.name
 }

 Create-Index $definition