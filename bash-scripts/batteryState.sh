#!/bin/bash

upower -i /org/freedesktop/UPower/devices/battery_BAT0 | grep percentage
upower -i /org/freedesktop/UPower/devices/battery_BAT1 | grep percentage
