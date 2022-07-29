# !/bin/sh

APP=test_app

be_ethSt=0
loop_=true

MAX_NUM=4
networkNameList=("swp0" "swp1" "swp2" "swp3")
networkStateList=(0 0 0 0)
before_networkStateList=(0 0 0 0)
CHECKED_REPROCESS=false

check_eth(){
	retr_st=0
	name=$1
	beforeState=$2

	str=$(sudo ethtool ${name} | grep detected)
	# echo "${str}"
	# echo "check ethernet Name ${name} & be_State : ${beforeState}"
	state_=$(echo ${str} | cut -d ':' -f2)	# check ethernet port status
	# echo "now state : ${state_}"

	if [ ${state_} == yes ]
	then
		# echo "ethernet ST YES"
		retr_st=1
	elif [ ${state_} == no ]
	then
		# echo "ehternet ST NO"
		retr_st=0
	fi
	# echo "FUNC return VAL : ${retr_st}"
	return ${retr_st}
}

while ${loop_}
# for (( j=0; j<1; j++ ))
do
	# echo "======================"
	# echo "loop start...${j}"
	# check_eth eth0 ${be_ethSt}
	# be_ethSt=$?
	# echo "check loop Result : ${be_ethSt}"

	for (( i=0; i<${MAX_NUM}; i++))
	do
		# echo "loop ${i} : ${networkNameList[${i}]} / ${networkStateList[${i}]}"
		check_eth ${networkNameList[${i}]} ${networkStateList[${i}]}
		be_ethSt=$?
		networkStateList[${i}]=${be_ethSt}
	done

	for (( i=0; i<${MAX_NUM}; i++))
	do
		if [ ${networkStateList[${i}]} == 1 ]
		then
			# echo "ethernet ST YES"
			if [ ${networkStateList[${i}]} == ${before_networkStateList[${i}]} ]
			then
				# echo "yes - nothing"
				# ./test_connect_check
				CHECKED_REPROCESS=false
			else
				echo "new process start"
				CHECKED_REPROCESS=true
				# ./test_connect_check
				break
			fi
		elif [ ${networkStateList[${i}]} == 0 ]
		then
			# echo "ehternet ST NO"
			if [ ${networkStateList[${i}]} == ${before_networkStateList[${i}]} ]
			then
				# echo "no - nothing"
				CHECKED_REPROCESS=false
			else
				echo "process end..."
				CHECKED_REPROCESS=true
				# loop_=false
				break
			fi
		fi
	done
	
	for (( i=0; i<${MAX_NUM}; i++))
	do
		before_networkStateList[${i}]=${networkStateList[${i}]}
	done

	# echo "process Mode ${CHECKED_REPROCESS}"
	# process change
	ethr_cnt=0
	if [ ${CHECKED_REPROCESS} == true ]
	then
		for (( i=0; i<${MAX_NUM}; i++ ))
		do
			# echo "check stat list : ${before_networkStateList[${i}]}"
			if [ ${before_networkStateList[${i}]} == 1 ]
			then
				ethr_cnt=$((${ethr_cnt} + 1))
			fi
		done
		
		echo "**** ${ethr_cnt}"

		./stop.sh ${APP}

		# 여기서 이름이 0인 파일이 생성됨?
		# 이유는??
		if [ ${ethr_cnt} -gt 0 ]
		then
			# echo "test"
			PROGRAM="${APP} -i ${ethr_cnt}"
			echo "ACTIVE**** ${PROGRAM}"
			./src/test_networkConnectionCheck/${PROGRAM} &
		fi
	fi
done	# loop END...

./stop.sh ${APP}