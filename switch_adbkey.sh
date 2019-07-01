#!/bin/sh
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
ADBKEYS_FILE_PATH="$DIR/adbkeys"
if [[ $# -eq 0 ]] ; then
    echo "Set adbkey command:" 
    echo "$DIR/switch.sh set [ADBKEY_NAME] [PATH_FILE1:TARGET_FILE_NAME1,PATH_FILE2:TARGET_FILE_NAME2,...,PATH_FILEN:TARGET_FILE_NAMEN]\n"
    echo "i.g. $DIR/switch.sh set default $HOME/adbkey_store/adbkey:adbkey,$HOME/.android/adbkey.pub:adbkey.pub"
    echo "i.g. $DIR/switch.sh set myadbkey $HOME/adbkey_store/myadbkey:adbkey"
    exit 0
fi

if [ "$1" = "set" ] ; then
    echo "Set [$2]: $3"
    echo "$2\t$3" >> "$ADBKEYS_FILE_PATH"
    exit 0
fi

backup_all_of_adbkeys() {
    echo "Backup old adbkeys..."
    local androidadbkey="$HOME/.android/adbkey"
    local androidadbkeypub="$HOME/.android/adbkey.pub"
    if [ -f $androidadbkey ] ; then
        bash -c "mv $androidadbkey $androidadbkey.backup"
    fi
    if [ -f $androidadbkeypub ] ; then
        bash -c "mv $androidadbkeypub $androidadbkeypub.backup"
    fi
}

do_setter_command() {
    echo "Switch to [$1] adb key..."
    IFS=',' read -a lines <<< "$2"
    for path_str in "${lines[@]}"
    do
        IFS=':' read -a intr <<< "$path_str"
        echo "Copy $DIR/${intr[0]} to $HOME/.android/${intr[1]}"
        bash -c "cp $DIR/${intr[0]} $HOME/.android/${intr[1]}"
    done
    bash -c "adb kill-server"
    bash -c "adb start-server"
}

setter_names=($(cat $ADBKEYS_FILE_PATH | awk '{print $1}'))
for index in ${!setter_names[*]}; do
    if [ "$1" = ${setter_names[$index]} ] ; then
        backup_all_of_adbkeys
        setter_path_str=($(cat $ADBKEYS_FILE_PATH | awk '{print $2}'))
        do_setter_command ${setter_names[$index]} ${setter_path_str[$index]}
        exit 0
    fi
done