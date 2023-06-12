import 'package:get/get.dart';

import '../controllers/sitetouristiques_controller.dart';

class SitetouristiquesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SitetouristiquesController>(
      () => SitetouristiquesController(),
    );
  }
}
