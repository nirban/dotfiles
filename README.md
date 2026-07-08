# dotfiles

Personal shell, prompt, and tmux configuration managed with
[GNU Stow](https://www.gnu.org/software/stow/).

## Packages

This repository currently contains:

- `tmux` -> `~/.tmux.conf`
- `zshrc` -> `~/.zshrc`
- `starship` -> `~/.config/starship.toml`

## Requirements

Install the tools used by these configs before loading everything:

```bash
sudo apt update
sudo apt install -y stow git zsh tmux fzf fd-find
```

On Debian/Ubuntu, `fd-find` may install the command as `fdfind`. If `fd` is
missing after installation, add a local symlink:

```bash
mkdir -p ~/.local/bin
ln -s "$(command -v fdfind)" ~/.local/bin/fd
```

Optional, but recommended for the aliases and integrations in `zshrc/.zshrc`
and `tmux/.tmux.conf`:

```bash
sudo apt install -y eza zoxide
```

Install Starship:

```bash
curl -sS https://starship.rs/install.sh | sh
```

Install Oh My Zsh:

```bash
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

Install the custom Oh My Zsh plugins used by this config:

```bash
git clone https://github.com/zsh-users/zsh-autosuggestions \
  ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

git clone https://github.com/zsh-users/zsh-syntax-highlighting \
  ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
```

## Load All Configurations

From the root of this repository:

```bash
cd ~/dotfiles

stow -vt "$HOME" tmux
stow -vt "$HOME" zshrc
stow -vt "$HOME" starship
```

To reload all packages after editing files:

```bash
cd ~/dotfiles

stow -Rvt "$HOME" tmux
stow -Rvt "$HOME" zshrc
stow -Rvt "$HOME" starship
```

If an existing real file blocks Stow, back it up first:

```bash
mv ~/.tmux.conf ~/.tmux.conf.backup
mv ~/.zshrc ~/.zshrc.backup
mv ~/.config/starship.toml ~/.config/starship.toml.backup
```

Then run the `stow` commands again.

## tmux

Load the tmux config:

```bash
cd ~/dotfiles
stow -vt "$HOME" tmux
```

Install TPM, the tmux plugin manager:

```bash
mkdir -p ~/.tmux/plugins
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
```

Start tmux and reload the config:

```bash
tmux
tmux source-file ~/.tmux.conf
```

Inside tmux, install plugins with:

```text
prefix + I
```

This config uses `Ctrl-a` as the tmux prefix. So press:

```text
Ctrl-a, then Shift-i
```

Useful tmux bindings from this config:

- `Ctrl-a` -> prefix
- `prefix + o` -> SessionX session manager
- `prefix + p` -> Floax floating pane
- `prefix + u` -> fuzzy URL picker
- `prefix + F` -> tmux-fzf

## zsh

Load the zsh config:

```bash
cd ~/dotfiles
stow -vt "$HOME" zshrc
```

Make zsh your default shell:

```bash
chsh -s "$(which zsh)"
```

Reload the current shell:

```bash
source ~/.zshrc
```

The zsh config expects:

- Oh My Zsh at `~/.oh-my-zsh`
- `zsh-autosuggestions`
- `zsh-syntax-highlighting`
- `starship`
- `eza` for `l`, `lt`, and `ltree`
- `fd` and `fzf` for fuzzy finding
- `nvm`, if you want the Node.js setup loaded automatically
- optional local tools at `~/opt`, such as Neovim and Yazi

## Starship

Load the Starship prompt config:

```bash
cd ~/dotfiles
stow -vt "$HOME" starship
```

Reload zsh so Starship starts:

```bash
source ~/.zshrc
```

Verify that Starship can see the config:

```bash
starship explain
```

The zsh config already contains:

```bash
eval "$(starship init zsh)"
```

## Unload Configurations

Remove symlinks created by Stow:

```bash
cd ~/dotfiles

stow -Dvt "$HOME" tmux
stow -Dvt "$HOME" zshrc
stow -Dvt "$HOME" starship
```

## Check Links

Confirm that the expected files point back to this repo:

```bash
ls -l ~/.tmux.conf
ls -l ~/.zshrc
ls -l ~/.config/starship.toml
```
