import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jaime_yakro/Providers/path_providers.dart';

class CommerceController extends GetxController {
  final RxBool commerceLoading = false.obs;
  RxList<CommerceModel> commerceList = <CommerceModel>[].obs;
  var currentRangeValues = const RangeValues(0, 100000).obs;
  final MainController _mainController = Get.put(MainController());
  final CommerceService _commerceService = CommerceService();

  final VisiteApiController _visiteApiController =
      Get.put(VisiteApiController());

  @override
  void onInit() {
    _mainController.onInit();
    _commerceService.onInit();
    _commerceService.onInit();
    _visiteApiController.onInit();
    _visiteApiController.addVisite('commerce');
    super.onInit();
  }

  @override
  void onReady() {
    _mainController.onInit();
    getAllCommerce();
    super.onClose();
  }

  //Get all commerce
  Future<void> getAllCommerce() async {
    commerceLoading.value = true;
    try {
      final response = await _commerceService.getAllCommerce();
      // print(response.body);
      if (response.statusCode == 200) {
        commerceList.value = response.body!;
        commerceLoading.value = false;
      } else {
        commerceLoading.value = false;
      }
    } catch (e) {
      commerceLoading.value = false;
    }
  }

  //Filtre Par Type Hotel
  Future<void> postFiltreParTypeCommerce(String typeCommerceId) async {
    // print("==============POST FILTRE PAR TYPE COMMERCE==============");
    commerceLoading(true);
    try {
      var response =
          await _commerceService.postFiltreParTypeCommerce(typeCommerceId);
      // print(response.body);
      if (response.statusCode == 200) {
        commerceList.value = response.body!;
        commerceLoading(false);
      } else {
        commerceLoading(false);
      }
    } catch (e) {
      commerceLoading(false);
    }
  }

  //Filtre Par Specialité
  Future<void> postFiltreParSpecialite(String specialiteId) async {
    // print("==============POST FILTRE PAR SPECIALITE==============");
    commerceLoading(true);
    try {
      var response =
          await _commerceService.postFiltreParSpecialite(specialiteId);
      // print(response.body);
      if (response.statusCode == 200) {
        commerceList.value = response.body!;
        commerceLoading(false);
      } else {
        commerceLoading(false);
      }
    } catch (e) {
      commerceLoading(false);
    }
  }

  //Filtre Specialité et Type Commerce
  Future<void> postFiltreParSpecialiteEtTypeCommerce(
      String specialiteId, String typeCommerceId) async {
    // print(
    //     "==============POST FILTRE PAR SPECIALITE ET TYPE COMMERCE==============");
    commerceLoading(true);
    try {
      var response = await _commerceService
          .postFiltreParSpecialiteEtTypeCommerce(specialiteId, typeCommerceId);
      // print(response.body);
      if (response.statusCode == 200) {
        commerceList.value = response.body!;
        commerceLoading(false);
      } else {
        commerceLoading(false);
      }
    } catch (e) {
      commerceLoading(false);
    }
  }

  //Post Favorite
  Future<Response<FavorisModel>> postFavorite(
      CommerceModel commerceModel, String userId, bool isFavorite) async {
    return await _commerceService.postFavorite(
        favoris: isFavorite,
        typeCategorie: 'commerce',
        typeCategorieId: commerceModel.id.toString(),
        userId: userId);
  }

  // Toggle favorite status
  void toggleFavorite(CommerceModel commerceModel) {
    commerceModel.isFavorite.value = !commerceModel.isFavorite.value;
    countFavoris(commerceModel);
    postFavorite(commerceModel, _mainController.userId.value,
        commerceModel.isFavorite.value);
  }

  //increment and decrement countFavoris
  void countFavoris(CommerceModel commerceModel) {
    commerceModel.countFavoris.value = commerceModel.isFavorite.value
        ? commerceModel.countFavoris.value + 1
        : commerceModel.countFavoris.value - 1;
    update();
  }
}
