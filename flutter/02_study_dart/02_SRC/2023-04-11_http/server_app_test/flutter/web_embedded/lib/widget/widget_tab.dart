import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_toggle_tab/flutter_toggle_tab.dart';

class NetworkTabWidget extends StatefulWidget {
  final List<Map<String, dynamic>> _json;

  NetworkTabWidget({
    super.key,
    List<Map<String, dynamic>>? json,
  }) : _json = json ??
            [
              {'name': 'none', 'ip': 'none'},
              // {'name': 'none2', 'ip': 'none2'},
              // {'name': 'none2', 'ip': 'none2'},
              // {'name': 'none2', 'ip': 'none2'},
            ];

  @override
  State<NetworkTabWidget> createState() => _NetworkTabWidgetState();
}

class _NetworkTabWidgetState extends State<NetworkTabWidget> {
  var _tabSelectIndex = 0;
  List<String> nameList = [];
  String selectIP = '';
  String selectName = '';

  List listJson = [];

  @override
  void initState() {
    super.initState();

    var jsonConvert = jsonEncode(widget._json);

    listJson = jsonDecode(jsonConvert);
    if (listJson.length == 1) {
      listJson.add({'name': 'none', 'ip': '127.0.0.1'});
    }

    for (var i in listJson) {
      nameList.add(i['name']);
    }
    print('size : ${nameList.length}');

    selectIP = listJson[0]['ip'];
    selectName = listJson[0]['name'];
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          const Text('Network Information'),
          FlutterToggleTab(
            width: 90,
            borderRadius: 30,
            selectedBackgroundColors: const [Colors.blue, Colors.blueAccent],
            labels: nameList,
            selectedLabelIndex: (index) {
              setState(() {
                _tabSelectIndex = index;
                // ip
                selectIP = listJson[index]['ip'];
                // name
                selectName = listJson[index]['name'];
              });
            },
            selectedTextStyle: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w700,
            ),
            unSelectedTextStyle: const TextStyle(
              color: Colors.black87,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
            selectedIndex: _tabSelectIndex,
          ),
          Text('tab change $_tabSelectIndex : $selectIP, $selectName'),
        ],
      ),
    );
  }
}
