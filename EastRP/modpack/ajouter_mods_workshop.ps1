# Ajoute (ou met a jour) des mods du Workshop dans le modpack EastRP : copie de tous leurs .pbo + signature avec la cle EastRP.
# Pour ajouter un autre mod plus tard : ajoute son numero Workshop dans la liste $Mods ci-dessous, puis relance ajouter_mods_workshop.bat
$Mods = @(
    '2703875351',   # C33 Objects
    '2333872618',   # PLP Urban Pack (Private Property)
    '701300272',    # PLP Urban Packs: Barriers and Fences
    '504690333',    # PLP Containers
    '1354397885'    # PLP Materials
)
$Dest   = 'D:\EastRP_Modpack\@EastRP\addons'
$WS     = 'C:\Program Files (x86)\Steam\steamapps\workshop\content\107410'
$Outils = 'C:\Program Files (x86)\Steam\steamapps\common\Arma 3 Tools'
$NomCle = 'EastRP'
$cleP   = Join-Path $PSScriptRoot "cle_privee\$NomCle.biprivatekey"
$ErrorActionPreference = 'Stop'
function Stop-Erreur($m) { Write-Host "[ERREUR] $m" -ForegroundColor Red; exit 1 }
if (-not (Test-Path -LiteralPath $Dest)) { Stop-Erreur "Modpack introuvable : $Dest" }
if (-not (Test-Path -LiteralPath $cleP)) { Stop-Erreur "Cle privee introuvable : $cleP" }
$dsSign = Get-ChildItem -LiteralPath $Outils -Recurse -Filter 'DSSignFile.exe' -ErrorAction SilentlyContinue | Select-Object -First 1
if (-not $dsSign) { Stop-Erreur "DSSignFile.exe introuvable dans $Outils (Arma 3 Tools)" }
$total = 0
foreach ($id in $Mods) {
    $dir = Join-Path $WS $id
    if (-not (Test-Path -LiteralPath $dir)) { Write-Host "[ATTENTION] Mod $id pas telecharge : abonne-toi sur Steam et attends la fin du telechargement." -ForegroundColor Yellow; continue }
    $nomMod = $id
    $meta = Join-Path $dir 'meta.cpp'
    if (Test-Path -LiteralPath $meta) { $l = Select-String -LiteralPath $meta -Pattern 'name\s*=\s*"(.*)"' | Select-Object -First 1; if ($l) { $nomMod = $l.Matches[0].Groups[1].Value } }
    $add = Get-ChildItem -LiteralPath $dir -Directory | Where-Object { $_.Name -ieq 'addons' } | Select-Object -First 1
    if (-not $add) { Write-Host "[ATTENTION] $nomMod : pas de dossier Addons" -ForegroundColor Yellow; continue }
    Write-Host "--- $nomMod" -ForegroundColor Cyan
    foreach ($p in (Get-ChildItem -LiteralPath $add.FullName -File -Filter '*.pbo')) {
        $cible = Join-Path $Dest $p.Name
        if ((Test-Path -LiteralPath $cible) -and ((Get-Item -LiteralPath $cible).Length -eq $p.Length) -and ((Get-Item -LiteralPath $cible).LastWriteTime -ge $p.LastWriteTime) -and (Test-Path -LiteralPath "$cible.$NomCle.bisign")) {
            Write-Host ("    deja a jour : {0}" -f $p.Name); continue
        }
        Get-ChildItem -LiteralPath $Dest -File -Filter "$($p.Name).*.bisign" -ErrorAction SilentlyContinue | Remove-Item -Force
        Write-Host ("    copie : {0} ({1:N0} Mo)..." -f $p.Name, ($p.Length / 1MB))
        Copy-Item -LiteralPath $p.FullName -Destination $cible -Force
        & $dsSign.FullName $cleP $cible | Out-Null
        if (Test-Path -LiteralPath "$cible.$NomCle.bisign") { Write-Host "    OK, signe" -ForegroundColor Green; $total++ }
        else { Write-Host "    [ERREUR] signature de $($p.Name)" -ForegroundColor Red }
    }
}
Write-Host ""
Write-Host "Termine : $total fichier(s) ajoute(s) ou mis a jour dans le modpack." -ForegroundColor Green
Write-Host "Pense a relancer le serveur, et les joueurs devront re-telecharger le modpack."
