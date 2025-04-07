import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jaime_yakro/Config/Theme/Constant/const_colors.dart';
import 'package:jaime_yakro/Providers/path_providers.dart';

class SiteTourismeSingleScreenController extends GetxController {
  Rx<SiteTouristiqueModel> siteTourismeModel = SiteTouristiqueModel().obs;
  final MainController _mainController = Get.put(MainController());
  final SiteTouristiqueService _siteTouristiqueService =
      SiteTouristiqueService();
  @override
  void onInit() {
    _siteTouristiqueService.onInit();
    _mainController.onInit();
    super.onInit();
  }

  void setSiteTourismeModel(SiteTouristiqueModel hotelModel) {
    siteTourismeModel.value = hotelModel;
    // getAllCommentaireHotel(hotelModel.id!);
    update();
  }

  //Rating site Tourisme
  void setRating(SiteTouristiqueModel hotelM, double rating) {
    hotelM.moyenneRating.value = double.parse(rating.ceil().toString());
    incrementRating(hotelM);
    postRatingHotel(rating);
    update();
  }

  //Rating Increment Site Tourisme
  void incrementRating(SiteTouristiqueModel hotelM) {
    if (hotelM.isRating.value == false) {
      hotelM.countRating.value = hotelM.countRating.value + 1;
      hotelM.isRating.value = true;
    }
    update();
  }

  //add Rating Hotel
  Future<void> postRatingHotel(double rating) async {
    // print("======POST RATING HOTEL=======");
    try {
      var response = await _siteTouristiqueService.postRatingHotel(
          siteTourismeModel.value.id.toString(),
          int.parse(rating.ceil().toString()));
      if (response.statusCode == 200) {
        Get.snackbar(
          'Rating',
          'Rating Ajouté avec Succès',
          backgroundColor: ConstColors.alertSuccess,
          colorText: Colors.white,
          snackStyle: SnackStyle.FLOATING,
          borderRadius: 10,
          margin: const EdgeInsets.all(10),
          icon: const Icon(
            Icons.check_circle,
            color: Colors.white,
          ),
        );
      }
    } catch (e) {
      print(e);
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
}
