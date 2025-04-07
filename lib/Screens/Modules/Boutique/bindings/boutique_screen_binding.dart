import 'package:jaime_yakro/Screens/Modules/Boutique/path_boutique.dart';
import 'package:get/get.dart';

class BoutiqueScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BoutiqueScreenController>(() => BoutiqueScreenController());
  }
}
