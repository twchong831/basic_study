# ping test

trap "cleanup; exit" SIGHUP SIGINT SIGTERM
function cleanup()
{
	echo "SIGNAL interrupt..."
}

for ((i=0; i<=255; i++))
do
	IP=192.168.55.${i}
	echo "check IP : ${IP}"
	ping -c 1 -W 1 ${IP} > /dev/null
	# -c 1 : 1개 요청 패킷만 보냄
	# -W 1 : 응답 대기 시간 지정, 1초
	
	if [ $? -eq 0 ]; then
		echo "node ${IP} up..."
		# sleep 0.5
	fi
done
