#!/usr/bin/env bash
/usr/bin/git clone --recursive --bare "git@github.com:sfilipco/dotfiles.git" "$HOME/.cfg"
function config {
   /usr/bin/git --git-dir="$HOME/.cfg/" --work-tree="$HOME" "$@"
}
mkdir -p "$HOME/.config-backup"
cd "$HOME" || exit 1
config checkout
if config checkout; then
  echo "Checked out config.";
  else
    echo "Backing up pre-existing dot files.";
    config checkout 2>&1 | grep -E "\\s+\\." \
        | awk "{'print $1'}" | xargs -I{} mv {} "$HOME/.config-backup/{}"
fi;
config checkout
config config status.showUntrackedFiles no
config submodule init
config submodule update

touch .zshrc.local

# fuzzy-finder, useful for most search models
"$HOME/.extra/fzf/install" --bin

# install neovim
curl -fLo "${HOME}/.bin/nvim" --create-dirs \
    https://github.com/neovim/neovim/releases/download/nightly/nvim.appimage
chmod +x "${HOME}/.bin.nvim"
# install vim-plug for nvim; plugin manager
curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
# install nvim plugins
nvim +PlugInstall +qall
