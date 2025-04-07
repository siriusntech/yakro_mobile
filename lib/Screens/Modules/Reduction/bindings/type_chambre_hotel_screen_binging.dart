import 'package:get/get.dart';
import 'package:jaime_yakro/Screens/Modules/Reduction/reduction_path.dart';

class TypeChambreHotelScreenBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<TypeChambreHotelScreenController>(() => TypeChambreHotelScreenController());
  }
}