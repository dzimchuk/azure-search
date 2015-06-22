Import-Module (Join-Path $PSScriptRoot "Utils.psm1") -DisableNameChecking
Import-Module (Join-Path $PSScriptRoot "CRUDHelpers.psm1") -DisableNameChecking

$baseUri = "https://$Global:serviceName.search.windows.net/indexes"

function Get-Index
{
    param ($indexName)

    return Get-Entity $baseUri $indexName
}

function Create-Index
{
    param ($indexDefinition)

    return Create-Entity $baseUri $indexDefinition
}

function Update-Index
{
    param ($indexName, $indexDefinition)

    return Update-Entity $baseUri $indexName $indexDefinition
}

function Delete-Index
{
    param ($indexName)

    return Delete-Entity $baseUri $indexName
}

function List-Indexes
{
    return List-Entities $baseUri
}

function Get-IndexStats
{
    param ($indexName)

    $uri = "$baseUri/$indexName/stats"
    return Get $uri
}

Export-ModuleMember -Function Get-Index
Export-ModuleMember -Function Create-Index
Export-ModuleMember -Function Update-Index
Export-ModuleMember -Function Delete-Index
Export-ModuleMember -Function List-Indexes
Export-ModuleMember -Function Get-IndexStats