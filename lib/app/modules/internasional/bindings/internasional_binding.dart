import 'package:get/get.dart';

import '../controllers/internasional_controller.dart';

class InternasionalBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<InternasionalController>(
      () => InternasionalController(),
    );
  }
}
