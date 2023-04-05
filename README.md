# How-to
### Dotfiles
Thanks to [this tutorial](https://www.atlassian.com/git/tutorials/dotfiles) for the great idea.

1. Add the following alias to your `.zshrc` (or `.bashrc`, etc.): `alias config='/usr/bin/git --git-dir=$HOME/.dots/ --work-tree=$HOME'`
2. Source that file to enable the alias (or just run the command above)
3. Ignore this folder in a `.gitignore`
4. Clone the repository
5. Checkout the config to your `$HOME` directory. If you have any existing files that conflict with this, remove or move them (depending on whether you'd like to keep them or not) and try again.
6. [Optional] Disable showing untracked files (to avoid `git status` getting cluttered).
7. Profit. Use `config` in place of `git` when working with your dotfiles (works from anywhere)

Commands for the above (use `.bashrc` in place of `.zshrc` if using bash):
1. `echo "alias config='/usr/bin/git --git-dir=$HOME/.dots/ --work-tree=$HOME'" >> .zshrc`
2. `source .zshrc`
3. `echo ".dots" >> .gitignore`
4. `git clone --bare git@github.com:danielwis/dotfiles.git $HOME/.dots`
5. `config checkout`
6. `config config --local status.showUntrackedFiles no`
7. For example: `config status`, `config add <file>`, `config commit`, etc.

### Firefox
1. Copy `$HOME/userChrome.css` to `.mozilla/firefox/*.default-release/chrome/` (the `*` part tends to differ from install to install). You may need to create the `chrome` directory manually
2. Go to `about:config` in Firefox
3. Set `toolkit.legacyUserProfileCustomizations.stylesheets` to `true`
4. :)
