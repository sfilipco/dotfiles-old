# dotfiles

Configuration files!!!

The format of this repository follows a git bare approach:
https://www.atlassian.com/git/tutorials/dotfiles

## Setup

```
git clone --recursive --bare git@github.com:sfilipco/dotfiles.git $HOME/.cfg
$HOME/.extra/fzf/install --bin
nvim +PlugInstall +qall
```

### Tmux

```
tmux $TMUX_OPTIONS new-session -As auto
C-A + I -- to install plugins press (prefix + capital I)
```

## Maintenance

Note that the `.extra` directory contains submodules that need to be manually
updated from time to time.
