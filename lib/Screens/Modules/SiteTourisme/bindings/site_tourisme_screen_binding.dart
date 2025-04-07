import 'package:get/get.dart';
import 'package:jaime_yakro/Screens/Modules/SiteTourisme/path_tourisme.dart';

class SiteTourismeScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SiteTourismeScreenController>(
        () => SiteTourismeScreenController());
  }
}
