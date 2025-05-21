import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jaime_yakro/Config/Theme/Constant/const_colors.dart';
import 'package:jaime_yakro/Providers/path_providers.dart';

class CommerceSingleScreenController extends GetxController {
  Rx<Color> colorPrimary = const Color(0xffEEB446).obs;
  RxBool commentaireHotelLoading = false.obs;
  RxBool commentaireHotelListLoading = false.obs;
  RxString title = "Commerce".obs;
  Rx<CommerceModel> commerceModel = CommerceModel().obs;
  final Rx<TextEditingController> textcommentaireController =
      Rx<TextEditingController>(TextEditingController());
  Rx<CommentaireModel?> commentaireHotel = Rx<CommentaireModel?>(null);
  Rx<List<CommentaireModel>> commentaireList = Rx<List<CommentaireModel>>([]);
  final CommerceService _commerceService = CommerceService();
  final MainController _mainController = Get.put(MainController());
  final CommentaireService _commentaireService = CommentaireService();
  @override
  void onInit() {
    commentaireHotelLoading.value = false;
    commentaireHotelListLoading.value = false;

    _mainController.onInit();
    _commerceService.onInit();
    _commentaireService.onInit();
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  //Setters
  void setCommerceModel(CommerceModel commentaireHodel) {
    commerceModel.value = commentaireHodel;
    // print("model: ${commerceModel.value}");
    getAllCommentaireCommerce(commentaireHodel.id!);
    update();
  }

  //post commentaire Hotel
  Future<void> postAddCommentaireCommerce(int hotelId) async {
    // print("======POST ADD COMMENTAIRE COMMERCE=======");
    commentaireHotelLoading.value = true;
    try {
      var response = await _commentaireService.addCommentaireCommerce(
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
  Future<void> getAllCommentaireCommerce(int commerceId) async {
    // print('======GET ALL COMMENTAIRE COMMENTAIRE=======');

    commentaireHotelListLoading.value = true;
    try {
      var response =
          await _commentaireService.getAllCommentaireCommerce(commerceId);
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

  //Rating Commerce
  void setRating(CommerceModel commerceM, double rating) {
    commerceM.moyenneRating.value = int.parse(rating.ceil().toString());
    incrementRating(commerceM);
    postRatingCommerce(rating);
    update();
  }

  //Rating Increment Hotel
  void incrementRating(
    CommerceModel commerceM,
  ) {
    if (commerceM.isRating.value == false) {
      commerceM.countRating.value = commerceM.countRating.value + 1;
      commerceM.isRating.value = true;
    }

    update();
  }

  //add Rating Hotel
  Future<void> postRatingCommerce(double rating) async {
    // print("======POST RATING COMMMERCE=======");
    try {
      var response = await _commerceService.postRatingCommerce(
          _mainController.userId.value,
          commerceModel.value.id.toString(),
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
      (e);
    }
  }

  @override
  void onClose() {
    super.onClose();
  }

  //Getters
  CommerceModel get findCommerceModel => commerceModel.value;
}
