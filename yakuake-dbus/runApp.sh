#!/bin/bash

#################################################################
# this script assumes that you use Yakuake                      #
# and you have a dedicated yakuake tab for each of the apps     #
#                                                               #
# Tab for app exampleApp should be called < EXAMPLEAPP >        #
#                                                               #
# You need to fill app_definition.sh script                     #
#                                                               #
#                                                               #
#################################################################

source pp_app_definition.sh
source app_start.sh

app=$(toUpperCase $1)
runApp $app
