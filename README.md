# NixOS Configuration

A robust, modular, and reproducible NixOS configuration managed with **Nix Flakes** and **Home Manager**. This repository defines the entire system state, ensuring consistency across deployments.

## 🌟 Features

- **Modular Architecture**: Clean separation of concerns using a module-based directory structure.
- **Flake-based Management**: Dependencies are pinned and reproducible.
- **Desktop Environment**: GNOME Shell optimized with essential extensions (Blur my Shell, GSConnect, etc.).
- **Shell Experience**: Zsh configured with **Starship** prompt, syntax highlighting, and autosuggestions.
- **Optimization**: Automatic garbage collection, SSD trimming, and ZRAM swap enabled.
- **Network**: Pre-configured firewall and networking optimizations.

## 📂 Project Structure

```
nixos-config/
├── modules/               # System-level modules
│   ├── core/              # Bootloader, User, Locale, Optimization
│   ├── desktop/           # Graphics, Audio, Display Manager (GDM)
│   ├── networking/        # NetworkManager, Firewall, DNS
│   └── programs/          # System-wide packages (Docker, Virt-manager)
├── home/                  # User-level configuration (Home Manager)
│   ├── shell/             # Zsh, Starship, Git, Aliases
│   └── desktop/           # User Applications, Theming, GNOME Extensions
├── flake.nix              # Entry point & Dependency definitions
├── configuration.nix      # Main system assembler
└── Makefile               # Automation scripts
```

## 🛠️ Installation

### Bootstrap (First-time installation)

1. **Clone the repository:**

   ```bash
   git clone https://github.com/sodops/nix-flake-gnome.git ~/nixos-config
   cd ~/nixos-config
   ```

2. **Generate Hardware Config (if on new hardware):**

   ```bash
   # Overwrite the existing hardware-configuration.nix with the one for the current machine
   nixos-generate-config --show-hardware-config > hardware-configuration.nix
   ```

3. **Apply Configuration:**
   ```bash
   nixos-rebuild switch --flake .#sodiq
   ```

## ⚡ Management Commands

This configuration includes convenient Zsh aliases for common tasks:

| Command     | Description                                                          |
| ----------- | -------------------------------------------------------------------- |
| `update`    | Rebuilds the system using the flake (applies changes).               |
| `clean`     | Runs garbage collection (`nix-collect-garbage -d`) to free up space. |
| `hm-switch` | Applies only Home Manager changes (faster than full system update).  |
| `ll`        | Detailed list of files (`ls -l`).                                    |

## 📦 Software Overview

### System Packages

- **DevOps**: Docker, Kubernetes (kubectl, helm), Terraform, Ansible.
- **Development**: Python 3, Node.js, Git.
- **Utilities**: Vim, wget, curl, htop, neofetch.

### User Packages & Extensions

- **Apps**: VS Code, Chrome, Firefox, Zen Browser, Telegram, Discord, Spotify, OBS Studio, Obsidian, Postman.
- **Screenshot**: GNOME built-in screenshot tool with clipboard support.
- **Extensions**:
  - **GSConnect** (Android integration)
  - **Blur my Shell** (Aesthetics)
  - **Caffeine** (Prevent sleep)
  - **AppIndicator** (Tray icons)
  - **Coverflow Alt-Tab** (Window switching)
  - **Tiling Assistant** (Window tiling)
  - **Clipboard Indicator** (Clipboard history)

## ⌨️ Screenshot Shortcuts

| Shortcut        | Action                            |
| --------------- | --------------------------------- |
| `Print`         | GNOME screenshot UI (interactive) |
| `Shift + Print` | Full screen screenshot            |
| `Ctrl + Print`  | Area selection screenshot         |
| `Alt + Print`   | Window screenshot                 |

Screenshots are saved to `~/Pictures/` directory.

## 🔧 Customization

- **To add system packages:** Edit `modules/programs/default.nix`.
- **To add user packages:** Edit `home/desktop/default.nix`.
- **To change shell/git settings:** Edit `home/shell/default.nix`.

## License

This configuration is released under the **MIT License**.
