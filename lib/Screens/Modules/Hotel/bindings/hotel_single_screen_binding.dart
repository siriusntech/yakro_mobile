import 'package:get/get.dart';

import '../path_hotel.dart';

class HotelSingleScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HotelSingleScreenController>(
        () => HotelSingleScreenController());
  }
}
