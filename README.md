# dotfiles

```bash
cd ~/dotfiles

# just in case there were previous stow links, detach them
stow -D tmux 2>/dev/null || true

# restow tmux cleanly into $HOME
stow -vt "$HOME" tmux

ls -l ~/.tmux.conf

mkdir -p ~/.tmux/plugins

git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm


ls -R ~/.tmux

tmux

tmux source-file ~/.tmux.conf

tmux show -g @plugin

```
