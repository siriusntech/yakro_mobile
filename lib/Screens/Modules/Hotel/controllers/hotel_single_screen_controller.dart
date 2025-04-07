import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jaime_yakro/Config/Theme/Constant/const_colors.dart';
import 'package:jaime_yakro/Providers/path_providers.dart';

class HotelSingleScreenController extends GetxController {
  RxBool commentaireHotelLoading = false.obs;
  RxBool commentaireHotelListLoading = false.obs;
  Rx<HotelModel> hotelModel = HotelModel().obs;
  final CommentaireService _commentaireHotelService = CommentaireService();
  final HotelService _hotelService = HotelService();
  final MainController _mainController = Get.put(MainController());

  final Rx<TextEditingController> textcommentaireController =
      Rx<TextEditingController>(TextEditingController());
  Rx<List<CommentaireModel>> commentaireList = Rx<List<CommentaireModel>>([]);
  Rx<CommentaireModel?> commentaireHotel = Rx<CommentaireModel?>(null);
  @override
  void onInit() {
    commentaireHotelLoading.value = false;
    commentaireHotelListLoading.value = false;
    _commentaireHotelService.onInit();
    _hotelService.onInit();
    super.onInit();
  }

  void setHotelModel(HotelModel hotelModel) {
    this.hotelModel.value = hotelModel;
    getAllCommentaireHotel(hotelModel.id!);
    update();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  //post commentaire Hotel
  Future<void> postAddCommentaireHotel(int hotelId) async {
    // print("======POST ADD COMMENTAIRE HOTEL=======");
    commentaireHotelLoading.value = true;
    try {
      var response = await _commentaireHotelService.addCommentaireHotel(
          textcommentaireController.value.text,
          _mainController.userId.value,
          hotelId.toString());
      if (response.statusCode == 200) {
        commentaireHotel.value = response.body!;
        Get.snackbar(
          'Commentaire',
          'Commentaire Ajouté avec Succès',
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
        commentaireHotelLoading.value = false;
        textcommentaireController.value.clear();
      } else {
        commentaireHotelLoading.value = false;
      }
    } catch (e) {
      commentaireHotelLoading.value = false;
    }
  }

//Get All Commentaire Hotel
  Future<void> getAllCommentaireHotel(int hotelId) async {
    // print('======GET ALL COMMENTAIRE HOTEL=======');

    commentaireHotelListLoading.value = true;
    try {
      var response =
          await _commentaireHotelService.getAllCommentaireHotel(hotelId);
      // print(response.body);
      if (response.statusCode == 200) {
        commentaireList.value = response.body!;
        // print(commentaireList.value);
        commentaireHotelListLoading.value = false;
      } else {
        commentaireHotelListLoading.value = false;
      }
    } catch (e) {
      commentaireHotelListLoading.value = false;
    }
  }

  //Rating Hotel
  void setRating(HotelModel hotelM, double rating) {
    hotelM.moyenneRating.value = double.parse(rating.ceil().toString());
    incrementRating(hotelM);
    postRatingHotel(rating);
    update();
  }

  //Rating Increment Hotel
  void incrementRating(HotelModel hotelM) {
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
      var response = await _hotelService.postRatingHotel(
          _mainController.userId.value,
          hotelModel.value.id.toString(),
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
}
