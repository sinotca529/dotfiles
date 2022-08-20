#!/bin/zsh

ZSH_PLUGIN_HOME=~/dotfiles/zsh/.zsh/plugin/

function load_file() {
    [ -f $1 ] && source $1
}

# Load plugin.
#   $1 : "git_username/git_reponame"
#   $2 : (Option) Specified file name to source.
function load_plugin() {
    local REPONAME=$(echo "$1" | cut -d "/" -f 2)
    local PLUGIN_PATH="$ZSH_PLUGIN_HOME/$REPONAME"
    if [ ! -d $PLUGIN_PATH ]; then
        echo "Install   : $1"
        git clone --depth 1 "https://github.com/$1.git" $PLUGIN_PATH
        echo "Installed : $1"
    fi

    load_file "$PLUGIN_PATH/$2" \
        || load_file "$PLUGIN_PATH/$REPONAME.plugin.zsh" \
        || load_file "$PLUGIN_PATH/$REPONAME.zsh" \
        || echo "WARN : Cannot enable $1"
}

# Entry point of zsh plugin manager.
#   $1: Sub command
#   $2: "git_username/git_reponame"
#   $3: (Option) Specified file name to source.
function plugman() {
    case $1 in
        "plug" ) shift; load_plugin "$@" ;;
    esac
}

# Unset all variable & function for plugin manager.
function plugman_unset() {
    unset -v ZSH_PLUGIN_HOME
    unset -f load_file
    unset -f load_plugin
    unset -f plugman
    unset -f plugman_unset
}

