Import-Module (Join-Path $PSScriptRoot "Utils.psm1") -DisableNameChecking

function Index-Documents
{
    param ($indexName, $documents)

    $uri = "https://$Global:serviceName.search.windows.net/indexes/$indexName/docs/index"
    return Post $uri $documents
}

Export-ModuleMember -Function Index-Documents