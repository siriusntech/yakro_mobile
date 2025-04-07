import 'package:get/get.dart';

class CommerceSingleScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CommerceSingleScreenBinding>(
        () => CommerceSingleScreenBinding());
  }
}
