#!/bin/bash

source bash_utils.sh


# function returning array of dependencies for an app
function dependencies() {
    local app=$1
    result=( )
    case "${app}" in
    # fill with your app dependencies
    # e.g. if APP1 needs APP2 and APP3 to start add:
    # APP1 )
    #   result=(APP2 APP3)
    #   ;;
    # you can skip apps that don't have dependencies (result is initialized to empty array)
    #
    esac
}

# this is an OPTIONAL helper function which you may want to use in implementation of
# getStatus
function aliveEndpointUrl() {
    local app=$1
#
#    case "${app}" in
#    # fill with alive endpoint urls for your apps
#    # e.g. if APP1 has alive endpoint url on localhost:9876/alive add:
#    # APP1 )
#    #  result="http://localhost:9876/alive"
#    #;;
#   esac
}

# function returning status of given app
# it should return 200 if app has started
function getStatus() {
# example implementation using aliveEndpointUrl defined above.
# it will work fine if your alive endpoint returns 200 (OK) status code
    aliveEndpointUrl $1
    result=$(curl --write-out %{http_code} --silent --output /dev/null "${result}")
}


# OPTIONAL helper function that returns directory if app
# it might be helpful in implementing isStarting (see below)
function appDirectory() {
    local app=$1
    case "${app}" in
    # fill with your app directories
    # e.g. if APP1 is started in /home/me/apps/app1 add:
    #   APP1 )
    #       echo "/home/me/apps/app1
    #    ;;
    # Even if app is actually started from some sub-directory of given directory, it will be matched
    esac
}

# function which should return a non-empty result if app is starting or running
# e.g. if you use jetty and want to utilize appDirectory function you can implement it as follows
function isStarting() {
    local app=$1
    local appDir=$(appDirectory $app)
    grepProcessForNameAndDirectory jetty "$appDir"
}
