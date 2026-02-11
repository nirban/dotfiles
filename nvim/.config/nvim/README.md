# 💤 LazyVim

A starter template for [LazyVim](https://github.com/LazyVim/LazyVim).
Refer to the [documentation](https://lazyvim.github.io/installation) to get started.

Here’s a README you can drop straight into your dotfiles repo (e.g. `dotfiles/README-neovim.md`) for **setting up LazyVim + all the CLI tools you’re using on WSL Ubuntu**.

You can tweak names/links, but the steps should “just work” on a fresh WSL install.

---

# Neovim + LazyVim Setup (WSL Ubuntu)

This document describes how to go from a fresh **WSL Ubuntu** install to a fully working **Neovim + LazyVim** environment with all required CLI tools (ripgrep, fd, fzf, lazygit, tree-sitter, Copilot, Avante, img-clip, etc.).

It assumes:

* Windows 11 + WSL2
* Ubuntu running inside WSL (commands below are run **inside WSL**, in your Linux shell)
* You’ll manage config via a dotfiles repo (e.g. `~/dotfiles` + `stow`)

LazyVim requirements (summarised from the official docs): Neovim ≥ 0.11.2, Git ≥ 2.19, a Nerd Font, `ripgrep`, `fd`, `fzf`, `lazygit`, `tree-sitter-cli`, `curl` and a C compiler. ([lazyvim.github.io][1])

---

## 0. TL;DR: one-shot package install

If you already have Neovim, Node & Python, you can run this block first and then read the details:

```bash
sudo apt update

# Core build + tools
sudo apt install -y \
  git curl unzip build-essential pkg-config \
  ripgrep fd-find fzf lazygit \
  xclip wl-clipboard \
  imagemagick ghostscript texlive-latex-base \
  swipl

# Make fd available as `fd`
if ! command -v fd >/dev/null 2>&1; then
  echo 'alias fd=fdfind' >> ~/.zshrc
  echo 'alias fd=fdfind' >> ~/.bashrc
fi

# Node-based CLIs
npm install -g tree-sitter-cli @mermaid-js/mermaid-cli
```

Then follow the sections below to:

* install Neovim,
* install Node (via nvm) and Python,
* clone LazyVim / your dotfiles,
* run health checks and Copilot auth.

---

## 1. Install Neovim

LazyVim requires **Neovim ≥ 0.11.2** built with LuaJIT. ([lazyvim.github.io][1])

### 1.1. Remove old Neovim (optional, but recommended on a fresh machine)

```bash
sudo apt remove -y neovim
sudo apt autoremove -y
```

### 1.2. Install latest Neovim from official tarball

Check the latest Linux release from Neovim’s GitHub releases page and adjust the URL if needed.

```bash
cd ~
NVIM_VERSION="latest"  # keep as 'latest' unless you want a specific tag
wget https://github.com/neovim/neovim/releases/${NVIM_VERSION}/download/nvim-linux64.tar.gz
tar xzf nvim-linux64.tar.gz
sudo mv nvim-linux64 /opt/nvim
echo 'export PATH="/opt/nvim/bin:$PATH"' >> ~/.bashrc
echo 'export PATH="/opt/nvim/bin:$PATH"' >> ~/.zshrc
source ~/.bashrc  # or source ~/.zshrc
```

Verify:

```bash
nvim --version
# should show >= 0.11.x
```

---

## 2. Install core CLI tools

These are the tools LazyVim and its plugins expect to find. ([lazyvim.github.io][1])

```bash
sudo apt update

# Search & navigation
sudo apt install -y ripgrep fd-find fzf lazygit

# System basics
sudo apt install -y git curl unzip build-essential pkg-config tar

# Clipboard (for img-clip & general yanking)
sudo apt install -y xclip wl-clipboard

# Image / PDF / LaTeX support for snacks.image & render-markdown (optional but nice)
sudo apt install -y imagemagick ghostscript texlive-latex-base

# Prolog (for SWI-Prolog LSP)
sudo apt install -y swipl


```
## LazyGit 

```bash
LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | \grep -Po '"tag_name": *"v\K[^"]*')
curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/download/v${LAZYGIT_VERSION}/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
tar xf lazygit.tar.gz lazygit
sudo install lazygit -D -t /usr/local/bin/
```


Make `fd` available under the expected name:

```bash
echo 'alias fd=fdfind' >> ~/.bashrc
echo 'alias fd=fdfind' >> ~/.zshrc
```

Restart the shell or `source ~/.bashrc` / `source ~/.zshrc`, then check:

```bash
rg --version
fd --version
fzf --version
lazygit --version
```

---

## 3. Install Node.js (via nvm) and tree-sitter CLI

**Node** is required for:

* GitHub Copilot (`copilot.lua`) ([GitHub][2])
* `tree-sitter-cli` (recommended by `nvim-treesitter`) ([GitHub][3])
* `@mermaid-js/mermaid-cli` (for Mermaid diagrams)

### 3.1. Install nvm

```bash
# Get the install script from nvm repo (check their README for latest URL if this fails)
curl -fsSL https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.0/install.sh | bash

# Load nvm (add to your shell rc if not already there)
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
```

Add the above `NVM_DIR` lines to `~/.bashrc` and `~/.zshrc` so Neovim launched from WezTerm sees Node.

### 3.2. Install a recent Node

```bash
nvm install --lts
nvm use --lts
node --version
npm --version
```

### 3.3. Install tree-sitter CLI and Mermaid CLI

```bash
npm install -g tree-sitter-cli @mermaid-js/mermaid-cli
```

`nvim-treesitter` expects `tree-sitter` CLI and a C compiler (`gcc` from build-essential). ([GitHub][3])

---

## 4. Python environment

For Python tooling (linters, formatters, LSPs):

```bash
sudo apt install -y python3 python3-pip python3-venv

python3 --version
pip3 --version
```

For example, to install `pylsp` via pip:

```bash
pip3 install 'python-lsp-server[all]'
```

(LSP installation itself is managed via Mason / LazyVim, but having Python is necessary.)

---

## 5. Clipboard & image pasting (img-clip.nvim)

`img-clip.nvim` needs a clipboard helper to paste images. On Linux it supports **xclip** (X11) or **wl-clipboard** (Wayland). ([GitHub][4])

We already installed both:

```bash
sudo apt install -y xclip wl-clipboard
```

Later, inside Neovim you can run:

```vim
:checkhealth img-clip
```

It should show all OK.

> Note (WSL): clipboard behaviour depends on your terminal (WezTerm / Windows Terminal) and WSL integration. The health checks only confirm the binaries exist.

---

## 6. Install LazyVim + your config

### 6.1. Clone LazyVim starter (if you don’t already have a config)

If this is your first time installing LazyVim:

```bash
git clone https://github.com/LazyVim/starter ~/.config/nvim
cd ~/.config/nvim
rm -rf .git
```

LazyVim’s installation docs recommend this starter as the base config. ([GitHub][5])

### 6.2. OR: clone your dotfiles and stow Neovim

If you keep Neovim config in a dotfiles repo:

```bash
cd ~
git clone <your-dotfiles-repo-url> ~/dotfiles
cd ~/dotfiles

# Example: config directory is dotfiles/.config/nvim
stow nvim   # adjust to your directory layout
```

Make sure that, after stowing, `~/.config/nvim` contains your LazyVim-based config.

---

## 7. First Neovim launch & health checks

### 7.1. Start Neovim (this will install plugins)

```bash
nvim
```

Lazy will automatically download and install all plugins. Let it finish.

### 7.2. Run Lazy & health

Inside Neovim:

```vim
:Lazy
:LazyHealth   " loads plugins and runs health checks
:checkhealth  " Neovim + plugins health
```

LazyVim docs recommend running `:LazyHealth` to verify required tools (`rg`, `fd`, `lazygit`, `tree-sitter-cli`, `curl`, etc.) are present. ([lazyvim.github.io][1])

Fix any remaining missing tools by installing them via `apt` or `npm`, then re-run `:checkhealth`.

---

## 8. GitHub Copilot (copilot.lua) + Avante

### 8.1. Ensure copilot.lua plugin is configured

In your LazyVim plugin specs (e.g. `~/.config/nvim/lua/plugins/copilot.lua`):

```lua
return {
  "zbirenbaum/copilot.lua",
  cmd = "Copilot",
  build = ":Copilot auth",
  event = "InsertEnter",
  opts = {
    suggestion = { enabled = false }, -- Avante will handle suggestions/chat
    panel = { enabled = false },
  },
}
```

This plugin provides the Copilot LSP used by Avante. ([GitHub][2])

Restart Neovim and run:

```vim
:Copilot auth
```

Follow the browser flow to log in to GitHub Copilot. After authentication the credentials file is stored under `~/.config/github-copilot/apps.json` which Avante’s Copilot provider uses. ([GitHub][6])

### 8.2. Configure Avante with Copilot provider

Your Avante plugin spec (e.g. `~/.config/nvim/lua/plugins/avante.lua`) should look like:

```lua
return {
  "yetone/avante.nvim",
  build = vim.fn.has("win32") ~= 0
    and "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false"
    or "make",
  event = "VeryLazy",
  version = false,
  opts = {
    provider = "copilot",
    instructions_file = "avante.md",
  },
  dependencies = {
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
    "nvim-tree/nvim-web-devicons",
    "stevearc/dressing.nvim",
    "hrsh7th/nvim-cmp",
    "ibhagwan/fzf-lua",
    "folke/snacks.nvim",
    "zbirenbaum/copilot.lua",
  },
}
```

Avante’s README and blog posts show `provider = "copilot"` as the standard Copilot integration. ([GitHub][7])

After this, restart Neovim. The Copilot health check should show:

* Node found
* credentials file found
* LSP client running

And Avante should load without complaining.

---

## 9. SWI-Prolog LSP (optional)

If you use Prolog:

1. Install the Prolog pack **lsp_server**:

   ```bash
   swipl -g "pack_install(lsp_server)" -t halt
   ```

2. Add a custom LSP config for Prolog in Neovim:

   ```lua
   -- ~/.config/nvim/lua/plugins/prolog-lsp.lua
   return {
     "neovim/nvim-lspconfig",
     opts = function(_, opts)
       local lspconfig = require("lspconfig")
       local configs = require("lspconfig.configs")
       local util = require("lspconfig.util")

       if not configs.prolog then
         configs.prolog = {
           default_config = {
             cmd = {
               "swipl",
               "-g", "use_module(library(lsp_server)).",
               "-g", "lsp_server:main",
               "-t", "halt",
               "--", "stdio",
             },
             filetypes = { "prolog" },
             root_dir = util.root_pattern("pack.pl", ".git", "."),
             single_file_support = true,
           },
         }
       end

       opts.servers = opts.servers or {}
       opts.servers.prolog = opts.servers.prolog or {}
       return opts
     end,
   }
   ```

3. Open a `.pl` file and run `:LspInfo` – you should see a `prolog` client attached.

---

## 10. Snacks, images & PDFs (optional polish)

Snacks’ image component can render:

* images via **ImageMagick**
* PDFs via **Ghostscript**
* LaTeX math via **pdflatex/tectonic**
* Mermaid diagrams via **`mmdc` (Mermaid CLI)** ([YouTube][8])

We already installed:

```bash
sudo apt install -y imagemagick ghostscript texlive-latex-base
npm install -g @mermaid-js/mermaid-cli
```

In Neovim, health:

```vim
:checkhealth snacks
```

> Note: WSL + Windows Terminal doesn’t support kitty’s graphics protocol; Snacks will still work for some features, but inline image rendering depends on your terminal (WezTerm/Kitty on Windows side).

---

## 11. Final checklist

After completing all steps:

Inside Neovim:

```vim
:LazyHealth
:checkhealth
:checkhealth nvim-treesitter
:checkhealth copilot
:checkhealth img-clip
```

All sections relevant to your setup should be green ✅ or at worst yellow ⚠️ (for truly optional bits).

From WSL shell:

```bash
nvim --version
node --version
python3 --version
rg --version
fd --version
fzf --version
lazygit --version
tree-sitter --version
swipl --version   # if you use Prolog
```

If anything still shows as missing in `:checkhealth`, you can add the corresponding package and rerun.

