# dotfiles

Configuration files!!!

The format of this repository follows a git bare approach:
https://www.atlassian.com/git/tutorials/dotfiles

## Setup

First we need to clone the dotfiles repository. The problem that we may run
into is that we may have config files already that prevent the checkout of
the repository. The `install-dotfiles` script moves the offending files out
of the way to unblock the checkout.
```
git clone --recursive --bare git@github.com:sfilipco/dotfiles.git $HOME/.cfg
```
```
curl -Lks https://raw.githubusercontent.com/sfilipco/dotfiles/master/.extra/install-dotfiles.sh | /bin/bash
```

From here we will want to install `fzf`. Consider pulling in the submodule
before the install. Skipping on this install will result in a poor experience.
It is hooked up in `zsh` and `neovim`.

```
$HOME/.extra/fzf/install --bin
```

After that we can start installing plugins for our applications.

### Nvim

```
e +PlugInstall +qall
```

### Tmux

```
tmux $TMUX_OPTIONS new-session -As auto
C-A + I -- to install plugins press (prefix + capital I)
```

## Maintenance

Note that the `.extra` directory contains submodules that need to be manually
updated from time to time.
