import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:jaime_yakro/Config/Theme/Constant/const_colors.dart';
import 'package:jaime_yakro/Providers/path_providers.dart';
import 'package:jaime_yakro/Screens/Modules/Boutique/views/components/confirmation_commande_screen.dart';
import 'package:jaime_yakro/Screens/Widgets/alert_dialog_windget.dart';
import 'package:quickalert/models/quickalert_type.dart';

class CartScreenController extends GetxController {
  final RxString title = "Mon Panier".obs;
  Rx<Color> colorPrimary = const Color(0xff931F22).obs;
  Rx<Color> colorSecondary = Colors.amber.obs;
  RxList<CartBoutiqueModel> cartBoutiqueList = <CartBoutiqueModel>[].obs;
  final RxDouble total = 0.0.obs;
  final RxDouble prixLivraison = 0.0.obs;
  final RxDouble totalTTC = 0.0.obs;
  final MainController mainController = Get.find();
  final CartBoutiqueController _cartBoutiqueController =
      Get.put(CartBoutiqueController());
  final BoutiqueService boutiqueService = BoutiqueService();
  Rx<ShippingBoutiqueModel?> currentShipping = Rx<ShippingBoutiqueModel?>(null);
  @override
  void onInit() {
    mainController.onInit();
    _cartBoutiqueController.onInit();
    boutiqueService.onInit();
    getShippingByCurrentHour();
    super.onInit();
  }

  //add to cart
  void addToCart(
      ProduitBoutiqueModel produitBoutiqueModel, String orderNumber) {
    // print('=============ADD TO CART =============');
    if (produitBoutiqueModel.quantite == 0) {
      Get.snackbar(
        "Attention",
        "Vous avez atteint la quantite maximum",
        backgroundColor: ConstColors.alertWarnig,
        colorText: Colors.white,
        snackStyle: SnackStyle.FLOATING,
        borderRadius: 10,
        margin: const EdgeInsets.all(10),
        icon: const Icon(
          Icons.warning,
          color: Colors.white,
        ),
      );
      return;
    }
    var isExist = cartBoutiqueList.where((element) =>
        element.produitBoutiqueModel.id == produitBoutiqueModel.id);
    if (isExist.isEmpty) {
      cartBoutiqueList.add(CartBoutiqueModel(
          produitBoutiqueModel: produitBoutiqueModel,
          quantite: 1,
          deviceId: mainController.deviceId.value,
          deviceModel: mainController.deviceModel.value,
          orderNumber: orderNumber,
          totalPrice: double.parse(produitBoutiqueModel.prix.toString()) * 1));
    } else {
      isExist.first.quantite += 1;
      isExist.first.totalPrice =
          double.parse(isExist.first.produitBoutiqueModel.prix.toString()) *
              isExist.first.quantite;
    }
    calculateTotal();
    // print(cartBoutiqueList.length);
    update();
  }

  //remove produit boutique
  void removeItemProduitBoutique(ProduitBoutiqueModel produitBoutiqueModel) {
    cartBoutiqueList.removeWhere((element) =>
        element.produitBoutiqueModel.id == produitBoutiqueModel.id);
    calculateTotal();
    update();
  }

  //clear cart
  void clearCart() {
    cartBoutiqueList.clear();
    calculateTotal();
    update();
  }

  //calculate total
  void calculateTotal() {
    total.value = 0.0;
    for (var element in cartBoutiqueList) {
      total.value += element.totalPrice;
    }
    update();
  }

  //increment quantity
  void incrementQuantity(ProduitBoutiqueModel produitBoutiqueModel) {
    CartBoutiqueModel cartBoutiqueModel = cartBoutiqueList
        .where((element) =>
            element.produitBoutiqueModel.id == produitBoutiqueModel.id)
        .first;

    if (produitBoutiqueModel.quantite == cartBoutiqueModel.quantite) {
      Get.snackbar(
        "Attention",
        "Vous avez atteint la quantite maximum",
        backgroundColor: ConstColors.alertWarnig,
        colorText: Colors.white,
        snackStyle: SnackStyle.FLOATING,
        borderRadius: 10,
        margin: const EdgeInsets.all(10),
        icon: const Icon(
          Icons.warning,
          color: Colors.white,
        ),
      );
    } else {
      cartBoutiqueModel.quantite += 1;
      cartBoutiqueModel.totalPrice =
          double.parse(cartBoutiqueModel.produitBoutiqueModel.prix.toString()) *
              cartBoutiqueModel.quantite;
    }

    calculateTotal();
    update();
  }

  //get Shipping by current Hour
  Future<void> getShippingByCurrentHour() async {
    var response = await boutiqueService.getShippingByCurrentHour();
    if (response.statusCode == 200) {
      currentShipping.value = response.body!;

      // prixLivraison.value =
      //     double.parse(currentShipping.value!.prix.toString());
      setChangeAmounLivraison(
          double.parse(currentShipping.value!.prix.toString()));
    } else {
      currentShipping.value = null;
    }
  }

  setChangeAmounLivraison(double price) {
    prixLivraison.value = price;
    // print(prixLivraison.value);
    update();
  }

  //quantity product cart
  quantityProductCart(ProduitBoutiqueModel produitBoutiqueModel) {
    CartBoutiqueModel cartBoutiqueModel = cartBoutiqueList
        .where((element) =>
            element.produitBoutiqueModel.id == produitBoutiqueModel.id)
        .first;
    update();
    return cartBoutiqueModel.quantite;
  }

  //decrement quantity
  void decrementQuantity(ProduitBoutiqueModel produitBoutiqueModel) {
    CartBoutiqueModel cartBoutiqueModel = cartBoutiqueList
        .where((element) =>
            element.produitBoutiqueModel.id == produitBoutiqueModel.id)
        .first;
    if (cartBoutiqueModel.quantite > 1) {
      cartBoutiqueModel.quantite -= 1;
      cartBoutiqueModel.totalPrice =
          double.parse(cartBoutiqueModel.produitBoutiqueModel.prix.toString()) *
              cartBoutiqueModel.quantite;
    } else if (cartBoutiqueModel.quantite == 1) {
      removeItemProduitBoutique(produitBoutiqueModel);
    }
    calculateTotal();
    update();
  }

  //Confirmer Panier
  void genererCodeCommande(BuildContext context) {
    // print('Confirmer Panier');
    quickAlertDialog(context, QuickAlertType.loading,
        color: colorPrimary.value,
        message: "Patientez nous vous generons un code de commande");
    _cartBoutiqueController.addCart(cartBoutiqueList);

    Future.delayed(const Duration(seconds: 4), () {
      Get.back();
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (_) => const ConfirmationCommandeScreen()));
    });
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
  List<CartBoutiqueModel> get cartBoutiqueListGetter => cartBoutiqueList;
  String get totalGetter =>
      NumberFormat.currency(locale: 'fr', symbol: 'F').format(total.value);

  String get totalTTCGetter => NumberFormat.currency(locale: 'fr', symbol: 'F')
      .format(total.value + prixLivraison.value);

  String get prixLivraisonGetter =>
      NumberFormat.currency(locale: 'fr', symbol: 'F')
          .format(prixLivraison.value);
}
