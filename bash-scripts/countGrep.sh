#!/bin/bash

FILE="${1}"; shift
PATTERN="${1}"; shift

cat "${FILE}" | grep "${PATTERN}" | wc -l


