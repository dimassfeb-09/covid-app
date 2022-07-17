import 'package:get/get.dart';

import '../controllers/hotline_controller.dart';

class HotlineBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HotlineController>(
      () => HotlineController(),
    );
  }
}
