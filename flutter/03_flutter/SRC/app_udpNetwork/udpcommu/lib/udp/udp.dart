import 'dart:io';

import 'package:udp/udp.dart';

class UdpCommunication {
  /*
  late String lIp;
  late int lPort;

  late Datagram? udpInputDatagram;

  // UdpCommunication();
  UdpCommunication();

  late Future<RawDatagramSocket> lSocket;

  void init({
    required String ip,
    required int port,
  }) {
    lIp = ip;
    lPort = port;

    lSocket = RawDatagramSocket.bind(InternetAddress(lIp), lPort);
    print('Init Udp : $lIp $lPort');
  }

  void binding() {
    if (!lSocket.hashCode.isNaN) {
      lSocket.then((RawDatagramSocket socket) {
        socket.listen((RawSocketEvent event) {
          udpInputDatagram = socket.receive();
        });
      });
    }
  }*/

  late String lIP;
  late int lPort;

  UdpCommunication({
    required this.lIP,
    required this.lPort,
  });

  late Future<UDP> mUDP;

  void bind() {
    mUDP = UDP.bind(Endpoint.unicast(InternetAddress(lIP), port: Port(lPort)));
  }

  Datagram? getData() {
    return null;
  }
}
