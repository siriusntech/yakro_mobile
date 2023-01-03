import 'package:get/get.dart';

import '../controllers/apropos_controller.dart';

class AproposBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AproposController>(
      () => AproposController(),
    );
  }
}
