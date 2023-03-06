import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:get/route_manager.dart';
import 'package:get/state_manager.dart';

void main() {
  runApp(const GetMaterialApp(
    home: Home(),
  ));
}

class Controller extends GetxController {
  int count = 0;
  // increment() => count++;
  void increase() {
    count++;
    update();
  }
}

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(Controller()); // 컨트롤러 등록
    return Scaffold(
      appBar: AppBar(
        title: const Text('Simple State'),
      ),
      body: Center(
        child: GetBuilder<Controller>(
          builder: (controller) {
            return ElevatedButton(
              onPressed: () {
                controller.increase();
              },
              child: Text('count : ${controller.count}'),
            );
          },
        ),
      ),
    );
  }
}
