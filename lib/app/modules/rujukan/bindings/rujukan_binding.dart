import 'package:get/get.dart';

import '../controllers/rujukan_controller.dart';

class RujukanBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RujukanController>(
      () => RujukanController(),
    );
  }
}
