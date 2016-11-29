#!/bin/bash

seq 1 30 | while read i; do sleep 30; echo -en "\r$((i * 30))/1500"; done; mplayer /home/michal/skrypty/break.mp3
