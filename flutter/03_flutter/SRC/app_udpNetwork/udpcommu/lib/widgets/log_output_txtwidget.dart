import 'dart:io';

import 'package:flutter/material.dart';
import 'package:udp/udp.dart';

class LogOutputWidget extends StatefulWidget {
  const LogOutputWidget({
    super.key,
    required this.selIpAddress,
    required this.portNum,
  });

  final String selIpAddress;
  final int portNum;

  @override
  State<LogOutputWidget> createState() => _LogOutputWidgetState();
}

class _LogOutputWidgetState extends State<LogOutputWidget> {
  UDP? recv;

  @override
  void dispose() {
    // page close
    if (recv != null && !recv!.closed) {
      recv!.close();
    }
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    // print('init');
    connectUDP();

    setState(() {
      // }
    });
  }

  void connectUDP() async {
    // print('connect udp');
    recv = await UDP.bind(Endpoint.unicast(InternetAddress(widget.selIpAddress),
        port: Port(widget.portNum)));

    print(recv!.socket!.address);
    // print('connect udp end');

    setState(() {
      // if (widget.recv != null) {
      recv?.asStream().listen((event) {
        if (event != null) {
          print('${event.data.length}');
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('input log'),
      ),
      body: Text(
        'IP : ${widget.selIpAddress} & port : ${widget.portNum}',
      ),
    );
  }
}
