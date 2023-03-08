import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_dev_tester/get_controller.dart';
import 'package:get_dev_tester/widget_new.dart';

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

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // int counter = 0;
  final CounterController counterCon = Get.put(CounterController());

  // late MyWidget mWidget;

  bool checkedTimer = false;
  var settedValue = 0;

  // timer
  late Timer gTimer;

  void _timerPlayer(Timer timer) {
    print('timer Tick ${timer.tick} : ${counterCon.count.value}');
    // counter++;
    counterCon.increase();
  }

  void _activeTimer() {
    if (!checkedTimer) {
      gTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
        _timerPlayer(timer);
        checkedTimer = true;
      });
    } else {
      _cancelTimer();
      _activeTimer();
    }
  }

  void _cancelTimer() {
    print('cancel Timer');
    checkedTimer = false;
    gTimer.cancel();
  }

  void setValue(var i) {
    setState(() {
      settedValue = i;
    });
  }

  _setMyWidget(
    BuildContext context, {
    required int counts,
  }) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MyWidget(
          value: counts,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Get.put(Controller()); // 컨트롤러 등록
    Get.put(ReactiveController()); // 반응형 상태관리 controller 등록
    Get.put(CounterController());
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
                    'reative 2 : ${Get.find<ReactiveController>().counter.value}',
                  ),
                );
              },
            ),
            const SizedBox(
              height: 10,
            ),
            // GetX<CounterController>(builder: (controller) {
            //   return TextButton(
            //     onPressed: () async {
            //       _activeTimer();
            //       RxInt re = await Get.to(
            //         MyWidget(value: controller.count.value),
            //         arguments: controller.count,
            //       );
            //       // controller.increase();
            //       setState(() {
            //         settedValue = re.value;
            //         _cancelTimer();
            //         // print('now controll value : ${controller.count.value}');
            //       });
            //     },
            //     child: Text('${controller.count.value}'),
            //     // child: const Text('test1'),
            //   );
            // }),
            Obx(() {
              return TextButton(
                onPressed: () async {
                  _activeTimer();
                  RxInt re = await Get.to(
                    MyWidget(value: Get.find<CounterController>().count.value),
                    arguments: Get.find<CounterController>().count,
                  );
                  // controller.increase();
                  setState(() {
                    settedValue = re.value;
                    _cancelTimer();
                    // print('now controll value : ${controller.count.value}');
                  });
                },
                child: Text('${Get.find<CounterController>().count.value}'),
                // child: const Text('test1'),
              );
            }),
            Text('value change : $settedValue'),
          ],
        ),
      ),
    );
  }
}
