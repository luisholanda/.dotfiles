#!/bin/bash
#Start Spotifyd only if it is not running
if [ "$(ps -ef | grep -v grep | grep spotifyd | wc -l)" -le 0 ]
then
 # Note starting mariadb not as a sudoer
 /Users/luiscm/Sources/spotifyd/target/release/spotifyd
 echo "Spotifyd Started"
else
 echo "Spotifyd Already Running"
fi
