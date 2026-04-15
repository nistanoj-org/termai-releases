# TermAI - Le Client SSH augmenté avec l'IA

[![Version](https://img.shields.io/badge/version-1.1.6-blue)](https://github.com/NikoStano/termai/releases) 
[![Tests](https://img.shields.io/badge/tests-500%2F500-green)]() 
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

Rendez-vous sur la [page Releases](https://nistanoj-org.github.io/termai-releases/)

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
