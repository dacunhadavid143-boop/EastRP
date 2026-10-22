# Construit le modpack EastRP : COPIE l'intégralité des mods de $Source dans UN seul mod @EastRP,
# puis RE-SIGNE tous les .pbo avec NOTRE clé (EastRP.bikey). Les anciennes signatures (.bisign) et clés des auteurs ne sont pas reprises.
# Nécessite "Arma 3 Tools" (Steam > Bibliothèque > Outils), qui contient DSCreateKey et DSSignFile.

$Source  = 'D:\@EastRP'                     # dossier où tu as regroupé les mods (un sous-dossier @... par mod)
$Dest    = 'D:\EastRP_Modpack\@EastRP'      # modpack produit (à charger dans le launcher ET par le serveur)
$NomCle  = 'EastRP'                         # nom de notre clé
$Exclure = @()                              # mods à ignorer, ex. @('@RHSUSAF', '@Block Island')
# Quand deux mods contiennent un fichier du même nom, c'est celui du mod traité EN DERNIER qui est gardé.
# Les mods listés ici passent en dernier : leur version gagne toujours.
$Prioritaires = @('@Aka Mods - All In One Vehicles', '@V12 BASE RECENT VERSION FOR V12 CAR')
$Outils  = 'C:\Program Files (x86)\Steam\steamapps\common\Arma 3 Tools'

$ErrorActionPreference = 'Stop'
$Projet     = Split-Path $PSScriptRoot -Parent
$NotreAddon = Join-Path $Projet 'addons\eastrp_core.pbo'
$DossierCle = Join-Path $PSScriptRoot 'cle_privee'           # NE JAMAIS PARTAGER le .biprivatekey
$Rapport    = Join-Path (Split-Path $Dest -Parent) 'rapport_modpack.txt'

function Stop-Erreur($m) { Write-Host "[ERREUR] $m" -ForegroundColor Red; exit 1 }

# --- Vérifications ---
if (-not (Test-Path -LiteralPath $Source)) { Stop-Erreur "Dossier source introuvable : $Source" }
if (-not (Test-Path -LiteralPath $NotreAddon)) { Stop-Erreur "Addon EastRP introuvable : $NotreAddon" }
$dsSign = $null; $dsKey = $null
if (Test-Path -LiteralPath $Outils) {
    $dsSign = Get-ChildItem -LiteralPath $Outils -Recurse -Filter 'DSSignFile.exe' -ErrorAction SilentlyContinue | Select-Object -First 1
    $dsKey  = Get-ChildItem -LiteralPath $Outils -Recurse -Filter 'DSCreateKey.exe' -ErrorAction SilentlyContinue | Select-Object -First 1
}
if (-not $dsSign -or -not $dsKey) { Stop-Erreur "Arma 3 Tools introuvable dans '$Outils'. Installe-le : Steam > Bibliotheque > Outils > Arma 3 Tools, puis relance." }

# Liste des mods et taille totale
$tous = Get-ChildItem -LiteralPath $Source -Directory | Sort-Object Name | Where-Object { $Exclure -notcontains $_.Name }
$mods = @($tous | Where-Object { $Prioritaires -notcontains $_.Name }) + @(foreach ($n in $Prioritaires) { $tous | Where-Object { $_.Name -eq $n } })
$total = ($mods | ForEach-Object { Get-ChildItem -LiteralPath $_.FullName -Recurse -File -Filter *.pbo } | Measure-Object Length -Sum).Sum
$lecteur = (Split-Path $Dest -Qualifier).TrimEnd(':')
$libre = (Get-PSDrive $lecteur).Free
Write-Host ("{0} mods, {1:N1} Go au total, {2:N1} Go libres sur {3}:" -f $mods.Count, ($total / 1GB), ($libre / 1GB), $lecteur)

