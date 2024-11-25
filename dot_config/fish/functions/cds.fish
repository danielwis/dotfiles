function cds
    set chosen_dir $(find ~ -type d \( \
        \! -name ".config" \
        -a -name ".*" \
        -o -name "node_modules" \
    \) -prune \
    -o -type d -print | fzf)

    # If nothing has been selected, do nothing rather than cd without args
    if [ -n "$chosen_dir" ]
        cd $chosen_dir
    end
end
