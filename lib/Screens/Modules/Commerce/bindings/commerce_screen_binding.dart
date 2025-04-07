import 'package:get/get.dart';
import 'package:jaime_yakro/Screens/Modules/Commerce/path_commerce.dart';

class CommerceScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CommerceScreenController>(() => CommerceScreenController());
  }
}
