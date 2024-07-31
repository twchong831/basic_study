#ifndef MAINWINDOW_H
#define MAINWINDOW_H

#include <QMainWindow>
#include "udp.h"

QT_BEGIN_NAMESPACE
namespace Ui { class MainWindow; }
QT_END_NAMESPACE

class MainWindow : public QMainWindow
{
	Q_OBJECT

public:
	MainWindow(QWidget *parent = nullptr);
	~MainWindow();

public slots:
	void getDatagram(QByteArray buf);

private slots:
	void on_pushButton_connect_clicked(bool checked);

private:
	Ui::MainWindow *ui;

	udp *m_udp;

	int g_inputCnt;
};
#endif // MAINWINDOW_H
