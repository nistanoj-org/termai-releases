# TermAI - Installateur Windows (PowerShell)
# Usage: irm https://raw.githubusercontent.com/Quantum-Shift-app/termai-releases/main/install.ps1 | iex
$ErrorActionPreference = "Stop"

$Repo = "Quantum-Shift-app/termai-releases"
$AppName = "termai"

# ---------- Détection Architecture ----------
function Get-Arch {
    $arch = [System.Runtime.InteropServices.RuntimeInformation]::OSArchitecture
    switch ($arch) {
        "X64"  { return "amd64" }
        "Arm64" { return "arm64" }
        default { Write-Error "Architecture non supportée: $arch"; exit 1 }
    }
}

# ---------- Dernière version ----------
function Get-LatestVersion {
    try {
        $release = Invoke-RestMethod -Uri "https://api.github.com/repos/$Repo/releases/latest" -UseBasicParsing
        if ($release -and $release.tag_name) {
            return $release.tag_name
        }
        throw "Aucune release trouvée"
    } catch {
        Write-Error "Impossible de récupérer la dernière version depuis le repo $Repo."
        Write-Host ""
        Write-Host "Solutions:" -ForegroundColor Yellow
        Write-Host "  1. Vérifiez que le repo GitHub $Repo existe"
        Write-Host "  2. Vérifiez votre connexion internet"
        Write-Host "  3. Téléchargez manuellement depuis: https://github.com/$Repo/releases"
        exit 1
    }
}

# ---------- Installation ----------
function Install-TermAI {
    $arch = Get-Arch
    $version = Get-LatestVersion

    $filename = "$AppName-windows-$arch.zip"
    $url = "https://github.com/$Repo/releases/download/$version/$filename"
    $installDir = "$env:LOCALAPPDATA\TermAI"
    $binPath = "$installDir\$AppName.exe"

    Write-Host ""
    Write-Host "  TermAI Installer" -ForegroundColor Cyan
    Write-Host "  ─────────────────────────"
    Write-Host "  Version:  $version"
    Write-Host "  Arch:     $arch"
    Write-Host "  Fichier:  $filename"
    Write-Host ""

    # Créer le dossier d'installation
    if (-not (Test-Path $installDir)) {
        New-Item -ItemType Directory -Path $installDir -Force | Out-Null
    }

    # Télécharger
    $tmpFile = Join-Path $env:TEMP $filename
    Write-Host "→ Téléchargement..." -ForegroundColor Yellow
    try {
        Invoke-WebRequest -Uri $url -OutFile $tmpFile -UseBasicParsing
    } catch {
        Write-Error "Téléchargement échoué: $url"
        Write-Host "Vérifiez que la release $version existe avec l'asset $filename."
        exit 1
    }

    # Extraire
    Write-Host "→ Extraction..." -ForegroundColor Yellow
    Expand-Archive -Path $tmpFile -DestinationPath $installDir -Force
    Remove-Item $tmpFile -Force

    # Trouver le .exe
    $exe = Get-ChildItem -Path $installDir -Recurse -Filter "$AppName.exe" | Select-Object -First 1
    if (-not $exe) {
        Write-Error "Binaire $AppName.exe introuvable dans l'archive."
        exit 1
    }
    if ($exe.FullName -ne $binPath) {
        Move-Item -Path $exe.FullName -Destination $binPath -Force
    }

    # Ajouter au PATH utilisateur si pas déjà présent
    $userPath = [Environment]::GetEnvironmentVariable("Path", "User")
    if ($userPath -notlike "*$installDir*") {
        Write-Host "→ Ajout au PATH utilisateur..." -ForegroundColor Yellow
        [Environment]::SetEnvironmentVariable("Path", "$userPath;$installDir", "User")
        $env:Path = "$env:Path;$installDir"
    }

    # Créer un raccourci sur le Bureau
    Write-Host "→ Création du raccourci Bureau..." -ForegroundColor Yellow
    $desktopPath = [Environment]::GetFolderPath("Desktop")
    $shortcutPath = Join-Path $desktopPath "TermAI.lnk"
    $shell = New-Object -ComObject WScript.Shell
    $shortcut = $shell.CreateShortcut($shortcutPath)
    $shortcut.TargetPath = $binPath
    $shortcut.WorkingDirectory = $installDir
    $shortcut.Description = "TermAI - Terminal SSH intelligent"
    $shortcut.Save()

    # Créer un raccourci dans le menu Démarrer
    $startMenuDir = "$env:APPDATA\Microsoft\Windows\Start Menu\Programs"
    $startShortcut = $shell.CreateShortcut("$startMenuDir\TermAI.lnk")
    $startShortcut.TargetPath = $binPath
    $startShortcut.WorkingDirectory = $installDir
    $startShortcut.Description = "TermAI - Terminal SSH intelligent"
    $startShortcut.Save()

    Write-Host ""
    Write-Host "  ✓ TermAI $version installé avec succès !" -ForegroundColor Green
    Write-Host ""
    Write-Host "  Dossier:  $installDir"
    Write-Host "  Binaire:  $binPath"
    Write-Host "  Lancer:   termai  (ou via le raccourci Bureau)"
    Write-Host ""
    Write-Host "  Désinstaller:" -ForegroundColor DarkGray
    Write-Host "    Remove-Item -Recurse '$installDir'" -ForegroundColor DarkGray
    Write-Host "    Remove-Item '$shortcutPath'" -ForegroundColor DarkGray
    Write-Host ""
}

Install-TermAI
