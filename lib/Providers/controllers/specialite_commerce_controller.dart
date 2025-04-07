import 'package:get/get.dart';
import 'package:jaime_yakro/Providers/path_providers.dart';

class SpecialiteCommerceController extends GetxController {
  RxBool specialiteLoading = false.obs;
  RxList<SpecialiteCommerceModel> listSpecialiteCommerce =
      RxList<SpecialiteCommerceModel>([]);

  final SpecialiteCommerceService _specialiteFindService =
      SpecialiteCommerceService();

  @override
  void onInit() {
    _specialiteFindService.onInit();
    getAllSpecialiteFind();
    super.onInit();
  }

  //get all specialite
  getAllSpecialiteFind() async {
    // print("==============GET ALL SPECIALITE==============");
    specialiteLoading.value = true;
    try {
      final response = await _specialiteFindService.getAllSpecialite();
      // print(response.body);
      if (response.statusCode == 200) {
        listSpecialiteCommerce.value = response.body!;
        specialiteLoading.value = false;
      } else {
        specialiteLoading.value = false;
      }
    } catch (e) {
      specialiteLoading.value = false;
    }
  }
}
