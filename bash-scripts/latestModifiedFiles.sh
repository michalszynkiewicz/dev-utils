#!/bin/bash

function findLatestModifiedFiles() {
    local d="${1:-.}"
    local m="${2:-10}"
    local f="${3:-%Td %Tb %TY, %TT}"

    find "$d" -type f -printf "%T@ :$f %p\n" | sort -nr | cut -d: -f2- | head -n"$m"
}

findLatestModifiedFiles $@
