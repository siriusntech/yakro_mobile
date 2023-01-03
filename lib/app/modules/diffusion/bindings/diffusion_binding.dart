import 'package:get/get.dart';

import '../controllers/diffusion_controller.dart';

class DiffusionBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DiffusionController>(
      () => DiffusionController(),
    );
  }
}
