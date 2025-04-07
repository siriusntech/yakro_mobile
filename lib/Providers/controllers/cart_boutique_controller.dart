import 'package:get/get.dart';
import 'package:jaime_yakro/Providers/path_providers.dart';
// import 'package:jaime_yakro/Providers/path_providers.dart';

class CartBoutiqueController extends GetxController {
  final MainController mainController = Get.find();
  final RxBool cartSuccess = RxBool(false);
  // final CartScreenController cartScreenController = Get.find();
  final CartBoutiqueService _cartBoutiqueService = CartBoutiqueService();
  final Rx<Map<String, dynamic>> cart = Rx<Map<String, dynamic>>({});
  final RxString cartOrderNumber = ''.obs;
  @override
  void onInit() {
    mainController.onInit();
    _cartBoutiqueService.onInit();
    super.onInit();
  }

  //Add cart in Api
  Future<void> addCart(List<CartBoutiqueModel> cart) async {
    // print('================SEND FOR API ==================');
    Response<Map<String, dynamic>> response;
    cart.map((e) async {
      response = await _cartBoutiqueService.addCartBoutique(e.toJson());
      cartOrderNumber.value = response.body!['data'];
    }).toList();
    // response;
  }
}
