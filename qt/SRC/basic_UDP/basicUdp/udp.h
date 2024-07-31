#ifndef UDP_H
#define UDP_H

#include <QtNetwork/QUdpSocket>
#include <QtNetwork/QAbstractSocket>
#include <QtNetwork/QNetworkInterface>
#include <QtNetwork/QHostAddress>
#include <QObject>
#include <QtCore>

class udp : public QObject
{
	Q_OBJECT
public:
	explicit udp(QObject *parent = nullptr);

	void init(QString ip_, quint16 port_);
	void init(QString ip_, quint16 port_, QString group_ip_);

	bool connected(bool checked);

	QString getSenderIP();

	void send(const QByteArray &buf_);
	bool checkedSendStage();

	QByteArray getDatagram();

public slots:
	void send_signal(QByteArray buf);

signals:
	void SIGNAL_emitDatagram(QByteArray);
	void SIGNAL_sendEnd(bool);

private slots:
	void readDatagram();

private:
	//func.
	void initUDP();
	QNetworkInterface getNetworkInterfaceByAddress(QString ip_);

	//var.
	QUdpSocket *g_udpsock;
	bool g_checked_multicast;
	quint16 g_udpPort;
	QString g_udpIP;
	QString g_udpMultiIP;

	QString g_senderIP;

	QNetworkInterface g_iface;
	QHostAddress g_hostAddr;

	bool g_checked_send_stage;

	unsigned int g_dum_send_count;
};

#endif // UDP_H
