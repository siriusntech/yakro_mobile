import 'package:get/get.dart';
import 'package:jaime_yakro/Providers/path_providers.dart';

import '../path_home.dart';

class HomeScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeScreenController>(() => HomeScreenController());
    Get.lazyPut<ModuleController>(() => ModuleController());
  }
}
