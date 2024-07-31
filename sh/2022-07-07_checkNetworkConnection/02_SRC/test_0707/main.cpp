#include "CARNAVICOM_LIB/UDP/carnavicom_udp.h"

int main()
{
	// CarnavicomUDP *m_udp = new CarnavicomUDP;
	// std::string ip_ = "192.168.123.99";
	// int port_ = 5000;

	// printf("init\n");
	// m_udp->InitUDP(ip_, port_);

	// printf("connect\n");
	// m_udp->connect();

	int cnt = 0;
	while(cnt < 10)
	{
		// printf("check UDP connection\n");
		// std::vector<u_char> data_ = m_udp->getData();
		// printf("input data size : %d\n", data_.size());
		printf("test loop....\n");
		cnt++;
	}

	return 0;
}