#!/bin/sh

dir_name=${1}

if [ ! -d "${dir_name}" ]; then
	echo "Directory : [${dir_name}] not EXIST."
	mkdir -p ${dir_name}
else
	echo "Directory : [${dir_name}] EXIST."
fi