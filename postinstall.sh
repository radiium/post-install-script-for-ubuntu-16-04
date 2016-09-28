#!/bin/bash


resta=$(while IFS='' read -r line || [[ -n "$line" ]]; do
    echo $line
done < "./data/codecs.list")
echo $resta
echo
echo
echo
echo
echo
echo





dir="$(dirname "$0")"

function check_menu() {
    # Get PATH file argument
    FILE=$1
    # Get package list
    i=1
    packages_list=()
    while read pkg ; do
        packages_list+=("${pkg} $i off")
        i=$[i+1]
    done < $FILE
    # Return menu
    return PACKAGES_SELECT=$(whiptail \
        --title "List of available codecs" \
        --checklist \
        "Select by space key" \
        --separate-output \
        0 0 0 \
        ${packages_list[@]} \
        3>&1 1>&2 2>&3)
}

list=check_menu "$dir/data/codecs.list"
echo "$list"
