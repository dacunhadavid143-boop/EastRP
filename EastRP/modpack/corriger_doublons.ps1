# Remplace dans le modpack les 2 fichiers dont la mauvaise version avait été gardée, en les prenant dans le Workshop,
# puis les re-signe avec notre clé. A lancer une seule fois.
$Dest   = 'D:\EastRP_Modpack\@EastRP\addons'
$WS     = 'C:\Program Files (x86)\Steam\steamapps\workshop\content\107410'
$Outils = 'C:\Program Files (x86)\Steam\steamapps\common\Arma 3 Tools'
$NomCle = 'EastRP'
$cleP   = Join-Path $PSScriptRoot "cle_privee\$NomCle.biprivatekey"
$fichiers = @(
    (Join-Path $WS '1640273961\Addons\v12_base.pbo'),        # V12 BASE RECENT VERSION (174 Mo)
    (Join-Path $WS '3784742616\addons\Aka_data_base.pbo')    # Aka Mods - All In One Vehicles (270 Mo)
)
$ErrorActionPreference = 'Stop'
function Stop-Erreur($m) { Write-Host "[ERREUR] $m" -ForegroundColor Red; exit 1 }
if (-not (Test-Path -LiteralPath $Dest)) { Stop-Erreur "Modpack introuvable : $Dest" }
if (-not (Test-Path -LiteralPath $cleP)) { Stop-Erreur "Cle privee introuvable : $cleP" }
$dsSign = Get-ChildItem -LiteralPath $Outils -Recurse -Filter 'DSSignFile.exe' -ErrorAction SilentlyContinue | Select-Object -First 1
if (-not $dsSign) { Stop-Erreur "DSSignFile.exe introuvable dans $Outils (Arma 3 Tools)" }
foreach ($f in $fichiers) {
    if (-not (Test-Path -LiteralPath $f)) { Stop-Erreur "Fichier Workshop introuvable : $f (abonne-toi au mod sur Steam)" }
    $nom = Split-Path $f -Leaf
    Get-ChildItem -LiteralPath $Dest -File -Filter "$nom.*.bisign" -ErrorAction SilentlyContinue | Remove-Item -Force
    Copy-Item -LiteralPath $f -Destination (Join-Path $Dest $nom) -Force
    & $dsSign.FullName $cleP (Join-Path $Dest $nom) | Out-Null
    if (Test-Path -LiteralPath (Join-Path $Dest "$nom.$NomCle.bisign")) {
        Write-Host ("OK : {0} ({1:N0} Mo) copie et signe" -f $nom, ((Get-Item -LiteralPath $f).Length / 1MB)) -ForegroundColor Green
    } else { Write-Host "[ERREUR] signature de $nom" -ForegroundColor Red }
}
