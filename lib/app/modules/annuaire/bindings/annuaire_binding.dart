import 'package:get/get.dart';

import '../controllers/annuaire_controller.dart';

class AnnuaireBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AnnuaireController>(
      () => AnnuaireController(),
    );
  }
}
