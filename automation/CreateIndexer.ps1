param (
    [string] 
    $serviceName = $(throw "-serviceName is required."),
    
    [string]
    $serviceKey = $(throw "-serviceKey is required."),

    [string] 
    $definitionName = $(throw "-definitionName is required.")
 )
 
 Import-Module (Join-Path (Join-Path $PSScriptRoot "lib") "Credentials.psm1") -DisableNameChecking
 Import-Module (Join-Path (Join-Path $PSScriptRoot "lib") "Indexer.psm1") -DisableNameChecking

 Set-Credentials $serviceName $serviceKey

 $definitionFile = Join-Path (Join-Path $PSScriptRoot "definitions") ($definitionName + ".json")
 $definition = (Get-Content $definitionFile) -join "`n" | ConvertFrom-Json

 $indexer = Get-Indexer $definition.name
 if ($indexer -ne $null)
 {
    Delete-Indexer $definition.name
 }

 Create-Indexer $definition