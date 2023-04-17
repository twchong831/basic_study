import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:web_embedded/data/json_network_model.dart';

const String staticJson =
    '[{"name": "none", "ip": "none"}, {"name": "none2", "ip": "none2"}]';

class NetworkTabWidget extends StatefulWidget {
  // final List _json;
  // final String jSon;
  List<JsonNetworkModel> model;

  NetworkTabWidget({
    super.key,
    // String? json,
    required this.model,
  }) /*: jSon = json ?? staticJson*/;

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
    // print(' input ? ${widget.jSon}');
    for (var i in listJson) {
      tabs.add(Tab(
        text: i['name'],
      ));
    }
    return tabs;
  }

  List<Widget> tabViewMaker(List json) {
    List<Widget> tabs = [];

    for (var i in json) {
      tabs.add(
        Column(
          children: [
            Row(
              children: [
                Container(
                  color: Colors.red,
                  child: const Text(
                    'Name',
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: TextField(
                    readOnly: true,
                    controller: TextEditingController(
                      text: i['name'],
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                const Text('IP'),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: TextField(
                    controller: TextEditingController(
                      text: i['ip'],
                    ),
                    onChanged: (value) {
                      setState(() {
                        i['ip'] = value;
                      });
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    }
    return tabs;
  }

  // udpate List
  void updateList() {
    if (widget.model.isNotEmpty) {
      for (var i in widget.model) {
        listJson.add({'name': i.name, 'ip': i.ip});
      }
    } else {
      listJson = jsonDecode(staticJson);
    }

    nameList.clear();
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
                setState(() {});
              },
              tabs: tabMaker(),
            ),
          ),
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