# --- Notre clé (créée une seule fois, puis réutilisée) ---
New-Item -ItemType Directory -Path $DossierCle -Force | Out-Null
$cleP = Join-Path $DossierCle "$NomCle.biprivatekey"
$cleB = Join-Path $DossierCle "$NomCle.bikey"
if (-not (Test-Path $cleP)) {
    Push-Location $DossierCle; & $dsKey.FullName $NomCle | Out-Null; Pop-Location
    if (-not (Test-Path $cleP)) { Stop-Erreur "La creation de la cle a echoue." }
    Write-Host "Cle creee : $cleB" -ForegroundColor Green
}

# --- Modpack (mis à jour : seuls les fichiers nouveaux ou modifiés sont recopiés puis re-signés) ---
$addons = Join-Path $Dest 'addons'; $keys = Join-Path $Dest 'keys'
New-Item -ItemType Directory -Path $addons, $keys -Force | Out-Null

$log = New-Object System.Collections.Generic.List[string]
$log.Add("Modpack EastRP construit le $(Get-Date)")
$plan = [ordered]@{}; $origine = @{}

# --- 1. Choix des fichiers (le dernier mod traité gagne en cas de doublon) ---
foreach ($mod in $mods) {
    $pbos = Get-ChildItem -LiteralPath $mod.FullName -Recurse -File -Filter *.pbo |
            Where-Object { $_.Directory.Name -ieq 'addons' }
    if (-not $pbos) { $log.Add("SANS PBO  $($mod.Name)"); Write-Host "Aucun .pbo : $($mod.Name)" -ForegroundColor Yellow; continue }
    foreach ($f in $pbos) {
        $cle = $f.Name.ToLower()
        if ($plan.Contains($cle)) { $log.Add("DOUBLON   $($f.Name) : version de $($origine[$cle]) ($([math]::Round($plan[$cle].Length/1MB)) Mo) remplacee par celle de $($mod.Name) ($([math]::Round($f.Length/1MB)) Mo)") }
        $plan[$cle] = $f; $origine[$cle] = $mod.Name
    }
    # fichiers utiles à la racine du mod (ex. DLL et configuration d'extDB3)
    Get-ChildItem -LiteralPath $mod.FullName -File | Where-Object { $_.Extension -in '.dll', '.so', '.ini' } |
        ForEach-Object { Copy-Item -LiteralPath $_.FullName -Destination $Dest -Force; $log.Add("RACINE    $($_.Name) ($($mod.Name))") }
    $sql = Join-Path $mod.FullName 'sql_custom'
    if (Test-Path -LiteralPath $sql) { Copy-Item -LiteralPath $sql -Destination $Dest -Recurse -Force; $log.Add("RACINE    sql_custom ($($mod.Name))") }
    $log.Add("OK        $($mod.Name) ($($pbos.Count) pbo)")
}
$na = Get-Item -LiteralPath $NotreAddon
$plan[$na.Name.ToLower()] = $na; $origine[$na.Name.ToLower()] = 'EastRP'
$nbPbo = $plan.Count

# --- Copie des fichiers nouveaux ou modifiés ---
$aCopier = @(); $octets = 0
foreach ($k in $plan.Keys) {
    $f = $plan[$k]; $d = Join-Path $addons $f.Name
    $ex = Get-Item -LiteralPath $d -ErrorAction SilentlyContinue
    if ($ex -and $ex.Length -eq $f.Length -and $ex.LastWriteTimeUtc -eq $f.LastWriteTimeUtc) { continue }
    $aCopier += $f; $octets += $f.Length
}
Write-Host ("{0} fichier(s) a copier ({1:N1} Go), {2} deja a jour" -f $aCopier.Count, ($octets / 1GB), ($nbPbo - $aCopier.Count))
if ($libre -lt $octets * 1.05) { Stop-Erreur "Pas assez de place sur le disque $lecteur." }
$fait = 0
foreach ($f in $aCopier) {
    Write-Progress -Activity "Copie des mods" -Status "$($origine[$f.Name.ToLower()]) : $($f.Name)" -PercentComplete ([int](100 * $fait / [math]::Max($octets, 1)))
    Get-ChildItem -LiteralPath $addons -File -Filter "$($f.Name).*.bisign" -ErrorAction SilentlyContinue | Remove-Item -Force
    Copy-Item -LiteralPath $f.FullName -Destination (Join-Path $addons $f.Name) -Force
    $fait += $f.Length
}
Write-Progress -Activity "Copie des mods" -Completed

