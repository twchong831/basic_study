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
  String nonIpAddress = '0.0.0.0';
  String selIpAddress = '0.0.0.0';
  int portNum = 5000;
  bool isCheckedConnect = false;

  List<String> localIPList = [];

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
    setState(() {
      getNetworkInform();
    });
  }

  void onCheckedConnect() {
    setState(() {
      isCheckedConnect = !isCheckedConnect;
      if (isCheckedConnect) {
        // if (ipText.getData().isNotEmpty) {
        //   selIpAddress = ipText.getData();
        // }
        if (portText.getData().isNotEmpty) {
          portNum = int.parse(portText.getData());
        }
      }
    });

    if (isCheckedConnect) {
      print("IP/port : $selIpAddress / $portNum");
    }
  }

  void getNetworkInform() async {
    try {
      final list = await NetworkInterface.list(
        includeLoopback: true,
        type: InternetAddressType.IPv4,
      );
      setState(() {
        localIPList.clear();
        for (var i = 0; i < list.length; i++) {
          localIPList.add(list[i].addresses[0].address);
        }
      });
    } catch (e) {
      //exception
      localIPList.add(nonIpAddress);
    }
    // print("update ip List : $localIPList");
    // for (var i in localIPList) {
    //   print(i);
    // }
  }

  // generate dropdownMenuItem
  List<DropdownMenuItem<String>> generateIPMenu(List<String> list) {
    print('load generate menu Item');
    bool checked = false;
    late List<DropdownMenuItem<String>> l = [];

    if (list.isEmpty) {
      l.add(DropdownMenuItem(
        value: nonIpAddress,
        child: Text(nonIpAddress),
      ));
    } else {
      for (var i = 0; i < list.length; i++) {
        l.add(DropdownMenuItem(
          value: list[i],
          child: Text(list[i]),
        ));

        if (selIpAddress.isNotEmpty && (selIpAddress == list[i])) {
          checked = true;
        }
      }
    }

    setState(() {
      if (list.isEmpty) {
        selIpAddress = nonIpAddress;
      } else {
        if (!checked) {
          selIpAddress = list[0];
        }
      }
    });

    return l;
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
                  // child: ipText,
                  child: Column(
                    children: [
                      Container(
                        alignment: Alignment.bottomLeft,
                        child: const Text('IP Address'),
                      ),
                      DropdownButton(
                        // icon: const Icon(Icons.network_wifi_1_bar),
                        items: generateIPMenu(localIPList),
                        onChanged: (dynamic value) {
                          setState(() {
                            selIpAddress = value;
                          });
                        },
                        // hint: const Text('IP Address'),
                        value: selIpAddress,
                        isExpanded: true,
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: portText,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  // connect button
                  onPressed: onCheckedConnect,
                  icon: isCheckedConnect
                      ? const Icon(Icons.radio_button_on_rounded)
                      : const Icon(Icons.radio_button_off_rounded),
                  iconSize: 40,
                ),
                IconButton(
                  // ip address re-search
                  onPressed: getNetworkInform,
                  icon: const Icon(
                    Icons.refresh_outlined,
                  ),
                  iconSize: 40,
                )
              ],
            ),
            Text('SET : $selIpAddress $portNum'),
          ],
        ),
      ),
    );
  }
}
