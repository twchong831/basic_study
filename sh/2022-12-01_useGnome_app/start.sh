#!/bin/sh

APP=app_name
p_PATH=/usr/tw/workspace/

echo "YT Kanavi-mobility Side LiDAR System Start"
sleep 5s

(cd ${p_PATH} && gnome-terminal -- ./${APP})
