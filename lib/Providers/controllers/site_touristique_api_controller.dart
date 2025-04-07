import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jaime_yakro/Providers/path_providers.dart';

class SiteTouristiqueApiController extends GetxController {
  final RxBool siteTouriqueLoading = false.obs;
  final RxList<SiteTouristiqueModel> siteTouristiqueList =
      <SiteTouristiqueModel>[].obs;
  final SiteTouristiqueService _siteTouristiqueService =
      SiteTouristiqueService();
  final MainController _mainController = Get.put(MainController());
  var currentRangeValues = const RangeValues(0, 100000).obs;
  final VisiteApiController _visiteApiController =
      Get.put(VisiteApiController());
  @override
  void onInit() {
    _siteTouristiqueService.onInit();
    _visiteApiController.onInit();
    _visiteApiController.addVisite('site_touristiques');
    getAllSiteTouristique();
    super.onInit();
  }

  //Get all site touristique
  Future<void> getAllSiteTouristique() async {
    siteTouriqueLoading.value = true;
    try {
      final response = await _siteTouristiqueService.getAllSiteTouristique();
      // print(response.body);
      if (response.statusCode == 200) {
        siteTouristiqueList.value = response.body!;
        siteTouriqueLoading.value = false;
      } else {
        siteTouriqueLoading.value = false;
      }
    } catch (e) {
      // print(e);
      siteTouriqueLoading.value = false;
    }
  }

  //Filtre Par Categoeie
  Future<void> filterByCategory(String categoryId) async {
    siteTouriqueLoading.value = true;
    try {
      final response = await _siteTouristiqueService.postFiltreParCategorie(
          categoryId,
          currentRangeValues.value.start.toString(),
          currentRangeValues.value.end.toString());
      // print(response.body);
      if (response.statusCode == 200) {
        siteTouristiqueList.value = response.body!;
        siteTouriqueLoading.value = false;
      } else {
        siteTouriqueLoading.value = false;
      }
    } catch (e) {
      // print(e);
      siteTouriqueLoading.value = false;
    }
  }

  //Filtre Par Prix
  Future<void> postFiltreParPrix() async {
    // print("==============POST FILTRE PAR PRIX==============");
    siteTouriqueLoading(true);
    try {
      var response = await _siteTouristiqueService.postFiltreParPrix(
          currentRangeValues.value.start.toString(),
          currentRangeValues.value.end.toString());
      if (response.statusCode == 200) {
        siteTouristiqueList.value = response.body!;
        siteTouriqueLoading(false);
      } else {
        siteTouriqueLoading(false);
      }
    } catch (e) {
      siteTouriqueLoading(false);
    }
  }

  //Post Favorite
  Future<Response<FavorisModel>> postFavorite(
      SiteTouristiqueModel hotelModel, String userId, bool isFavorite) async {
    return await _siteTouristiqueService.postFavorite(
        favoris: isFavorite,
        typeCategorie: 'visite_touristique',
        typeCategorieId: hotelModel.id.toString(),
        userId: userId);
  }

  // Toggle favorite status
  void toggleFavorite(SiteTouristiqueModel hotelModel) {
    hotelModel.isFavorite.value = !hotelModel.isFavorite.value;
    countFavoris(hotelModel);
    postFavorite(
        hotelModel, _mainController.userId.value, hotelModel.isFavorite.value);
  }

  //increment and decrement countFavoris
  void countFavoris(SiteTouristiqueModel hotelModel) {
    hotelModel.countFavoris.value = hotelModel.isFavorite.value
        ? hotelModel.countFavoris.value + 1
        : hotelModel.countFavoris.value - 1;
    update();
  }

  //Post Like and Dislike
  Future<Response<Map<String, dynamic>>> postLikeAndDislike(
      SiteTouristiqueModel hotelModel, String userId, String status) async {
    return await _siteTouristiqueService.addLikeAndDislike(
        userId, hotelModel.id.toString(), status);
  }

  //Toggle Like
  void toggleLike(SiteTouristiqueModel hotelModel) {
    if (hotelModel.like.value == true) {
      hotelModel.like.value = false;
    } else if (hotelModel.like.value == false &&
        hotelModel.dislike.value == false) {
      hotelModel.like.value = true;
      hotelModel.dislike.value = false;
    } else if (hotelModel.like.value == false &&
        hotelModel.dislike.value == true) {
      hotelModel.like.value = true;
      hotelModel.dislike.value = false;

      countDislike(hotelModel);
    }
    countLike(hotelModel);
    postLikeAndDislike(
      hotelModel,
      _mainController.userId.value,
      'like',
    );
  }

  //Count incremente Like and decrement dislike
  void countLike(SiteTouristiqueModel hotelModel) {
    hotelModel.countLike.value = hotelModel.like.value
        ? hotelModel.countLike.value + 1
        : hotelModel.countLike.value - 1;

    update();
  }

  //Toggle Dislike
  void toggleDislike(SiteTouristiqueModel hotelModel) {
    if (hotelModel.dislike.value == true) {
      hotelModel.dislike.value = false;
    } else if (hotelModel.dislike.value == false &&
        hotelModel.like.value == true) {
      hotelModel.dislike.value = true;
      hotelModel.like.value = false;

      countLike(hotelModel);
    } else if (hotelModel.dislike.value == false &&
        hotelModel.like.value == false) {
      hotelModel.dislike.value = true;
      hotelModel.like.value = false;
    }
    countDislike(hotelModel);
    postLikeAndDislike(
      hotelModel,
      _mainController.userId.value,
      'dislike',
    );
  }

  //Count Dislike
  void countDislike(SiteTouristiqueModel hotelModel) {
    hotelModel.countDislike.value = hotelModel.dislike.value
        ? hotelModel.countDislike.value + 1
        : hotelModel.countDislike.value - 1;
    // print([hotelModel.countDislike.value, hotelModel.like.value]);
    update();
  }

  //Categorie VT
  Future<void> getCategorieVT() async {}

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
