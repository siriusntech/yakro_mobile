import 'package:get/get.dart';
import 'package:jaime_yakro/Providers/path_providers.dart';

class CategorieVtApiController extends GetxController {
  RxBool categorieVTLoading = false.obs;
  Rx<List<CategorieVtModel>> categorieVTList = Rx<List<CategorieVtModel>>([]);

  final CategorieVtService _categorieVtService = CategorieVtService();

  CategorieVtModel categorieVtModel = CategorieVtModel();

  @override
  void onInit() {
    _categorieVtService.onInit();
    getAllCategorieVT();
    super.onInit();
  }

  //Get All Type Hotel
  Future<void> getAllCategorieVT() async {
    categorieVTLoading(true);
    try {
      // print("==============TYPE HOTELS==============");
      final response = await _categorieVtService.getAllCategorieVt();
      // print(response.body);
      if (response.statusCode == 200) {
        categorieVTList.value = response.body!;
        categorieVTLoading(false);
      } else {
        categorieVTLoading(false);
      }
    } catch (e) {
      categorieVTLoading(false);
    }
  }

  @override
  void onReady() {
    getAllCategorieVT();
    super.onReady();
  }

  @override
  void onClose() {
    _categorieVtService.onClose();
    super.onClose();
  }

  // void changeTypeHotel(TypeHotelModel typeHotelModel) {
  //   this.typeHotelModel = typeHotelModel;
  //   update();
  // }
}
