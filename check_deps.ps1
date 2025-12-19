Write-Host "Verification des dependances..."
$deps = @('Microsoft.Graph.Authentication', 'ExchangeOnlineManagement', 'MicrosoftTeams', 'Microsoft.PowerApps.Administration.PowerShell', 'PnP.PowerShell')
foreach ($dep in $deps) {
    $mod = Get-Module -ListAvailable -Name $dep | Select-Object -First 1
    if ($mod) {
        Write-Host "  OK: $dep v$($mod.Version)"
    } else {
        Write-Host "  MANQUANT: $dep"
    }
}
