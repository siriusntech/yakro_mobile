import 'package:get/get.dart';

import '../controllers/bars_maquis_controller.dart';

class BarsMaquisBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BarsMaquisController>(
      () => BarsMaquisController(),
    );
  }
}
