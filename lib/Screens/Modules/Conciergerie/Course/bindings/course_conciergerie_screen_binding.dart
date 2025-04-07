import 'package:get/get.dart';
import 'package:jaime_yakro/Screens/Modules/Conciergerie/Course/path_course.dart';

class CourseConciergerieScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CourseConciergerieScreenController>(
        () => CourseConciergerieScreenController());
  }
}
