$Global:serviceName = $null
$Global:serviceKey = $null

function Set-Credentials
{
    param ($serviceName, $serviceKey)
    $Global:serviceName = $serviceName
    $Global:serviceKey = $serviceKey
}

Export-ModuleMember -Function Set-Credentials