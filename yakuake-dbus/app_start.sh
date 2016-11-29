#!/bin/bash

source bash_utils.sh
source yakuake_operations.sh

function waitForStart() {
    local app=$1

    sleep 1
    while true
    do
        result=$(isStarting $app)
        echo "starting: $result"
        if [[ "x" = "x$result" ]]
        then
            echo "app $app is no longer starting! Quitting"
	    notifyError
            exit 1
        fi

        getStatus $app
        if [[ $result == "200" ]]
        then
            return
        else
            echo "$app is still starting, status: $started"
        fi
        sleep 5
    done
}

function findYakuakeSessionForApp() {
    local app=$1
    local match_expr="^< *${app} *>$"

    findSessionIdByTabName "${match_expr}"
}

function startApp() {
    echo "will start $app"
    local app=$1
    local appDir=$(appDirectory $app)
    findYakuakeSessionForApp $app
    session=$result
    echo "will start $app in session $session"

    runCommandInSession $session "cd $appDir; mvn -o clean install -Dmaven.test.skip=true -Pjetty"
}
function startIfNotRunning() {
    local app=$1
    getStatus $app
    if [[ $result == "200" ]]
    then
        echo "$app is already running. Exiting"
        return
    fi

    result=$(isStarting $app)
    echo "check result: $result"
    if [[ -n "$result" ]]     # mstodo: it seems it should be -n $result
    then
        echo "$app is already starting. waiting for start"
        waitForStart $app
        echo "$app started"
        return
    fi

    dependencies $app

    for i in ${result[*]}
    do
        echo $i
        startIfNotRunning $i
    done

    startApp $app
    waitForStart $app
}

function notifyError() {
	mplayer "/home/michal/skrypty/error.mp3"
}

function notifyFinished() {
# write some stuff which you want invoked on finish
# e.g. play some music:
    mplayer "/home/michal/skrypty/break.mp3"
}
# start app and all its dependencies
function runApp() {
    startIfNotRunning $1
    notifyFinished
}
