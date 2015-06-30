Import-Module (Join-Path $PSScriptRoot "Utils.psm1") -DisableNameChecking
Import-Module (Join-Path $PSScriptRoot "CRUDHelpers.psm1") -DisableNameChecking

function Get-BaseUri
{
    return "https://$Global:serviceName.search.windows.net/indexes"
}

function Get-Index
{
    param ($indexName)

    $baseUri = Get-BaseUri
    return Get-Entity $baseUri $indexName
}

function Create-Index
{
    param ($indexDefinition)

    $name = $indexDefinition.name
    Write-Host "Creating index $name..."

    $baseUri = Get-BaseUri
    return Create-Entity $baseUri $indexDefinition
}

function Update-Index
{
    param ($indexName, $indexDefinition)
    
    Write-Host "Updating index $indexName..."

    $baseUri = Get-BaseUri
    return Update-Entity $baseUri $indexName $indexDefinition
}

function Delete-Index
{
    param ($indexName)

    Write-Host "Deleting index $indexName..."

    $baseUri = Get-BaseUri
    return Delete-Entity $baseUri $indexName
}

function List-Indexes
{
    $baseUri = Get-BaseUri
    return List-Entities $baseUri
}

function Get-IndexStats
{
    param ($indexName)

    $baseUri = Get-BaseUri
    $uri = "$baseUri/$indexName/stats"
    return Get $uri
}

Export-ModuleMember -Function Get-Index
Export-ModuleMember -Function Create-Index
Export-ModuleMember -Function Update-Index
Export-ModuleMember -Function Delete-Index
Export-ModuleMember -Function List-Indexes
Export-ModuleMember -Function Get-IndexStats