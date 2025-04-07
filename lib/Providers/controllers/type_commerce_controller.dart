import 'package:get/get.dart';
import 'package:jaime_yakro/Providers/path_providers.dart';

class TypeCommerceController extends GetxController {
  RxBool typeCommerceLoading = true.obs;
  RxList<TypeCommerceModel> listTypeCommerce = RxList<TypeCommerceModel>([]);

  final typeCommerceService = TypeCommerceService();

  TypeCommerceModel selectedTypeCommerce = TypeCommerceModel();

  @override
  void onInit() {
    super.onInit();
    typeCommerceService.onInit();
    getTypesCommerce();
  }

  //get all types commerce
  getTypesCommerce() async {
    typeCommerceLoading.value = true;
    try {
      final response = await typeCommerceService.getAllTypeCommerce();
      if (response.statusCode == 200) {
        listTypeCommerce.value = response.body!;
        typeCommerceLoading.value = false;
      } else {
        typeCommerceLoading.value = false;
      }
    } catch (e) {
      typeCommerceLoading.value = false;
    }
  }
}
