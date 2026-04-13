# TermAI - Le Client SSH augmenté avec l'IA

[![Version](https://img.shields.io/badge/version-1.1.4-blue)](https://github.com/NikoStano/termai/releases) 
[![Tests](https://img.shields.io/badge/tests-498%2F498-green)]() 
[![Build](https://img.shields.io/badge/build-passing-brightgreen)]() 
[![License](https://img.shields.io/badge/license-MIT-blue)](#license)

*TermAI est un client SSH de nouvelle génération sous forme d'application bureau native. Il combine la puissance de **Go**, l'interface fluide de **React/TypeScript**, et intègre directement les modèles d'Intelligence Artificielle (locaux via Ollama ou distants via OpenAI/Anthropic) pour assister vos opérations SysAdmin.*

**État du projet**: ✅

---

## 📦 Installation

### Linux / macOS

```bash
curl -fsSL https://raw.githubusercontent.com/Quantum-Shift-app/termai-releases/main/install.sh | sh
```

### Windows (PowerShell)

```powershell
irm https://raw.githubusercontent.com/Quantum-Shift-app/termai-releases/main/install.ps1 | iex
```

### Windows (Command Prompt)

```cmd
powershell -Command "irm https://raw.githubusercontent.com/Quantum-Shift-app/termai-releases/main/install.ps1 | iex"
```

### Téléchargement direct

Rendez-vous sur la [page Releases](https://github.com/Quantum-Shift-app/termai-releases/releases/latest) pour télécharger le binaire adapté à votre plateforme :

| Plateforme | Fichier |
| --- | --- |
| Linux arm64 | `termai-linux-arm64.tar.gz` |
| Linux amd64 | `termai-linux-amd64.tar.gz` |
| Linux amd64 (.deb) | `termai-linux-amd64.deb` |
| Linux amd64 (AppImage) | `termai-linux-amd64.AppImage` |
| macOS Intel | `termai-darwin-amd64.zip` |
| macOS Apple Silicon | `termai-darwin-arm64.zip` |
| Windows amd64 (portable) | `termai-windows-amd64.zip` |
| Windows amd64 (installer) | `termai-windows-amd64-setup.exe` |
| Windows arm64 (installer) | `termai-windows-arm64-setup.exe` |
| Windows 386 (portable) | `termai-windows-386.zip` |

**Architectures non supportées** ⚠️ :
- **Linux 386** : Conflit de dépendances système irrésolvable

---

## 🗑️ Désinstallation

**Linux/macOS** :
```bash
sudo rm /usr/local/bin/termai
```

**Windows** :
```powershell
Remove-Item -Recurse "$env:LOCALAPPDATA\TermAI"
```

---

## 📝 Licence

[MIT](LICENSE)
