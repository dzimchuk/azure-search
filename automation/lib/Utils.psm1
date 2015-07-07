Import-Module (Join-Path $PSScriptRoot "Credentials.psm1") -DisableNameChecking

$ErrorActionPreference = "Stop"

$apiVersion = '2015-02-28'
$contentType = 'application/json'

function Append-ServiceVersion
{
    param ($uri)
    return $uri + "?api-version=$apiVersion"
}

function Get-DefaultHeaders
{
    return @{ 'api-key' = $Global:serviceKey }
}

function Escape-Unicode
{
    param ([string]$text)

    $builder = New-Object System.Text.StringBuilder
    foreach($c in $text.ToCharArray())
    {
        if ($c -gt 127)
        {
            $builder.AppendFormat("\u{0}", ([int]$c).ToString("x4")) | Out-Null
        }
        else
        {
            $builder.Append($c) | Out-Null 
        }
    }

    return $builder.ToString()
}

function Get
{
    param ($uri)
        
    $finalUri = Append-ServiceVersion($uri)
    $headers = Get-DefaultHeaders

    $result = Invoke-RestMethod -Uri $finalUri -Method Get -Headers $headers

    return $result
}

function Get-Safe
{
    param ($uri)

    $OldEAP = $ErrorActionPreference
    $ErrorActionPreference = 'SilentlyContinue'

    $finalUri = Append-ServiceVersion($uri)
    $headers = Get-DefaultHeaders

    $result = Invoke-RestMethod -Uri $finalUri -Method Get -Headers $headers -ErrorVariable RestError

    $ErrorActionPreference = $OldEAP

    return $result
}

function Post
{
    param ($uri, $body)
        
    $finalUri = Append-ServiceVersion($uri)
    $headers = Get-DefaultHeaders

    $result = $null
    if ($body -ne $null)
    {
        $json = ConvertTo-Json $body -Depth 100
        $json = Escape-Unicode $json
        $result = Invoke-RestMethod -Uri $finalUri -Method Post -Headers $headers -Body $json -ContentType $contentType
    }
    else
    {
        $result = Invoke-RestMethod -Uri $finalUri -Method Post -Headers $headers
    }

    return $result
}

function Put
{
    param ($uri, $body)
        
    $finalUri = Append-ServiceVersion($uri)
    $headers = Get-DefaultHeaders

    $json = ConvertTo-Json $body -Depth 100
    $json = Escape-Unicode $json
    $result = Invoke-RestMethod -Uri $finalUri -Method Put -Headers $headers -Body $json -ContentType $contentType

    return $result
}

function Delete
{
    param ($uri)
        
    $finalUri = Append-ServiceVersion($uri)
    $headers = Get-DefaultHeaders

    $result = Invoke-RestMethod -Uri $finalUri -Method Delete -Headers $headers

    return $result
}

Export-ModuleMember -Function Get
Export-ModuleMember -Function Get-Safe
Export-ModuleMember -Function Post
Export-ModuleMember -Function Put
Export-ModuleMember -Function Delete