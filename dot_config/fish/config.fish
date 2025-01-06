if status is-interactive
    # Commands to run in interactive sessions

    fish_vi_key_bindings # Activate vim bindings

    # Bind <C-Space> to complete entire suggestion
    bind -M default -k nul forward-char
    bind -M insert -k nul forward-char

    # Bind <Alt-Space> to complete one word at a time
    bind -M default \e\x20 forward-word
    bind -M insert \e\x20 forward-word

    bind -M default \cw backward-kill-word
    bind -M insert \cw backward-kill-word

    set -gx EDITOR nvim
    set -gx VISUAL nvim

    set_colours

    # fzf goodness
    fzf --fish | source
end
