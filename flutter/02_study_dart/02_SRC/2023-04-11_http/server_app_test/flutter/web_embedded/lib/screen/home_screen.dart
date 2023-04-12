import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // variables====================================
  // hello button response
  String helloResponse = 'None-response';
  // ip&port button reponse
  String ipResponse = 'None-response';

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
          )
        ],
      ),
    );
  }
}
