# TermAI - Terminal SSH intelligent avec IA

TermAI est un client SSH de nouvelle génération avec intelligence artificielle intégrée (Ollama, OpenAI, Anthropic).

---

## 📦 Installation

### Linux / macOS

```bash
curl -fsSL https://raw.githubusercontent.com/NikoStano/termai-releases/main/install.sh | sh
```

### Windows (PowerShell)

```powershell
irm https://raw.githubusercontent.com/NikoStano/termai-releases/main/install.ps1 | iex
```

### Téléchargement direct

Rendez-vous sur la [page Releases](https://github.com/NikoStano/termai-releases/releases/latest) pour télécharger le binaire adapté à votre plateforme :

| Plateforme          | Fichier                          |
|---------------------|----------------------------------|
| Linux amd64         | `termai-linux-amd64.tar.gz`      |
| Linux amd64 (.deb)  | `termai-linux-amd64.deb`         |
| Linux amd64 (AppImage) | `termai-linux-amd64.AppImage` |
| macOS Intel         | `termai-darwin-amd64.zip`        |
| macOS Apple Silicon | `termai-darwin-arm64.zip`        |
| Windows amd64 (portable) | `termai-windows-amd64.zip`  |
| Windows amd64 (installer) | `termai-windows-amd64-setup.exe` |

---

## 🗑️ Désinstallation

**Linux/macOS** : `sudo rm /usr/local/bin/termai`

**Windows** : `Remove-Item -Recurse "$env:LOCALAPPDATA\TermAI"`

---

## ✨ Fonctionnalités

- **Terminal SSH interactif** avec support couleur 256 et redimensionnement dynamique
- **Smart Bar** : tapez en langage naturel, l'IA génère la commande shell
- **Auto-Fix** : analyse automatique des erreurs avec suggestion de correction
- **System Dashboard** : monitoring CPU, RAM, Uptime en temps réel
- **100% Privacy-First** : fonctionne avec un LLM local (Ollama) par défaut

---

## 📝 Licence

[MIT](LICENSE)
