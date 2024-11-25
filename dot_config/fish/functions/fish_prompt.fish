function fish_prompt -d "Write out the prompt"
    # Print user@hostname in colour
    set_color --bold d7af5f
    printf '%s@%s' $USER $hostname

    # Reset colour but keep the bold
    set_color normal
    echo -ne "\033[1m"
    printf ' in '

    # Abbreviated CWD
    set_color --bold c76f6f
    echo -n (prompt_pwd --full-length-dirs 2)

    set resp $(git branch 2>/dev/null | grep \* | sed -e 's/* \(.*\)/\1/')
    if [ -n "$resp" ]
        set_color normal
        echo -ne "\033[1m"
        echo -n " on "
        set_color --bold green
        echo -n $resp
    end

    # Reset colour but keep the bold
    set_color normal
    echo -ne "\033[1m"
    printf ' at '

    # The time
    set_color --bold 5f87af
    date +%H:%M

    # Reset colour but keep the bold
    set_color normal
    echo -ne "\033[1m"
    printf '→ '

    # Set colour back to normal for the prompt
    set_color normal
end
