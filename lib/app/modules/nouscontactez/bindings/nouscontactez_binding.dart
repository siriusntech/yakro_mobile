import 'package:get/get.dart';

import '../controllers/nouscontactez_controller.dart';

class NouscontactezBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NouscontactezController>(
      () => NouscontactezController(),
    );
  }
}
