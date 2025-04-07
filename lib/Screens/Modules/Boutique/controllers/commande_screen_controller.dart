import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jaime_yakro/Screens/Modules/Boutique/path_boutique.dart';

class CommandeScreenController extends GetxController {
  final RxString title = "Commande".obs;
  Rx<TypeLivraison> typeLivraison = TypeLivraison.domicile.obs;
  final Rx<TextEditingController> controllerLocation =
      TextEditingController().obs;

  @override
  void onInit() {
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


}
