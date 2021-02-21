# dotfiles

Configuration files!!!

The format of this repository follows a git bare approach:
https://www.atlassian.com/git/tutorials/dotfiles

## Setup

```
curl -Lks https://raw.githubusercontent.com/sfilipco/dotfiles/master/.extra/install-dotfiles.sh | /bin/bash
```
The most important thing that it does is clone the config repository with:
```
git clone --recursive --bare git@github.com:sfilipco/dotfiles.git $HOME/.cfg
```
The problem with using clone directly is that it is easy to run into
"conflicts".  The repository tracks the `.config` directory and it's common for
`.config` to have already been created. In that case the script moves the old
configs to `.config-backup` as a way to unblock the checkout.


### Tmux

I like to have a default `auto` session that I attach to by default.
```
tmux $TMUX_OPTIONS new-session -As auto
```

## Maintenance

Note that the `.extra` directory contains submodules that need to be manually
updated from time to time.
