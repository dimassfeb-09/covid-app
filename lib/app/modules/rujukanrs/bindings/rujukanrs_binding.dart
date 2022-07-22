import 'package:get/get.dart';

import '../controllers/rujukanrs_controller.dart';

class RujukanrsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RujukanrsController>(
      () => RujukanrsController(),
    );
  }
}
