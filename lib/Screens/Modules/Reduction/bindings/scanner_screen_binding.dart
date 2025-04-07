
import 'package:get/get.dart';
import 'package:jaime_yakro/Screens/Modules/Reduction/reduction_path.dart';

class ScannerScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ScannerScreenController>(() => ScannerScreenController());
  }
}
