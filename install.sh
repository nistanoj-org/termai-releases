#!/bin/sh
# TermAI - Installateur Linux/macOS via curl
# Usage: curl -fsSL https://raw.githubusercontent.com/NikoStano/termai-releases/main/install.sh | sh
set -e

REPO="NikoStano/termai-releases"
APP_NAME="termai"
VERSION=""
INSTALL_DIR="/usr/local/bin"

# ---------- Détection OS / Arch ----------
detect_platform() {
  OS="$(uname -s)"
  ARCH="$(uname -m)"

  case "$OS" in
    Linux)  PLATFORM="linux" ;;
    Darwin) PLATFORM="darwin" ;;
    *)      echo "Erreur: OS non supporté ($OS)"; exit 1 ;;
  esac

  case "$ARCH" in
    x86_64|amd64)  ARCH="amd64" ;;
    aarch64|arm64) ARCH="arm64" ;;
    *)             echo "Erreur: Architecture non supportée ($ARCH)"; exit 1 ;;
  esac
}

# ---------- Récupérer la dernière version ----------
get_latest_version() {
  VERSION=$(curl -fsSL "https://api.github.com/repos/${REPO}/releases/latest" \
    | grep '"tag_name"' | head -1 | sed 's/.*"tag_name": *"//;s/".*//')

  if [ -z "$VERSION" ]; then
    echo "Erreur: impossible de récupérer la dernière version."
    echo "Vérifiez que le repo ${REPO} a des releases GitHub."
    exit 1
  fi
}

# ---------- Téléchargement ----------
download() {
  if [ "$PLATFORM" = "darwin" ]; then
    FILENAME="${APP_NAME}-${PLATFORM}-${ARCH}.zip"
  else
    FILENAME="${APP_NAME}-${PLATFORM}-${ARCH}.tar.gz"
  fi

  URL="https://github.com/${REPO}/releases/download/${VERSION}/${FILENAME}"

  echo ""
  echo "  TermAI Installer"
  echo "  ─────────────────────────"
  echo "  Version:  ${VERSION}"
  echo "  OS:       ${PLATFORM}"
  echo "  Arch:     ${ARCH}"
  echo "  Fichier:  ${FILENAME}"
  echo ""

  TMPDIR_INSTALL=$(mktemp -d)
  echo "→ Téléchargement..."
  if ! curl -fSL --progress-bar -o "${TMPDIR_INSTALL}/${FILENAME}" "$URL"; then
    echo ""
    echo "Erreur: téléchargement échoué."
    echo "URL: ${URL}"
    echo ""
    echo "Vérifiez que la release ${VERSION} existe avec l'asset ${FILENAME}."
    rm -rf "$TMPDIR_INSTALL"
    exit 1
  fi
}

# ---------- Extraction ----------
extract() {
  echo "→ Extraction..."
  cd "$TMPDIR_INSTALL"
  if [ "$PLATFORM" = "darwin" ]; then
    unzip -qo "$FILENAME"
  else
    tar -xzf "$FILENAME"
  fi
}

# ---------- Installation ----------
install_binary() {
  # Chercher le binaire extrait
  BIN=$(find "$TMPDIR_INSTALL" -name "$APP_NAME" -type f -perm -u+x 2>/dev/null | head -1)
  if [ -z "$BIN" ]; then
    BIN=$(find "$TMPDIR_INSTALL" -name "$APP_NAME" -type f 2>/dev/null | head -1)
  fi

  if [ -z "$BIN" ]; then
    echo "Erreur: binaire '$APP_NAME' introuvable dans l'archive."
    rm -rf "$TMPDIR_INSTALL"
    exit 1
  fi

  chmod +x "$BIN"

  # Installation avec sudo si nécessaire
  if [ -w "$INSTALL_DIR" ]; then
    mv "$BIN" "$INSTALL_DIR/$APP_NAME"
  else
    echo "→ Installation dans $INSTALL_DIR (sudo requis)..."
    sudo mv "$BIN" "$INSTALL_DIR/$APP_NAME"
  fi

  rm -rf "$TMPDIR_INSTALL"
}

# ---------- macOS : créer un .app bundle optionnel ----------
install_macos_app() {
  if [ "$PLATFORM" != "darwin" ]; then
    return
  fi

  APP_DIR="$HOME/Applications/TermAI.app/Contents/MacOS"
  mkdir -p "$APP_DIR"
  cp "$INSTALL_DIR/$APP_NAME" "$APP_DIR/$APP_NAME"

  # Info.plist minimaliste
  cat > "$HOME/Applications/TermAI.app/Contents/Info.plist" << 'PLIST'
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>CFBundleExecutable</key>
    <string>termai</string>
    <key>CFBundleIdentifier</key>
    <string>com.nikostano.termai</string>
    <key>CFBundleName</key>
    <string>TermAI</string>
    <key>CFBundleVersion</key>
    <string>1.0.0</string>
    <key>CFBundleShortVersionString</key>
    <string>1.0.0</string>
    <key>LSMinimumSystemVersion</key>
    <string>11.0</string>
    <key>NSHighResolutionCapable</key>
    <true/>
</dict>
</plist>
PLIST

  echo "  → App bundle créé : ~/Applications/TermAI.app"
}

# ---------- Linux : créer un .desktop ----------
install_linux_desktop() {
  if [ "$PLATFORM" != "linux" ]; then
    return
  fi

  DESKTOP_DIR="${XDG_DATA_HOME:-$HOME/.local/share}/applications"
  mkdir -p "$DESKTOP_DIR"

  cat > "$DESKTOP_DIR/termai.desktop" << DESKTOP
[Desktop Entry]
Name=TermAI
Comment=Terminal SSH intelligent avec IA
Exec=$INSTALL_DIR/$APP_NAME
Type=Application
Categories=System;TerminalEmulator;
Terminal=false
DESKTOP

  echo "  → Raccourci desktop créé"
}

# ---------- Main ----------
main() {
  detect_platform
  get_latest_version
  download
  extract
  install_binary
  install_macos_app
  install_linux_desktop

  echo ""
  echo "  ✓ TermAI ${VERSION} installé avec succès !"
  echo ""
  echo "  Lancer :  termai"
  echo "  Désinstaller :  sudo rm $INSTALL_DIR/$APP_NAME"
  echo ""
}

main
