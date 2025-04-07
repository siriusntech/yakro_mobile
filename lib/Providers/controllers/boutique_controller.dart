import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jaime_yakro/Helpers/helpers.dart';
import 'package:jaime_yakro/Providers/path_providers.dart';
import 'package:jaime_yakro/Screens/Widgets/alert_dialog_windget.dart';
import 'package:jaime_yakro/routes/path_route.dart';
import 'package:quickalert/models/quickalert_type.dart';

import '../../Screens/Modules/Boutique/path_boutique.dart';

class BoutiqueController extends GetxController {
  final RxBool validCommandLoading = false.obs;
  final RxBool orderListLoading = false.obs;
  final CategorieBoutiqueController categorieBoutiqueController =
      Get.put(CategorieBoutiqueController());
  final ProduitBoutiqueController produitBoutiqueController =
      Get.put(ProduitBoutiqueController());
  final UserBoutiqueController userBoutiqueController =
      Get.put(UserBoutiqueController());
  final MainController mainController = Get.put(MainController());
  final VisiteApiController visiteApiController =
      Get.put(VisiteApiController());
  final BoutiqueService boutiqueService = BoutiqueService();
  RxString orderNumber = ''.obs;
  final Rx<OrderBoutiqueModel?> orderBoutique = Rx<OrderBoutiqueModel?>(null);
  final RxList<OrderBoutiqueModel> orderList = RxList<OrderBoutiqueModel>([]);
  Rx<ShippingBoutiqueModel?> currentShipping = Rx<ShippingBoutiqueModel?>(null);
  Rx<DateTime> dateOrder = Rx<DateTime>(DateTime.now());
  @override
  void onInit() {
    dateOrder = Rx<DateTime>(DateTime.now());
    categorieBoutiqueController.onInit();
    produitBoutiqueController.onInit();
    orderNumber.value =
        'ACHM${dateOrder.value.year.toString().split('20')[0]}-00${Helpers.generateRandomInt(4).toUpperCase()}';
    boutiqueService.onInit();
    getShippingByCurrentHour();
    validCommandLoading.value = false;
    visiteApiController.onInit();
    visiteApiController.addVisite('boutique');
    super.onInit();
  }

  //get Shipping by current Hour
  Future<void> getShippingByCurrentHour() async {
    var response = await boutiqueService.getShippingByCurrentHour();
    // print(response.body);
    if (response.statusCode == 200) {
      currentShipping.value = response.body!;
    } else {
      currentShipping.value = null;
    }
  }

  //vaider une Commande
  Future<void> validerCommande(
      {required String subTotal,
      required int shippingId,
      required String totalAmount,
      required int quantity,
      required TypeLivraison typeLivraison,
      required int nbrJourAvLivraison,
      required String jourLivraison,
      required BuildContext context}) async {
    // print('======POST VALIDER COMMANDE=======');
    // print([shippingId,typeLivraison]);
    // return null;
    Map<String, dynamic> data = {
      'user_boutique_id': userBoutiqueController.userBoutique.value == null
          ? 0
          : userBoutiqueController.userBoutique.value!.id,
      'sub_total': subTotal.split('F')[0].trim(),
      'shipping_id': shippingId,
      'total_amount': totalAmount.split('F')[0].trim(),
      'quantity': quantity,
      'order_number': orderNumber.value,
      'type_livraison':
          typeLivraison == TypeLivraison.domicile ? 'domicile' : 'point_relais',
      'nbr_jour_av_livraison': nbrJourAvLivraison,
      'jour_livraison': jourLivraison,
      'device_id': mainController.deviceId.value,
      'device_model': mainController.deviceModel.value
    };
    validCommandLoading.value = true;

    try {
      var response = await boutiqueService.validerCommande(data);
      // print(response.body);

      if (response.statusCode == 200) {
        orderBoutique.value = response.body!;
        validCommandLoading.value = false;
        orderNumber.value =
        'ACHM${dateOrder.value.year.toString().split('20')[0]}-00${Helpers.generateRandomInt(4).toUpperCase()}';
        Get.offAllNamed(AppRoutes.homeScreen);
        if (typeLivraison == TypeLivraison.domicile) {
          quickAlertDialog(context, QuickAlertType.success,
              color: const Color(0xff931F22),
              message:
                  "Votre commande est validée, un livreur vous contactera dans moins de 72h pour la livraison",
              title: "Commande Validée",
              onConfirmBtnTap: () => Get.back());
        } else if (typeLivraison == TypeLivraison.point_relais) {
          quickAlertDialog(context, QuickAlertType.success,
              color: const Color(0xff931F22),
              message:
                  "Votre commande est validée, nous vous contacterons dans moins de 72h pour recupérer votre colis",
              title: "Commande Validée",
              onConfirmBtnTap: () => Get.back());
        }
      } else {
        validCommandLoading.value = false;
        quickAlertDialog(context, QuickAlertType.error,
            color: const Color(0xff931F22),
            message: "Commande Non Validée",
            title: "Commande",
            onConfirmBtnTap: () => Get.back());
      }
      produitBoutiqueController.getAllProduitBoutique();
    } catch (e) {
      validCommandLoading.value = false;
    }
  }

  //get All Order With Status
  Future<void> getAllOrderWithStatus(String status) async {
    // print('================GET ALL ORDERS WITH STATUS================');
    orderListLoading.value = true;
    try {
      var response = await boutiqueService.getAllOrderWithStatus(status);
      // print(response.body);
      if (response.statusCode == 200) {
        orderList.value = response.body!;
      } else {
        orderBoutique.value = null;
      }
      orderListLoading.value = false;
    } catch (e) {
      orderListLoading.value = false;
    }
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  //Getters

  CategorieBoutiqueController get categorieBoutiqueControllerGetter =>
      categorieBoutiqueController;

  ProduitBoutiqueController get produitBoutiqueControllerGetter =>
      produitBoutiqueController;

  //Setters
}
