#!/bin/zsh

function conf() {
    if [ -z "$1" ]; then
        nvim -c 'cd ~/dotfiles' ~/dotfiles
        return
    fi

    local conf_dir=~/dotfiles/$1

    if [ ! -d $conf_dir ]; then
        echo "Configuration for '$1' does not exist."
        return 1
    fi

    setopt local_options
    setopt nullglob
    setopt glob_dots
    while true; do
        local files=($conf_dir/*)

        if [ ${#files[@]} -eq 1 ];then
            if [ -d $files[1] ]; then
                conf_dir=$files[1]
            else
                nvim -c "cd $conf_dir" "${files[1]}"
                break
            fi
        else
            nvim -c "cd $conf_dir" "$conf_dir"
            break
        fi
    done
}

conf "$@"
