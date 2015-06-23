$ErrorActionPreference = "Stop"

function Get-Definition
{
    param($definitionName)

    $extension = [System.IO.Path]::GetExtension($definitionName)
    if ([System.String]::IsNullOrEmpty($extension))
    {
        $definitionName = $definitionName + ".json"
    }

    $definitionFile = $definitionName
    $directory = [System.IO.Path]::GetDirectoryName($definitionName)
    if ([System.String]::IsNullOrEmpty($directory))
    {
        $definitionFile = Join-Path (Join-Path $PSScriptRoot "../definitions") $definitionName
    }
  
    $definition = (Get-Content $definitionFile) -join "`n" | ConvertFrom-Json

    return $definition
}

Export-ModuleMember -Function Get-Definition