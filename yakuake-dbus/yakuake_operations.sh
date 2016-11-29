#!/bin/bash

MAX_TABS=1000

function log() {
# comment out the first line to disable logging
#  echo $1
:
}

function findSessionIdByTabName() {
  match_expr=$1
  result=-1
  for i in $(seq 0 $MAX_TABS)
  do
    session_id=$(qdbus org.kde.yakuake /yakuake/tabs sessionAtTab $i)
    if [[ $session_id == -1 ]]
    then 
      log "not found on $i, breaking"
      break
    fi
    title=$(qdbus org.kde.yakuake /yakuake/tabs tabTitle $session_id)

    if [[ "${title}" =~ $match_expr ]]
    then
      log "found app at session_id: $session_id"
      result=$session_id
      break
    else
      log "didn't match for title: $title and expression: $match_expr"
    fi

  done
}

function runCommandInSession() {
    session=$1
    command=$2

    qdbus org.kde.yakuake /yakuake/sessions runCommandInTerminal "${session}" "${command}"
}

function currentSession() {
    result=$(qdbus org.kde.yakuake /yakuake/sessions org.kde.yakuake.activeSessionId)
}

function newTab() {
    qdbus org.kde.yakuake /yakuake/sessions org.kde.yakuake.addSession &>/dev/null
    currentSession
}

function setTabTitle() {
    session=$1
    title=$2
    qdbus org.kde.yakuake /yakuake/tabs setTabTitle $session "${title}"
}