import 'package:get/get.dart';

import '../controllers/debut_controller.dart';

class DebutBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DebutController>(
      () => DebutController(),
    );
  }
}
