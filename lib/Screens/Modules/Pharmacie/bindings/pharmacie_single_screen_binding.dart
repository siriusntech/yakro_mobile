import 'package:jaime_yakro/Screens/Modules/Pharmacie/path_pharmacie.dart';
import 'package:get/get.dart';

class PharmacieSingleScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PharmacieSingleScreenController>(
        () => PharmacieSingleScreenController());
  }
}
