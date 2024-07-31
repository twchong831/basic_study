#include "mainwindow.h"
#include "ui_mainwindow.h"
#include <QDebug>

MainWindow::MainWindow(QWidget *parent)
	: QMainWindow(parent)
	, ui(new Ui::MainWindow)
{
	ui->setupUi(this);

	m_udp = new udp(this);

	m_udp->init("192.168.123.99", 5000, "224.0.0.5");

	ui->pushButton_connect->setCheckable(true);

	g_inputCnt = 0;
}

MainWindow::~MainWindow()
{
	delete ui;
}

void MainWindow::getDatagram(QByteArray buf)
{
	if( buf.size() > 0)
		qDebug() << "input" << "[" << g_inputCnt++ << "]" << "size : " << buf.size();
}


void MainWindow::on_pushButton_connect_clicked(bool checked)
{
	if(!m_udp->connected(checked))
	{
		qDebug() << "Connected Error..." << checked;
	}

	if(checked)
	{
		connect(m_udp, SIGNAL(SIGNAL_emitDatagram(QByteArray)), this, SLOT(getDatagram(QByteArray)));
	}
	else
	{
		disconnect(m_udp, SIGNAL(SIGNAL_emitDatagram(QByteArray)), this, SLOT(getDatagram(QByteArray)));
		g_inputCnt = 0;
	}
}
