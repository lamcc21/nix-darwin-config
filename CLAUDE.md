# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

This is a personal nix-darwin configuration repository that manages system configuration for a macOS machine using Nix flakes. The configuration includes both system-level settings (via nix-darwin) and user-level dotfiles/packages (via home-manager).

## Architecture

The configuration is structured as a Nix flake with three main components:

- **flake.nix**: The entry point that defines inputs, system configuration, and coordinates all modules
- **darwin.nix**: System-level configuration (dock settings, finder preferences, etc.)  
- **home.nix**: User-level configuration (packages, shell setup, dotfiles, program configurations)

The flake uses:
- `nixpkgs-24.11-darwin` channel
- `nix-darwin` for macOS system configuration
- `home-manager` for user environment management
- `rust-overlay` for Rust toolchain management

Target system: `aarch64-darwin` (Apple Silicon Mac)
Username: `lamcc21`
Hostname: `Lachlans-MacBook-Air`

## Common Commands

### Apply Configuration
```bash
# Build and apply the darwin configuration
darwin-rebuild switch --flake .

# Build without applying (for testing)
darwin-rebuild build --flake .

# Check what would change
darwin-rebuild build --flake . --show-trace
```

### Update Dependencies
```bash
# Update all flake inputs
nix flake update

# Update specific input
nix flake update nixpkgs
```

### Development
```bash
# Check flake syntax and evaluate
nix flake check

# Show flake info
nix flake show

# Enter development shell with nix tools
nix develop
```

## Key Configuration Areas

### Package Management
All user packages are defined in `home.nix` under `home.packages`. The configuration includes development tools (Rust, Node.js, Go, Java), command-line utilities, and system tools.

### Shell Configuration
Zsh is configured with:
- Homebrew integration
- Custom aliases and functions
- Development tool PATH exports
- Integration with starship prompt and zoxide

### System Defaults
macOS system preferences are configured in `darwin.nix`, currently setting dock autohide and showing hidden files in Finder.