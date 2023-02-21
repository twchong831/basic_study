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
  String ipAddress = '';
  int portNum = 5000;
  bool isCheckedConnect = false;

  List localIPList = [
    '0.0.0.0',
  ];

  final List basicList = [
    '0,0,0,0',
  ];

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

  void getNetworkInform() async {
    try {
      final list = await NetworkInterface.list(
        includeLoopback: true,
        type: InternetAddressType.IPv4,
      );
      setState(() {
        localIPList.clear();
        localIPList.clear();
        for (var i = 0; i < list.length; i++) {
          // print(list[i].name);
          // print(list[i].addresses[0].address);
          localIPList.add("${list[i].name} : ${list[i].addresses[0].address}");
        }
      });
    } catch (e) {
      //exception
      localIPList.add("0.0.0.0");
    }
    print("update ip List : $localIPList");
    for (var i in localIPList) {
      print(i);
    }
  }

  void onDropBoxChanged() {
    print('dropbox changed');
  }

  List<DropdownMenuItem<Object?>> buildDropdownItems(
    List items,
  ) {
    print('input items Size : ${items.length}');

    List<DropdownMenuItem<Object?>> list = [];

    for (int i = 0; i < items.length; i++) {
      list.add(
        DropdownMenuItem(
          value: i,
          child: Text(items[i]),
        ),
      );
    }
    return list;
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
                  child: DropdownButton(
                    value: ipAddress.isNotEmpty ? ipAddress : "0.0.0.0",
                    // items: localIPList.map(
                    //   (String item) {
                    //     return DropdownMenuItem<String>(
                    //       value: item,
                    //       child: Text(item),
                    //     );
                    //   },
                    // ).toList(),
                    // items: DropdownMenuItem(localIPList),

                    items: buildDropdownItems(localIPList).isNotEmpty
                        ? buildDropdownItems(localIPList).toList()
                        : buildDropdownItems(basicList).toList(),
                    onChanged: (dynamic value) {
                      setState(
                        () {
                          ipAddress = value;
                        },
                      );
                    },
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
                  iconSize: 40,
                )
              ],
            ),
            Text('SET : $ipAddress $portNum'),
            Text(
              'local? : $localIPList',
            ),
          ],
        ),
      ),
    );
  }
}
