import 'dart:convert';

import 'package:flutter/material.dart';

class NetworkTabWidget extends StatefulWidget {
  final List<Map<String, dynamic>> _json;

  NetworkTabWidget({
    super.key,
    List<Map<String, dynamic>>? json,
  }) : _json = json ??
            [
              {'name': 'none', 'ip': 'none'},
              {'name': 'none2', 'ip': 'none2'},
              // {'name': 'none2', 'ip': 'none2'},
              // {'name': 'none2', 'ip': 'none2'},
            ];

  @override
  State<NetworkTabWidget> createState() => _NetworkTabWidgetState();
}

class _NetworkTabWidgetState extends State<NetworkTabWidget>
    with TickerProviderStateMixin {
  // tabContainer controller
  late final TabController _tabController;

  int _tabSelectIndex = 0;
  List<String> nameList = [];
  String selectIP = '';
  String selectName = '';

  List listJson = [];

  tabMaker() {
    List<Tab> tabs = [];
    for (var i in listJson) {
      tabs.add(Tab(
        text: i['name'],
      ));
    }
    return tabs;
  }

  List<Widget> tabViewMaker() {
    List<Widget> tabs = [];

    for (var i in listJson) {
      tabs.add(
        Container(
          child: Column(
            children: [
              Row(
                children: [
                  const Text('Name'),
                  Text(i['name']),
                ],
              ),
              Row(
                children: [
                  const Text('IP'),
                  Text(i['ip']),
                ],
              ),
            ],
          ),
        ),
      );
    }
    return tabs;
  }

  @override
  void initState() {
    super.initState();

    var jsonConvert = jsonEncode(widget._json);

    listJson = jsonDecode(jsonConvert);

    for (var i in listJson) {
      nameList.add(i['name']);
    }

    selectIP = listJson[0]['ip'];
    selectName = listJson[0]['name'];

    _tabController = TabController(
      initialIndex: 0,
      length: nameList.length,
      vsync: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              border: Border.all(),
            ),
            child: TabBar(
              controller: _tabController,
              indicatorColor: Colors.red,
              labelColor: Colors.black,
              onTap: (value) {
                setState(() {
                  _tabSelectIndex = value;
                });
              },
              tabs: tabMaker(),
            ),
          ),
          // const Text('te'),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: tabViewMaker(),
            ),
          ),
        ],
      ),
    );
  }
}
