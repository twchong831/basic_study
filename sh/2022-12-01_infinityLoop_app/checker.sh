#!/bin/sh

sh_APP=./checker.sh
APP=${1}	#input app name

#백그라운드 동작 중인지 확인
# ps -ef을 이용해서 원하는 프로세스 정보를 얻는다.
var1=$(ps -ef | grep ${APP})
echo "1 : ${var1}"
# pid를 얻는다. (공백으로 잘라서, 두번째 argument)
second1=$(echo ${var1} | cut -d " " -f2)
find_grep=$(echo ${var1} | cut -d " " -f8)
third=$(echo ${var1} | cut -d " " -f9)
echo "2 : ${second1}"
echo "3 : ${find_grep}"
echo "4 : ${third}"
# pid가 존재할 경우 프로세스를 kill 한다.
# -n 스트링은, 문자열 길이가 0 이 아닐 경우 true를 리턴한다.

if [ -n "${second1}" ]
then
	if [ ${find_grep} != "grep" ]   #grep을 찾는다면 이는 grep 명령어에 의해 실행된 프로세스
	then
		echo "find not grep"
		if [ ${third} != ${sh_APP} ]
		then
			echo "Process Active...${second1} / ${find_grep}"
		else
			echo "ReActive application ; ${APP}"
			./${APP}
		fi
	else
		echo "ReActive application ; ${APP}"
		./${APP}
	fi
else
	echo "ReActive application ; ${APP}"
	./${APP}
fi