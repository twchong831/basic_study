import 'dart:convert';

import 'package:flutter/material.dart';

const String staticJson =
    '[{"name": "none", "ip": "none"}, {"name": "none2", "ip": "none2"}]';

class NetworkTabWidget extends StatefulWidget {
  // final List _json;
  final String jSon;

  const NetworkTabWidget({
    super.key,
    String? json,
  }) : jSon = json ?? staticJson;

  @override
  State<NetworkTabWidget> createState() => _NetworkTabWidgetState();
}

class _NetworkTabWidgetState extends State<NetworkTabWidget>
    with TickerProviderStateMixin {
  // tabContainer controller
  late final TabController _tabController;

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

  List<Widget> tabViewMaker(List json) {
    List<Widget> tabs = [];

    print('make widget $json');
    for (var i in json) {
      tabs.add(
        Container(
          child: Column(
            children: [
              Row(
                children: [
                  const Text('Name'),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(i['name']),
                ],
              ),
              Row(
                children: [
                  const Text('IP'),
                  const SizedBox(
                    width: 10,
                  ),
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

  // udpate List
  void updateList() {
    try {
      listJson = jsonDecode(widget.jSon);
    } catch (e) {
      listJson = jsonDecode(staticJson);
    }

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
  void initState() {
    super.initState();
    print('init...[widget_tab]');
    updateList();
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
                  print(listJson[value]);
                });
              },
              tabs: tabMaker(),
            ),
          ),
          // const Text('te'),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: tabViewMaker(listJson),
            ),
          ),
        ],
      ),
    );
  }
}
