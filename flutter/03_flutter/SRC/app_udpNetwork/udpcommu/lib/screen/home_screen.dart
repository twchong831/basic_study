import 'dart:io';

import 'package:flutter/material.dart';
import 'package:udpcommu/widgets/text_editor_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String ipAddress = '127.0.0.1';
  int portNum = 5000;
  bool isCheckedConnect = false;

  // final double minWidth = 500;
  // final double minHight = 100;

  WidgetTextField ipText = WidgetTextField(
    label: 'IP Address',
    hint: 'xxx.xxx.xxx.xxx',
  );
  WidgetTextField portText = WidgetTextField(
    label: 'Port Num.',
    hint: '5000',
    onlyNum: true,
  );

  @override
  void initState() {
    super.initState();
  }

  //network information
  void getNetworkInform() async {
    // get network information
    // it activates in macOS simulator
    print("pushed [getNetworkInform] ${NetworkInterface.list()}");

    for (var ifc in await NetworkInterface.list()) {
      print('== Interface : ${ifc.name} ==');
      for (var addr in ifc.addresses) {
        print(
            '${addr.address} ${addr.host} ${addr.isLoopback} ${addr.rawAddress} ${addr.type.name}');
      }
    }
  }

  void onCheckedConnect() {
    setState(() {
      isCheckedConnect = !isCheckedConnect;
      if (isCheckedConnect) {
        if (ipText.getData().isNotEmpty) {
          ipAddress = ipText.getData();
        }
        if (portText.getData().isNotEmpty) {
          portNum = int.parse(portText.getData());
        }
      }
    });

    if (isCheckedConnect) {
      print("IP/port : $ipAddress / $portNum");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('UDP test'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: ipText,
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: portText,
                ),
              ],
            ),
            Column(
              children: [
                IconButton(
                  onPressed: onCheckedConnect,
                  icon: isCheckedConnect
                      ? const Icon(Icons.radio_button_on_rounded)
                      : const Icon(Icons.radio_button_off_rounded),
                  iconSize: 40,
                ),
                IconButton(
                  onPressed: getNetworkInform,
                  icon: const Icon(
                    Icons.refresh_outlined,
                  ),
                )
              ],
            ),
            Text('SET : $ipAddress $portNum'),
          ],
        ),
      ),
    );
  }
}
