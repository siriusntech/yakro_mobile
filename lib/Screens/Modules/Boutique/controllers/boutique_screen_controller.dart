import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jaime_yakro/Providers/path_providers.dart';
import 'package:jaime_yakro/Screens/Modules/Boutique/path_boutique.dart';

class BoutiqueScreenController extends GetxController {
  Rx<Color> colorPrimary = const Color(0xff931F22).obs;
  Rx<Color> colorSecondary = Colors.amber.obs;
  Rx<Color> panierButton = Colors.black.obs;
  Rx<TypeScreen> typeScreen = TypeScreen.boutiqueScreen.obs;
  RxBool floatingDisable = false.obs;
  RxString title = 'Boutique'.obs;
  RxList tableProduct = [
    'assets/images/boubou.jpeg',
    'assets/images/boubou_homme.jpeg',
    'assets/images/chemise.jpeg',
    'assets/images/montre_co.jpeg',
    'assets/images/sandale.jpeg'
  ].obs;

  final BoutiqueController controllerBoutique = Get.put(BoutiqueController());
  final CartScreenController controllerCartScreen =
      Get.put(CartScreenController());
  final CommandeScreenController controllerCommandeScreen =
      Get.put(CommandeScreenController());
  final UserBoutiqueController userBoutiqueController =
      Get.put(UserBoutiqueController());
  final CartBoutiqueController cartBoutiqueController =
      Get.put(CartBoutiqueController());
  final MainController _mainController = Get.put(MainController());
  final AuthController authController = Get.put(AuthController());

  @override
  void onInit() {
    floatingDisable = false.obs;
    controllerBoutique.onInit();
    controllerBoutique.getShippingByCurrentHour();
    controllerCartScreen.onInit();
    controllerCommandeScreen.onInit();
    cartBoutiqueController.onInit();
    typeScreen = TypeScreen.boutiqueScreen.obs;
    authController.onInit();
    AnalyticsService().logScreenView('BoutiqueScreen', 'BoutiqueScreen', {
      'screen_name': 'BoutiqueScreen',
      'user_id': _mainController.userId.value.toString(),
      'device_id': _mainController.deviceId.value.toString(),
    });
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void setChangeScreen(TypeScreen typeScreen) {
    this.typeScreen.value = typeScreen;
    update();
  }

  void setFloatingDisable(bool floatingDisable) {
    this.floatingDisable.value = floatingDisable;
    update();
  }

  //Getters
  BoutiqueController get controllerBoutiqueGetter => controllerBoutique;
  CartScreenController get controllerCartScreenGetter => controllerCartScreen;
  CartBoutiqueController get cartBoutiqueControllerGetter =>
      cartBoutiqueController;
  CommandeScreenController get controllerCommandeScreenGetter =>
      controllerCommandeScreen;
  UserBoutiqueController get userBoutiqueControllerGetter =>
      userBoutiqueController;
  TypeScreen get typeScreenGetter => typeScreen.value;
  //Setters
}
