param (
    [string] 
    $serviceName = $(throw "-serviceName is required."),
    
    [string]
    $serviceKey = $(throw "-serviceKey is required."),

    [string] 
    $indexerName = $(throw "-indexerName is required.")
 )
 
 Import-Module (Join-Path (Join-Path $PSScriptRoot "lib") "Credentials.psm1") -DisableNameChecking
 Import-Module (Join-Path (Join-Path $PSScriptRoot "lib") "Indexer.psm1") -DisableNameChecking

 Set-Credentials $serviceName $serviceKey

 Run-Indexer $indexerName
 Start-Sleep -Seconds 3

 $running = $true

 while($running)
 {
    $status = Get-IndexerStatus $indexerName
    if ($status.lastResult -ne $null)
    {
        switch($status.lastResult.status)
        {
            "inProgress" 
            { 
                Write-Host 'Synchronizing...'
                Start-Sleep -Seconds 3
            }
            "success" 
            {
                $processed = $status.lastResult.itemsProcessed
                $failed = $status.lastResult.itemsFailed
                Write-Host "Items processed: $processed, Items failed: $failed"
                $running = $false
            }
            default 
            {
                Write-Host "Synchronization failed: " + $status.lastResult.errorMessage
                $running = $false
            }
        }
    }
    else
    {
        Write-Host "Indexer status: " + $status.status
        $running = $false
    }
 }