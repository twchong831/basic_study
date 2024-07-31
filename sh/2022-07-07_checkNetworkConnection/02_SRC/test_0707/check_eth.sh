# !/bin/sh

be_ethSt=no
loop_=true
while ${loop_}
do
	str=$(sudo ethtool enx00e04c680d53 | grep detected)
	echo "${str}"
	state=$(echo ${str} | cut -d ':' -f2)	# check ethernet port status
	echo ${state}

	if [ ${state} == yes ]
	then
		echo "ethernet ST YES"
		if [ ${be_ethSt} == ${state} ]
		then
			echo "yes - nothing"
			./test_connect_check
		else
			echo "new process start"
			./test_connect_check
		fi
	elif [ ${state} == no ]
	then
		echo "ehternet ST NO"
		if [ ${be_ethSt} == ${state} ]
		then
			echo "no - nothing"
		else
			echo "process end..."
			./stop.sh test_connect_check
			# loop_=false
		fi
	fi
	be_ethSt=${state}
done