# --- Nettoyage : fichiers qui ne viennent plus d'aucun mod, anciennes signatures ---
foreach ($x in (Get-ChildItem -LiteralPath $addons -File)) {
    $n = $x.Name.ToLower()
    if ($n.EndsWith('.pbo')) { if (-not $plan.Contains($n)) { Remove-Item -LiteralPath $x.FullName -Force; $log.Add("RETIRE    $($x.Name)") } }
    elseif ($n.EndsWith(".$($NomCle.ToLower()).bisign")) { if (-not $plan.Contains($n.Substring(0, $n.Length - ".$NomCle.bisign".Length))) { Remove-Item -LiteralPath $x.FullName -Force } }
    else { Remove-Item -LiteralPath $x.FullName -Force }
}
Get-ChildItem -LiteralPath $keys -File | Where-Object { $_.Name -ne "$NomCle.bikey" } | Remove-Item -Force

# --- 2. Signature avec notre clé ---
$liste = @(Get-ChildItem -LiteralPath $addons -File -Filter *.pbo | Where-Object { -not (Test-Path -LiteralPath "$($_.FullName).$NomCle.bisign") })
Write-Host "$($liste.Count) fichier(s) a signer"
$i = 0; $echecs = 0
foreach ($p in $liste) {
    $i++
    Write-Progress -Activity "Signature avec la cle $NomCle" -Status "$i / $($liste.Count) : $($p.Name)" -PercentComplete ([int](100 * $i / $liste.Count))
    & $dsSign.FullName $cleP $p.FullName | Out-Null
    if (-not (Test-Path -LiteralPath "$($p.FullName).$NomCle.bisign")) { $echecs++; $log.Add("ECHEC SIGNATURE $($p.Name)") }
}
Write-Progress -Activity "Signature" -Completed
Copy-Item -LiteralPath $cleB -Destination $keys -Force

@'
name = "EastRP";
author = "EastRP";
tooltip = "EastRP - modpack du serveur";
overview = "Modpack du serveur RP EastRP. Contenu des mods utilise avec l'autorisation de leurs auteurs (voir CREDITS.txt).";
'@ | Set-Content -LiteralPath (Join-Path $Dest 'mod.cpp') -Encoding UTF8
$credits = @('Mods inclus dans le modpack EastRP (avec l''autorisation de leurs auteurs) :', '') + ($mods | Sort-Object Name | ForEach-Object { " - $($_.Name.TrimStart('@'))" })
$credits | Set-Content -LiteralPath (Join-Path $Dest 'CREDITS.txt') -Encoding UTF8

$go = [math]::Round($total / 1GB, 2)
$log.Add("TOTAL     $($mods.Count) mods, $nbPbo pbo, $go Go, $($aCopier.Count) copie(s), $($liste.Count) signature(s), $echecs echec(s) de signature")
$log | Set-Content -LiteralPath $Rapport -Encoding UTF8

Write-Host ""
Write-Host "Termine : $($mods.Count) mods, $nbPbo pbo, $go Go, signes avec la cle $NomCle -> $Dest" -ForegroundColor Green
if ($echecs -gt 0) { Write-Host "$echecs pbo non signe(s) : voir $Rapport" -ForegroundColor Yellow }
$dbl = ($log | Where-Object { $_ -like 'DOUBLON*' }).Count
if ($dbl -gt 0) { Write-Host "$dbl doublon(s) : voir $Rapport" -ForegroundColor Yellow }
Write-Host "Cle publique (pour le serveur) : $cleB"
Write-Host "Cle PRIVEE (ne jamais partager) : $cleP" -ForegroundColor Red
