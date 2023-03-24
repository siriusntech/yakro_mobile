import 'package:get/get.dart';

import '../controllers/cocan_controller.dart';

class CocanBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CocanController>(
      () => CocanController(),
    );
  }
}
