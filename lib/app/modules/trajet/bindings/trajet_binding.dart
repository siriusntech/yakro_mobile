import 'package:get/get.dart';

import '../controllers/trajet_controller.dart';

class TrajetBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TrajetController>(
      () => TrajetController(),
    );
  }
}
