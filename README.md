# NixOS Configuration

A modular, flake-based NixOS configuration tailored for stability and reproducibility.

## Project Structure

This configuration adopts a modular architecture separating system-level configuration from user-specific settings:

```
nixos-config/
├── modules/               # System-wide configurations
│   ├── core/              # Bootloader, User management, Locale, Optimization
│   ├── desktop/           # Desktop Environment (GNOME), Display Manager
│   ├── networking/        # NetworkManager, Firewall rules
│   └── programs/          # System-level packages
├── home/                  # User-space configurations (Home Manager)
│   ├── shell/             # Zsh, Starship, Git, Aliases
│   └── desktop/           # User Applications, Theming, Cursor
├── flake.nix              # Entry point ensuring reproducible dependency versions
├── configuration.nix      # Main system entry point importing modules
└── Makefile               # Automation for maintenance tasks
```

## Management

### System Updates

To apply changes to the configuration:

```bash
# Using the provided script
./apply.sh

# Alternatively, using Make
make
```

### Manual Rebuild

If manual intervention is required:

```bash
sudo nixos-rebuild switch --flake /home/sodiq/nixos-config#sodiq
```

## Features

- **Shell Environment**: Zsh configured with Starship prompt for enhanced productivity.
- **Version Pinning**: The `nixpkgs` input is pinned to a specific commit hash to ensure consistent builds and minimize download bandwith.
- **Desktop Environment**: GNOME optimized with essential extensions (GSConnect, Blur my Shell, Caffeine, etc.).
- **Reproducibility**: Entire system state is defined declaratively.

## License

This project is licensed under the MIT License.
