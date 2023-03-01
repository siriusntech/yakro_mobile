import 'package:get/get.dart';

import '../controllers/zoom_controller.dart';

class ZoomBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ZoomController>(
      () => ZoomController(),
    );
  }
}
