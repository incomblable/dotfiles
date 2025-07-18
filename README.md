# Dotfiles

Personal dotfiles configuration managed with Nix, Nix-Darwin, and GNU Stow for macOS system setup.

## Quick Start

### Prerequisites

Install Nix with flakes support:

> IMPORTANT !
> Explicitly say no when prompted to install Determinate Nix.

```bash
curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install
```

### Installation

1. Apply dotfiles with Stow:

```bash
nix run nixpkgs#stow -- -R .
```

2. Then Install Nix-Darwin:

```bash
# Using unstable branch
nix run nix-darwin/master -- switch --flake ~/.config#$(hostname)
```
