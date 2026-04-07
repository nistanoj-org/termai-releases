# TermAI - Le Client SSH augmenté avec l'IA

[![Version](https://img.shields.io/badge/version-1.1.3-blue)](https://github.com/NikoStano/termai/releases) 
[![Tests](https://img.shields.io/badge/tests-444%2F444-green)]() 
[![Build](https://img.shields.io/badge/build-passing-brightgreen)]() 
[![License](https://img.shields.io/badge/license-MIT-blue)](#license)

*TermAI est un client SSH de nouvelle génération sous forme d'application bureau native. Il combine la puissance de **Go**, l'interface fluide de **React/TypeScript**, et intègre directement les modèles d'Intelligence Artificielle (locaux via Ollama ou distants via OpenAI/Anthropic) pour assister vos opérations SysAdmin.*

**État du projet**: ✅

Production-Ready (100% complet - v1.0.3) - Tous les audits de sécurité passés ✅

---

## 📦 Installation

### Linux / macOS

```bash
curl -fsSL
https://raw.githubusercontent.com/Quantum-Shift-app/termai-releases/main/install.sh | sh
```

### Windows (PowerShell)

```powershell
irm
https://raw.githubusercontent.com/Quantum-Shift-app/termai-releases/main/install.ps1 | iex
```

### Windows (Command Prompt)

```cmd
powershell -Command "irm
https://raw.githubusercontent.com/Quantum-Shift-app/termai-releases/main/install.ps1 | iex"
```

### Téléchargement direct

Rendez-vous sur la [page Releases](https://github.com/Quantum-Shift-app/termai-releases/releases/latest) pour télécharger le binaire adapté à votre plateforme :

| Plateforme | Fichier |
| --- | --- |
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
- **Linux arm64** : Les runners GitHub Actions x86_64 ne peuvent pas accéder aux dépôts ARM64 (limitations système)
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

## ✨ Fonctionnalités Principales

### 🔌 Connectivité

- **Terminal Interactif PTY** :
  - xterm.js,
  - couleurs 256,
  - redimensionnement dynamique,
  - weblinks
- **Auth Flexible** :
  - Clé SSH,
  - mot de passe,
  - ou les deux (fallback pour clés protégées + serveurs hybrides) — **Testé en production** ✅
- **Support Clés Chiffrées** :
  - Clés SSH protégées par passphrase avec authentification multi-méthodes
- **SFTP Intégré** :
  - Explorateur fichiers avec upload/download directe depuis l'UI
- **Multi-Hôtes** :
  - CRUD complet,
  - stockage persistant ~/.termai/config.json,
  - reconnexion automatique

### 🤖 Intelligence Artificielle

- **Smart Bar** :
  - Écrivez en **français naturel**
  - Recevez la commande shell exacte prête à exécuter
- **Auto-Fix** :
  - L'IA écoute stderr en temps réel,
  - Propose correction en 1 clic
- **Log Analyzer** :
  - Partagez des fichiers de log pour analyse intelligente
- **Privacy-First** :
  - Ollama local par défaut, logs jamais envoyés au cloud

### 📊 Monitoring & Sécurité

- **System Dashboard** :
  - CPU,
  - RAM,
  - Uptime du serveur distant (temps réel)
- **Historique Commandes** :
  - Ctrl+R pour rechercher,
  - auto-complet
- **4 Thèmes Terminal** :
  - Dracula,
  - Nord,
  - Monokai,
  - GitHub Dark
- **Sécurité Renforcée** :
  - Keychain OS,
  - sanitisation PII,
  - timeouts (SSH 10s, LLM 30s),
  - MITM detection via known_hosts

---

## 📝 Licence

[MIT](LICENSE)
