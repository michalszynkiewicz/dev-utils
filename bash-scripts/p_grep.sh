#!/bin/bash

PATTERN="${1}"; shift

ps aux | grep "${PATTERN}" | grep -v grep | grep --color "${PATTERN}"
