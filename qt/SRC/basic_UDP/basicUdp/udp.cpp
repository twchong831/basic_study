#include "udp.h"

udp::udp(QObject *parent)
	: QObject{parent}
{
	g_udpsock = new QUdpSocket();
	g_checked_multicast = false;
	g_udpIP = "127.0.0.1";
	g_udpMultiIP = "224.0.0.1";
	g_udpPort = 5000;

	g_checked_send_stage = true;

	g_dum_send_count= 0;
}

void udp::init(QString ip_, quint16 port_)
{
	g_udpIP = ip_;
	g_udpPort = port_;

	initUDP();
}

void udp::init(QString ip_, quint16 port_, QString group_ip_)
{
	g_udpIP = ip_;
	g_udpPort = port_;
	g_udpMultiIP = group_ip_;
	g_checked_multicast = true;

	initUDP();
}

bool udp::connected(bool checked)
{
	if(checked)	//connect
	{
		if(!g_checked_multicast)	//unicast
		{
			qDebug() << "check connect : " << g_udpIP << g_udpPort;
			if(g_udpsock->bind(QHostAddress(g_udpIP), static_cast<unsigned short>(g_udpPort), QAbstractSocket::ShareAddress))
			{
				connect(g_udpsock, SIGNAL(readyRead()), this, SLOT(readDatagram()));
				return true;
			}
			else
			{
				qDebug() << "binding error" << g_udpIP << g_udpPort;
				return false;
			}
		}
		else						//multicast
		{
			if(g_udpsock->bind(QHostAddress::AnyIPv4, static_cast<unsigned short>(g_udpPort),
							  QAbstractSocket::ShareAddress | QAbstractSocket::ReuseAddressHint))
			{
				g_udpsock->setMulticastInterface(g_iface);	//순서?
				g_udpsock->joinMulticastGroup(g_hostAddr, g_iface);

				connect(g_udpsock, SIGNAL(readyRead()), this, SLOT(readDatagram()));
				return true;
			}
			else
				return false;
		}
	}
	else		//disconnect
	{
		disconnect(g_udpsock, SIGNAL(readyRead()), this, SLOT(readDatagram()));
		g_udpsock->close();
		return true;
	}
}

QString udp::getSenderIP()
{
	return g_senderIP;
}

void udp::send(const QByteArray &buf_)
{
	g_udpsock->writeDatagram(buf_, QHostAddress(g_udpIP), static_cast<unsigned short>(g_udpPort));
}

void udp::send_signal(QByteArray buf)
{
	g_checked_send_stage = false;

	size_t re = g_udpsock->writeDatagram(buf, QHostAddress(g_udpIP), static_cast<unsigned short>(g_udpPort));

	if(buf.size() == re)
	{
		// qDebug() << "[UDP][SEND_SIGNAL]:\tSize:\t" << re << "\tPacket NUM:\t" << (u_char)buf[buf.size()-5];
		// printf("Output\t%d\t:\t%d\t:\t%d\t%d.%d.%d.%d\n", g_dum_send_count++, (u_char)buf[buf.size()-5], re, (u_char)buf[buf.size()-4], (u_char)buf[buf.size()-3], (u_char)buf[buf.size()-2], (u_char)buf[buf.size()-1]);
#if DEBUG_MT==1
		qDebug() << "[UDP][SEND_SIGNAL]:\tSize:\t" << re << "\tPacket NUM:\t" << (u_char)buf[buf.size()-5];
#elif DEBUG_MT==2
		printf("UDP send result\t%d\t%d\t%d\n", 
				re, (u_char)buf[buf.size()-5], (u_char)buf[buf.size()-4]);
#endif
	}
	else
	{
#if DEBUG_MT==1
		qDebug() << "[ERROR]UDP SEND FAILED";
#elif DEBUG_MT==2
		printf("UDP send FAIL\n");
#endif
	}
	g_checked_send_stage = true;

	emit SIGNAL_sendEnd(false);
}

bool udp::checkedSendStage()
{
	return g_checked_send_stage;
}

QByteArray udp::getDatagram()
{
	QByteArray buf;
	QHostAddress sender;
	quint16 s_port;
	buf.resize(g_udpsock->pendingDatagramSize());
	if(g_udpsock->readDatagram(buf.data(), buf.size(), &sender, &s_port))
	{
		g_senderIP = sender.toString();
	}

	return buf;
}

void udp::readDatagram()
{
	QByteArray buf;
	QHostAddress sender;
	quint16 s_port;
	buf.resize(g_udpsock->pendingDatagramSize());
	g_udpsock->readDatagram(buf.data(), buf.size(), &sender, &s_port);

	g_senderIP = sender.toString();

	emit SIGNAL_emitDatagram(buf);
}

void udp::initUDP()
{
	if(!g_checked_multicast) //unicast
	{

	}
	else	//multicast
	{
		g_iface = getNetworkInterfaceByAddress(g_udpIP);
		g_hostAddr = QHostAddress(g_udpMultiIP);
	}
}

QNetworkInterface udp::getNetworkInterfaceByAddress(QString ip_)
{
	QList<QNetworkInterface> il(QNetworkInterface::allInterfaces());
	for(int i=0; i<il.size(); i++)
	{
		QList<QNetworkAddressEntry> ade(il[i].addressEntries());
		for(int j=0; j<ade.size(); j++)
		{
			if(ade[j].ip().toString() == ip_)
				return il[i];
		}
	}

	return QNetworkInterface();
}
