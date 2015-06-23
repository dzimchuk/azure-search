param (
    [string] 
    $serviceName = $(throw "-serviceName is required."),
    
    [string]
    $serviceKey = $(throw "-serviceKey is required."),

    [string] 
    $indexName = $(throw "-indexName is required."),

    [string] 
    $definitionName = $(throw "-definitionName is required.")
 )
 
 Import-Module (Join-Path (Join-Path $PSScriptRoot "lib") "Credentials.psm1") -DisableNameChecking
 Import-Module (Join-Path (Join-Path $PSScriptRoot "lib") "Document.psm1") -DisableNameChecking
 Import-Module (Join-Path (Join-Path $PSScriptRoot "lib") "Definition.psm1") -DisableNameChecking

 $ErrorActionPreference = "Stop"

 Set-Credentials $serviceName $serviceKey
  
 $documents = Get-Definition $definitionName

 Index-Documents $indexName $documents