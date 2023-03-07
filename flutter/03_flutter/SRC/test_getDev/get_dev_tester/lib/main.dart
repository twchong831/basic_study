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
    print(count);
    update();
  }
}

class ReactiveController extends GetxController {
  static ReactiveController get to => Get.find(); // what?
  RxInt counter = 0.obs;

  @override
  void onInit() {
    once(counter, (callback) {
      print('once $callback 처음으로 변경됨');
    });
    ever(counter, (callback) => print('ever $callback 변경되었음'));
    debounce(
        counter, (callback) => print('debounce $callback 변경된 후, 1초 간 변경이 없음'),
        time: const Duration(seconds: 1));

    interval(counter, (callback) => print('interval $callback 변경되는 중(1초마다)'),
        time: const Duration(seconds: 1));
    super.onInit();
  }

  increase() => counter++;
}

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(Controller()); // 컨트롤러 등록
    Get.put(ReactiveController()); // 반응형 상태관리 controller 등록
    return Scaffold(
      appBar: AppBar(
        title: const Text('Simple/Reactive State'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GetBuilder<Controller>(
              builder: (controller) {
                return ElevatedButton(
                  onPressed: () {
                    controller.increase();
                  },
                  child: Text('count : ${controller.count}'),
                );
              },
            ),
            const SizedBox(
              height: 10,
            ),
            GetX<ReactiveController>(
              builder: (controller) {
                return ElevatedButton(
                    onPressed: () {
                      controller.increase();
                    },
                    child: Text("reactive 1 : ${controller.counter.value}"));
              },
            ),
            const SizedBox(
              height: 10,
            ),
            Obx(
              () {
                return ElevatedButton(
                  onPressed: () {
                    // Get.find<ReactiveController>().increase();
                    ReactiveController.to.increase();
                  },
                  child: Text(
                      'reative 2 : ${Get.find<ReactiveController>().counter.value}'),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
