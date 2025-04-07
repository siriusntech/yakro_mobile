import 'package:get/get.dart';
import 'package:jaime_yakro/Providers/path_providers.dart';

class TypeHotelController extends GetxController {
  RxBool typeHotelLoading = false.obs;
  Rx<List<TypeHotelModel>> typeHotelsList = Rx<List<TypeHotelModel>>([]);

  final TypeHotelService typeHotelService = TypeHotelService();

  TypeHotelModel typeHotelModel = TypeHotelModel();

  @override
  void onInit() {
    typeHotelService.onInit();
    getAllTypeHotel();
    super.onInit();
  }

  //Get All Type Hotel
  Future<void> getAllTypeHotel() async {
    typeHotelLoading(true);
    try {
      // print("==============TYPE HOTELS==============");
      final response = await typeHotelService.getAllTypeHotel();
      // print(response.body);
      if (response.statusCode == 200) {
        typeHotelsList.value = response.body!;
        typeHotelLoading(false);
      } else {
        typeHotelLoading(false);
      }
    } catch (e) {
      typeHotelLoading(false);
    }
  }

  // void changeTypeHotel(TypeHotelModel typeHotelModel) {
  //   this.typeHotelModel = typeHotelModel;
  //   update();
  // }
}
