#!/bin/bash
# ----------------------------------------------------------------------------
# Based on the Sam Hewitt's scripts
# available here <https://github.com/snwh/ubuntu-post-install>
# ----------------------------------------------------------------------------
# Authors     : radiium <radiium@openmailbox.org>
# github repo : <https://github.com/radiium>
# Description : A post-installation bash script for Ubuntu 16.04
# version     : 0.1
# ----------------------------------------------------------------------------

# tab width
tabs 4
clear

#----- Import Functions -----#
dir="$(dirname "$0")"

. $dir/functions/check
. $dir/functions/configure
. $dir/functions/update
. $dir/functions/codecs
. $dir/functions/softwares
. $dir/functions/cleanup


#----- Fancy Messages -----#
show_error(){
echo -e "\033[1;31m$@\033[m" 1>&2
}
show_info(){
echo -e "\033[1;32m$@\033[0m"
}
show_warning(){
echo -e "\033[1;33m$@\033[0m"
}
show_question(){
echo -e "\033[1;34m$@\033[0m"
}
show_success(){
echo -e "\033[1;35m$@\033[0m"
}
show_header(){
echo -e "\033[1;36m$@\033[0m"
}
show_listitem(){
echo -e "\033[0;37m$@\033[0m"
}

#----- Main Menu -----#
function main {
    eval `resize`
    MAIN=$(whiptail \
        --notags \
        --title "Ubuntu Post-Install Script" \
        --menu "\nWhat would you like to do?" \
        --cancel-button "Quit" \
        $LINES $COLUMNS $(( $LINES - 8 )) \
        configure   "Configure system\nsomeme" \
        update      "Perform system update" \
        codecs      "Install codecs" \
        softwares   "Install preferred software" \
        cleanup     "Cleanup the system" \
        3>&1 1>&2 2>&3)
    exitstatus=$?
    if [ $exitstatus = 0 ]; then
        $MAIN
    else
        quit
    fi
}

# Confirm quit menu
function quit {
    if (whiptail --title "Quit" --yesno "Are you sure you want quit?" 10 60) then
        echo "Exiting..."
        show_info 'Thanks for using!'
        exit 99
    else
        main
    fi
}

# RUN
check_dependencies
while :
do
  main
done

#END OF SCRIPT
