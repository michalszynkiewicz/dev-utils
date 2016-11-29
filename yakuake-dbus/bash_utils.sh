#!/bin/bash

function echoerr() {
    echo "$@" 1>&2;
}

function toUpperCase() {
    echo -ne $1 | tr '[:lower:]' '[:upper:]'
}

function grepPidFromPs() {
    echo $1 | awk '{print $1;}'
}

function grepProcessForNameAndDirectory() {
    local name=$1
    local directoryPattern=$2

    ps ax | grep "${name}" | grep -v grep | while read processDefinition
    do
        local result=$(grepPidFromPs $processDefinition)
        local directory=$(pwdx $result)
        if [[ "$directory" =~ $directoryPattern ]]
        then
            echo $result
            break
        fi
    done
}
