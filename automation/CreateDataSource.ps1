param (
    [string] 
    $serviceName = $(throw "-serviceName is required."),
    
    [string]
    $serviceKey = $(throw "-serviceKey is required."),

    [string] 
    $definitionName = $(throw "-definitionName is required."),

    [string] 
    $connectionString = $(throw "-connectionString is required.")
 )
 
 Import-Module (Join-Path (Join-Path $PSScriptRoot "lib") "Credentials.psm1") -DisableNameChecking
 Import-Module (Join-Path (Join-Path $PSScriptRoot "lib") "DataSource.psm1") -DisableNameChecking
 Import-Module (Join-Path (Join-Path $PSScriptRoot "lib") "Definition.psm1") -DisableNameChecking

 $ErrorActionPreference = "Stop"

 Set-Credentials $serviceName $serviceKey
  
 $definition = Get-Definition $definitionName

 $credentials = @{ "connectionString" = $connectionString }
 $definition.credentials = $credentials

 $dataSource = Get-DataSource $definition.name
 if ($dataSource -ne $null)
 {
    Delete-DataSource $definition.name
 }

 Create-DataSource $definition