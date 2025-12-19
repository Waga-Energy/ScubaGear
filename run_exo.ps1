# Test Exchange Online
$ErrorActionPreference = "Continue"

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "TEST EXCHANGE ONLINE (EXO)" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

Import-Module .\PowerShell\ScubaGear\ScubaGear.psd1 -Force

Write-Host "Verification connexion Exchange..." -ForegroundColor Yellow
$exoSession = Get-ConnectionInformation -ErrorAction SilentlyContinue
if (-not $exoSession) {
    Write-Host "Connexion a Exchange Online requise..." -ForegroundColor Yellow
    Connect-ExchangeOnline
}
Write-Host "Connexion EXO OK" -ForegroundColor Green
Write-Host ""

Write-Host "Lancement ScubaGear pour EXO..." -ForegroundColor Yellow
Invoke-SCuBA -ProductNames exo -OutPath .\Results\ -LogIn $false -Verbose
