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
