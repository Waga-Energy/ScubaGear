# Script de diagnostic ScubaGear
$ErrorActionPreference = "Continue"
$VerbosePreference = "Continue"

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "DIAGNOSTIC SCUBAGEAR" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# Etape 1: Charger le module
Write-Host "[1/4] Chargement du module ScubaGear..." -ForegroundColor Yellow
try {
    Import-Module .\PowerShell\ScubaGear\ScubaGear.psd1 -Force -ErrorAction Stop
    Write-Host "      Module charge avec succes" -ForegroundColor Green
} catch {
    Write-Host "      ERREUR: $_" -ForegroundColor Red
    exit 1
}

Write-Host ""
Write-Host "[2/4] Test authentification Microsoft Graph..." -ForegroundColor Yellow
Write-Host "      (Une fenetre de navigateur devrait s'ouvrir)" -ForegroundColor Gray

try {
    # Tester la connexion Graph avec un scope minimal
    $context = Get-MgContext
    if ($context) {
        Write-Host "      Deja connecte a Graph en tant que: $($context.Account)" -ForegroundColor Green
    } else {
        Write-Host "      Pas de connexion Graph active, tentative de connexion..." -ForegroundColor Gray
        Connect-MgGraph -Scopes "User.Read" -ErrorAction Stop
        Write-Host "      Connexion Graph reussie" -ForegroundColor Green
    }
} catch {
    Write-Host "      ERREUR Graph: $_" -ForegroundColor Red
}

Write-Host ""
Write-Host "[3/4] Test authentification Exchange Online..." -ForegroundColor Yellow
try {
    $exoSession = Get-ConnectionInformation -ErrorAction SilentlyContinue
    if ($exoSession) {
        Write-Host "      Deja connecte a Exchange: $($exoSession.UserPrincipalName)" -ForegroundColor Green
    } else {
        Write-Host "      Pas de connexion EXO active" -ForegroundColor Gray
    }
} catch {
    Write-Host "      ERREUR EXO: $_" -ForegroundColor Red
}

Write-Host ""
Write-Host "[4/4] Test rapide avec un seul produit (AAD)..." -ForegroundColor Yellow
Write-Host "      Lancement de Invoke-SCuBA -ProductNames aad -Verbose" -ForegroundColor Gray
Write-Host "      Appuyez sur Ctrl+C pour annuler si ca bloque" -ForegroundColor Gray
Write-Host ""

# Lancer avec verbose pour voir ce qui se passe
Invoke-SCuBA -ProductNames aad -OutPath .\Results\ -Verbose
