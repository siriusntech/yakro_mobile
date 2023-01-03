import 'package:get/get.dart';

import '../controllers/pharmacie_controller.dart';

class PharmacieBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PharmacieController>(
      () => PharmacieController(),
    );
  }
}
