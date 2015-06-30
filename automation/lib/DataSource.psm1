Import-Module (Join-Path $PSScriptRoot "CRUDHelpers.psm1") -DisableNameChecking

function Get-BaseUri
{
    return "https://$Global:serviceName.search.windows.net/datasources"
}

function Get-DataSource
{
    param ($dataSourceName)

    $baseUri = Get-BaseUri
    return Get-Entity $baseUri $dataSourceName
}

function Create-DataSource
{
    param ($dataSourceDefinition)

    $name = $dataSourceDefinition.name
    Write-Host "Creating data source $name..."

    $baseUri = Get-BaseUri
    return Create-Entity $baseUri $dataSourceDefinition
}

function Update-DataSource
{
    param ($dataSourceName, $dataSourceDefinition)

    Write-Host "Updating data source $dataSourceName..."

    $baseUri = Get-BaseUri
    return Update-Entity $baseUri $dataSourceName $dataSourceDefinition
}

function Delete-DataSource
{
    param ($dataSourceName)

    Write-Host "Deleting data source $dataSourceName..."

    $baseUri = Get-BaseUri
    return Delete-Entity $baseUri $dataSourceName
}

function List-DataSources
{
    $baseUri = Get-BaseUri
    return List-Entities $baseUri
}

Export-ModuleMember -Function Get-DataSource
Export-ModuleMember -Function Create-DataSource
Export-ModuleMember -Function Update-DataSource
Export-ModuleMember -Function Delete-DataSource
Export-ModuleMember -Function List-DataSources