import 'package:get/get.dart';

import '../path_hotel.dart';

class HotelScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HotelScreenController>(() => HotelScreenController());
  }
}
