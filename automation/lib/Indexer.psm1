Import-Module (Join-Path $PSScriptRoot "Utils.psm1") -DisableNameChecking
Import-Module (Join-Path $PSScriptRoot "CRUDHelpers.psm1") -DisableNameChecking

$baseUri = "https://$Global:serviceName.search.windows.net/indexers"

function Get-Indexer
{
    param ($indexerName)

    return Get-Entity $baseUri $indexerName
}

function Create-Indexer
{
    param ($indexerDefinition)

    return Create-Entity $baseUri $indexerDefinition
}

function Update-Indexer
{
    param ($indexerName, $indexerDefinition)

    return Update-Entity $baseUri $indexerName $indexerDefinition
}

function Delete-Indexer
{
    param ($indexerName)

    return Delete-Entity $baseUri $indexerName
}

function List-Indexers
{
    return List-Entities $baseUri
}

function Get-IndexerStatus
{
    param ($indexerName)

    $uri = "$baseUri/$indexerName/status"
    return Get $uri
}

function Run-Indexer
{
    param ($indexerName)

    $uri = "$baseUri/$indexerName/run"
    return Post $uri
}

function Reset-Indexer
{
    param ($indexerName)

    $uri = "$baseUri/$indexerName/reset"
    return Post $uri
}

Export-ModuleMember -Function Get-Indexer
Export-ModuleMember -Function Create-Indexer
Export-ModuleMember -Function Update-Indexer
Export-ModuleMember -Function Delete-Indexer
Export-ModuleMember -Function List-Indexers
Export-ModuleMember -Function Get-IndexerStatus
Export-ModuleMember -Function Run-Indexer
Export-ModuleMember -Function Reset-Indexer