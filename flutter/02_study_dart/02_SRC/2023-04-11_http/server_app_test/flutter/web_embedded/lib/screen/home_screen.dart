import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:web_embedded/widget/widget_tab.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // variables====================================
  // hello button response
  String helloResponse = 'None-response';
  // ip&port button response
  String ipResponse = 'None-response';
  // ip search button response
  String ipSearchResponse = 'None-response';
  String networkJson = '';

  bool checkIpListUpdate = false;

  // communication http server
  final dio = Dio();

  // !variables===================================

  // defined FUNC.================================
  // !defined FUNC.===============================

  // based FUNC.==================================
  @override
  void initState() {
    super.initState();
  }
  // !based FUNC.=================================

  // build========================================
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kanavi-mobility DCU'),
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: TextButton(
                  style: TextButton.styleFrom(
                    // padding: const EdgeInsets.all(30),
                    shadowColor: Colors.black,
                    backgroundColor: Colors.red,
                    shape: const BeveledRectangleBorder(
                      side: BorderSide(
                        color: Colors.black,
                        width: 2,
                      ),
                    ),
                    alignment: Alignment.center,
                  ),
                  onPressed: () async {
                    Response respon = await dio.get('/helloworld');
                    // print(respon);
                    setState(() {
                      helloResponse = '$respon';
                    });
                  },
                  child: const Center(
                    // height: 100,
                    heightFactor: 2.0,
                    child: Text(
                      '[Hello World!] Button',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 40,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(30)),
                    border: Border.all(
                      color: Colors.black,
                    ),
                  ),
                  height: 100,
                  alignment: Alignment.center,
                  child: Text(
                    helloResponse,
                    style: const TextStyle(
                      fontSize: 30,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: TextButton(
                  style: TextButton.styleFrom(
                    // padding: const EdgeInsets.all(30),
                    shadowColor: Colors.black,
                    backgroundColor: Colors.amber,
                    shape: const BeveledRectangleBorder(
                      side: BorderSide(
                        color: Colors.black,
                        width: 2,
                      ),
                    ),
                    alignment: Alignment.center,
                  ),
                  onPressed: () async {
                    Response respon = await dio.get('/ipport');
                    // print(respon);
                    setState(() {
                      ipResponse = '$respon';
                    });
                  },
                  child: const Center(
                    heightFactor: 2.0,
                    child: Text(
                      'get IP&PORT Button',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 40,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                width: 15,
              ),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(30)),
                    border: Border.all(
                      color: Colors.black,
                    ),
                  ),
                  height: 100,
                  alignment: Alignment.center,
                  child: Text(
                    ipResponse,
                    style: const TextStyle(
                      fontSize: 30,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: TextButton(
                  style: TextButton.styleFrom(
                    // padding: const EdgeInsets.all(30),
                    shadowColor: Colors.black,
                    backgroundColor: Colors.amber,
                    shape: const BeveledRectangleBorder(
                      side: BorderSide(
                        color: Colors.black,
                        width: 2,
                      ),
                    ),
                    alignment: Alignment.center,
                  ),
                  onPressed: () async {
                    Response respon = await dio.get(
                      '/ipSearch',
                    );
                    setState(() {
                      // response OK
                      ipSearchResponse = '$respon';

                      //test
                      ipSearchResponse =
                          '[{"name": "lo", "ip": "127.0.0.1"},{"name": "wlp3s0", "ip": "10.26.248.7"},{"name": "docker0", "ip": "172.17.0.1"}]';

                      networkJson =
                          '[{"name": "lo", "ip": "127.0.0.1"},{"name": "wlp3s0", "ip": "10.26.248.7"},{"name": "docker0", "ip": "172.17.0.1"}]';

                      checkIpListUpdate = true;
                    });
                  },
                  child: const Center(
                    heightFactor: 2.0,
                    child: Text(
                      'IP Search Button',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 30,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                width: 15,
              ),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(30)),
                    border: Border.all(
                      color: Colors.black,
                    ),
                  ),
                  height: 100,
                  alignment: Alignment.center,
                  child: Text(
                    ipSearchResponse,
                    style: const TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
            ],
          ),
          NetworkTabWidget(
            // json: ipSearchResponse,
            json: networkJson,
          ),
        ],
      ),
    );
  }
}
