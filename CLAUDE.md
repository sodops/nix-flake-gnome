# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

NixOS configuration for a GNOME desktop system (hostname: `nixos`, user: `sodiq`). Uses Nix Flakes with Home Manager integration. Located at `/home/sodiq/nixos-config`.

## Build Commands

```bash
# Apply full system configuration
make switch
# or: sudo nixos-rebuild switch --flake .#sodiq

# Dry-run (validate without applying)
make check
# Runs: nix flake check && sudo nixos-rebuild dry-build --flake .#sodiq

# Apply only Home Manager changes (faster, user-level only)
make home
# or: home-manager switch --flake .#sodiq
```

Shell aliases available after activation: `update` (full rebuild), `hm-switch` (home-manager only), `clean` (garbage collection).

## Architecture

### Entry Points

- `flake.nix` - Flake definition with inputs and system output. Passes `inputs` to all modules via `specialArgs`.
- `configuration.nix` - System-level assembler, imports all `modules/` subdirectories.
- `home.nix` - User-level assembler, imports `home/` subdirectories and `secrets.nix`.

### Two-Layer Module System

**System modules** (`modules/`): Applied via `configuration.nix`
- `core/` - Bootloader, locale, user definition, zram, gc
- `desktop/` - GNOME, graphics, audio (PipeWire), GDM
- `networking/` - NetworkManager, firewall, hosts, SSH/mosh/tailscale
- `programs/` - System packages, Docker, Podman, libvirtd
- `gaming/` - Steam, gaming-related config
- `waydroid/` - Android container support

**User modules** (`home/`): Applied via `home.nix`
- `shell/` - Zsh, Starship, tmux, fzf, direnv, git, lazygit
- `desktop/` - User apps, GNOME extensions, theming, desktop entries

### Flake Inputs

External inputs defined in `flake.nix`:
- `nixpkgs` - nixos-25.11
- `home-manager` - release-25.11 (follows nixpkgs)
- `zen-browser` - Zen browser flake
- `kimi-cli` - MoonshotAI CLI tool
- `antigravity` - Antigravity nix package

All inputs are passed to modules via `specialArgs` and `home-manager.extraSpecialArgs`.

### Secrets Handling

API keys and tokens are stored in `secrets.nix` (gitignored). `home.nix` imports them conditionally:

```nix
let
  secretsFile = ./secrets.nix;
  secrets = if builtins.pathExists (toString secretsFile) then import secretsFile else {};
in {
  home.sessionVariables = secrets;
}
```

Create `secrets.nix` manually on each machine (not tracked by git).

## Key Configuration Files to Edit

| What | Where |
|------|-------|
| System packages | `modules/programs/default.nix` |
| User packages & GNOME extensions | `home/desktop/default.nix` |
| Shell & dev tools | `home/shell/default.nix` |
| Networking, hosts, SSH | `modules/networking/default.nix` |
| Add new flake input | `flake.nix` (inputs + pass via specialArgs if needed) |
