# nix-config

Personal Nix home-manager configuration for WSL Linux.

## Prerequisites

Install Nix with flakes enabled:

```bash
curl -L https://nixos.org/nix/install | sh -s -- --daemon
```

After installation, restart your shell and enable flakes:

```bash
mkdir -p ~/.config/nix
echo "experimental-features = nix-command flakes" >> ~/.config/nix/nix.conf
```

## Setup

1. Clone this repo:
   ```bash
   git clone https://github.com/lamcc21/nix-darwin-config.git ~/dev/nix-darwin-config
   cd ~/dev/nix-darwin-config
   ```

2. Apply the configuration:
   ```bash
   nix run home-manager/release-24.11 -- switch --flake .#lamcc21
   ```

3. Change default shell to zsh:
   ```bash
   chsh -s $(which zsh)
   ```

4. Log out and back in (or start a new terminal).

## Updating

After making changes to the config:

```bash
home-manager switch --flake .#lamcc21
```

To update flake inputs (nixpkgs, home-manager, etc.):

```bash
nix flake update
home-manager switch --flake .#lamcc21
```

## What's Included

- **Shell**: zsh with starship prompt, zoxide, atuin history
- **Editor**: neovim
- **Terminal**: tmux with vim-style bindings
- **Dev tools**: Rust, Node.js, Go, Python, Java, .NET, Terraform
- **CLI utils**: ripgrep, fd, eza, jq, htop
