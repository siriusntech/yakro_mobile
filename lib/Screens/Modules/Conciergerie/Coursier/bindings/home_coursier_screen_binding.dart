
import 'package:get/get.dart';

import '../path_coursier.dart';

class HomeCoursierScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeCoursierScreenController>(() => HomeCoursierScreenController());
  }
}