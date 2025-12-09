# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

This is a personal home-manager configuration repository that manages user environment configuration for WSL Linux using Nix flakes. The configuration includes user-level dotfiles, packages, and program configurations.

## Architecture

The configuration is structured as a Nix flake with two main components:

- **flake.nix**: The entry point that defines inputs, outputs, and coordinates home-manager configuration
- **home.nix**: User-level configuration (packages, shell setup, dotfiles, program configurations)

The flake uses:
- `nixpkgs-24.11` channel
- `home-manager` for user environment management
- `rust-overlay` for Rust toolchain management

Target system: `x86_64-linux` (WSL)
Username: `lamcc21`

## Common Commands

### Apply Configuration
```bash
# Build and apply the home-manager configuration
home-manager switch --flake .#lamcc21

# Build without applying (for testing)
home-manager build --flake .#lamcc21
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
```

## Key Configuration Areas

### Package Management
All user packages are defined in `home.nix` under `home.packages`. The configuration includes development tools (Rust, Node.js, Go, Java), command-line utilities, and system tools.

### Shell Configuration
Zsh is configured with:
- Custom aliases and functions
- Development tool PATH exports
- Integration with starship prompt and zoxide
