# How-to

### Dotfiles

I've migrated my dotfiles to use [chezmoi](https://www.chezmoi.io/). This allows templating configs for easier use on different machines and many other things. A script for moving `userChrome.css` will be added later, but for now, see below for instructions on how to do this.

### Firefox

1. Copy `$HOME/userChrome.css` to `.mozilla/firefox/*.default-release/chrome/` (the `*` part tends to differ from install to install). You may need to create the `chrome` directory manually
2. Go to `about:config` in Firefox
3. Set `toolkit.legacyUserProfileCustomizations.stylesheets` to `true`
4. :)
