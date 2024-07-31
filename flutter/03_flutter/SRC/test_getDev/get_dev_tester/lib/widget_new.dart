import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:get/route_manager.dart';
import 'package:get_dev_tester/get_controller.dart';

class MyWidget extends StatefulWidget {
  // final CounterController counter = Get.find();
  // final CounterController controll;
  final int value;

  const MyWidget({
    super.key,
    required this.value,
  });

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  final CounterController counterCon = Get.find();

  dynamic argValue;

  @override
  void initState() {
    // TODO: implement initState
    print('widget1 check ${widget.value}');
    print('widget2 check ${counterCon.count.value}');

    print(counterCon.listeners);

    argValue = Get.arguments;
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    print('[widget] before pop input ${widget.value}');
    print('[widget] before pop controller counter ${counterCon.count.value}');
    print('[widget] before pop argv $argValue');
    Get.back(result: argValue);
    super.dispose();
  }

  void update() {
    setState(() {
      argValue = Get.arguments;
    });
  }

  @override
  Widget build(BuildContext context) {
    // final mControll = Get.put(widget.controll);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Counter Up'),
        leading: IconButton(
          icon: const Icon(Icons.back_hand),
          onPressed: () {
            Get.back(result: argValue);
          },
        ),
      ),
      body: Column(
        children: [
          Text("count? input : ${widget.value}"),
          Text('controller : ${counterCon.count.value}'),
          Text('argument val : $argValue'),
        ],
      ),
    );
  }
}
