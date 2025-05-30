# Neovim Configuration

This repository contains my personal Neovim configuration, managed with [lazy.nvim](https://github.com/folke/lazy.nvim). It includes various plugins and settings optimized for a comfortable development experience. Built on top of [kickstart](https://github.com/nvim-lua/kickstart.nvim).

## Prerequisites

- **Neovim** version 0.8 or higher
- **Git** for cloning the repository
- **Nerd Font** installed on your system (e.g., [Hack Nerd Font](https://github.com/ryanoasis/nerd-fonts))
- **Node.js** v20+ for certain plugins (ensure it's in your system's PATH)

## Installation

### macOS and Linux

Open your terminal and run:

```bash
git clone https://github.com/bxrne/nvim-config.git "${XDG_CONFIG_HOME:-$HOME/.config}/nvim"
```

## Windows

Using PowerShell:

```powershell
git clone https://github.com/theadambyrne/nvim-config.git "$env:LOCALAPPDATA\nvim"
```

WSL (Windows Subsystem for Linux)

1. Clone the repository:

```bash
git clone https://github.com/theadambyrne/nvim-config.git "${XDG_CONFIG_HOME:-$HOME/.config}/nvim"
```

## Usage

Launch Neovim, and it will automatically install the required plugins using lazy.nvim.

## Updating

To update the plugins and configuration, open Neovim and run:

```vim
:Lazy update
```

## Additional Notes

The configuration disables NetRW in favor of the oil.nvim plugin. Adjust the Node.js path in plugins.lua if it's not located at /usr/bin/node.
Need Node > v20 for Copilot.
