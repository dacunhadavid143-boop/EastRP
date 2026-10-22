# Met à jour NOTRE addon eastrp_core dans le modpack (copie + signature avec la clé EastRP), sans toucher aux autres mods.
$Dest   = 'D:\EastRP_Modpack\@EastRP\addons'
$Outils = 'C:\Program Files (x86)\Steam\steamapps\common\Arma 3 Tools'
$NomCle = 'EastRP'
$Pbo    = Join-Path (Split-Path $PSScriptRoot -Parent) 'addons\eastrp_core.pbo'
$cleP   = Join-Path $PSScriptRoot "cle_privee\$NomCle.biprivatekey"
$ErrorActionPreference = 'Stop'
function Stop-Erreur($m) { Write-Host "[ERREUR] $m" -ForegroundColor Red; exit 1 }
if (-not (Test-Path -LiteralPath $Pbo)) { Stop-Erreur "Addon introuvable : $Pbo" }
if (-not (Test-Path -LiteralPath $Dest)) { Stop-Erreur "Modpack introuvable : $Dest" }
if (-not (Test-Path -LiteralPath $cleP)) { Stop-Erreur "Cle privee introuvable : $cleP" }
$dsSign = Get-ChildItem -LiteralPath $Outils -Recurse -Filter 'DSSignFile.exe' -ErrorAction SilentlyContinue | Select-Object -First 1
if (-not $dsSign) { Stop-Erreur "DSSignFile.exe introuvable (Arma 3 Tools)" }
Get-ChildItem -LiteralPath $Dest -File -Filter 'eastrp_core.pbo.*.bisign' -ErrorAction SilentlyContinue | Remove-Item -Force
Copy-Item -LiteralPath $Pbo -Destination $Dest -Force
& $dsSign.FullName $cleP (Join-Path $Dest 'eastrp_core.pbo') | Out-Null
if (Test-Path -LiteralPath (Join-Path $Dest "eastrp_core.pbo.$NomCle.bisign")) {
    Write-Host "OK : eastrp_core mis a jour et signe dans le modpack." -ForegroundColor Green
} else { Write-Host "[ERREUR] signature de eastrp_core.pbo" -ForegroundColor Red }
