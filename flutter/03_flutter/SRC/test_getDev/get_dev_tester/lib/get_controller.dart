import 'package:get/instance_manager.dart';
import 'package:get/state_manager.dart';

class CounterController extends GetxController {
  static CounterController get to => Get.find(); // what?

  var count = 0.obs;

  @override
  void onInit() {
    // once(count, (callback) {
    // print('once $callback 처음으로 변경됨');
    // });
    ever(count, (callback) => print('ever $callback 변경되었음'));
    // debounce(
    // count, (callback) => print('debounce $callback 변경된 후, 1초 간 변경이 없음'),
    // time: const Duration(seconds: 1));

    // interval(count, (callback) => print('interval $callback 변경되는 중(1초마다)'),
    // time: const Duration(seconds: 1));
    super.onInit();
  }

  void increase() {
    count++;
    if (count > 2) count.value = 0;
    update();
  }
}
