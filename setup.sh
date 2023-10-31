#!/usr/bin/env bash

# make sure we have pulled in and updated any submodules
#git submodule initn
#git submodule update

# what directories should be installable by all users including the root user
base=(
    shell
    vim
    zsh
)

# folders that should, or only need to be installed for a local user
useronly=(
    dunst
    flameshot
    git
    gtk
    i3
    polybar
    ranger
    rofi
    fontconfig
    pywal
)

# run the stow command for the passed in directory ($2) in location $1
stowit() {
    usr=$1
    app=$2
    # -v verbose
    # -R recursive
    # -t target
    stow -v -R -t ${usr} ${app}
}

echo ""
echo "Stowing apps for user: ${whoami}"

# install apps available to local users and root
for app in ${base[@]}; do
    stowit "${HOME}" $app 
done

# install only user space folders
for app in ${useronly[@]}; do
    if ! "$(whoami)" = *"root"*; then
        stowit "${HOME}" $app 
    fi
done

echo ""
echo "##### ALL DONE"
