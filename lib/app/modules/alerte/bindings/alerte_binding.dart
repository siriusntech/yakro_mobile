import 'package:get/get.dart';

import '../controllers/alerte_controller.dart';

class AlerteBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AlerteController>(
      () => AlerteController(),
    );
  }
}
