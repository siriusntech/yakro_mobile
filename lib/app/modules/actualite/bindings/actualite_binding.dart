import 'package:get/get.dart';

import '../controllers/actualite_controller.dart';

class ActualiteBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ActualiteController>(
      () => ActualiteController(),
    );
  }
}
