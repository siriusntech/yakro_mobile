import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:jaime_yakro/Config/Theme/Constant/const_colors.dart';
import 'package:jaime_yakro/Providers/path_providers.dart';

class HotelController extends GetxController {
  final RxBool hotelLoading = false.obs;
  final RxBool hotelPubLoading = false.obs;
  var currentRangeValues = const RangeValues(0, 300000).obs;

  Rx<List<HotelModel>> hotelsList = Rx<List<HotelModel>>([]);
  RxList<HotelModel> hotelsPubList = RxList<HotelModel>([]);

  final HotelService _hotelService = HotelService();
  final MainController _mainController = Get.put(MainController());
  final VisiteApiController _visiteApiController =
      Get.put(VisiteApiController());

  @override
  void onInit() {
    _mainController.onInit();
    _hotelService.onInit();
    _visiteApiController.onInit();
    _visiteApiController.addVisite('hotels');
    getAllHotel();
    getAllHotelPub();
    super.onInit();
  }

  @override
  void onReady() {
    _mainController.onInit();
    super.onReady();
  }

  //Get All Hotels
  Future<void> getAllHotel() async {
    // print("==============HOTELS==============");
    // print(_mainController.getLoggedHeaders());
    hotelLoading(true);
    try {
      var response = await _hotelService.getAllHotel();
      // print(response.body);
      if (response.statusCode == 200) {
        // print(response.body);
        hotelsList.value = response.body!;
        hotelLoading(false);
      } else {
        hotelLoading(false);
      }
    } catch (e) {
      hotelLoading(false);
    }
  }

  //Get All Hotels Pub
  Future<void> getAllHotelPub() async {
    hotelPubLoading(true);
    try {
      var response = await _hotelService.getAllHotelPub();
      // print(response.body);
      if (response.statusCode == 200) {
        // print(response.body);
        hotelsPubList.value = response.body!;
        hotelPubLoading(false);
      } else {
        hotelPubLoading(false);
      }
    } catch (e) {
      hotelPubLoading(false);
    }
  }

  //Filtre Par Type Hotel
  Future<void> postFiltreParTypeHotel(String typeHotelId) async {
    // print("==============POST FILTRE PAR TYPE HOTEL==============");
    hotelLoading(true);
    try {
      var response = await _hotelService.postFiltreParTypeHotel(
          typeHotelId,
          currentRangeValues.value.start.toString(),
          currentRangeValues.value.end.toString());
      if (response.statusCode == 200) {
        hotelsList.value = response.body!;
        hotelLoading(false);
      } else {
        hotelLoading(false);
      }
    } catch (e) {
      hotelLoading(false);
    }
  }

  //Filtre Par Prix
  Future<void> postFiltreParPrix() async {
    // print("==============POST FILTRE PAR PRIX==============");
    hotelLoading(true);
    try {
      var response = await _hotelService.postFiltreParPrix(
          currentRangeValues.value.start.toString(),
          currentRangeValues.value.end.toString());
      if (response.statusCode == 200) {
        hotelsList.value = response.body!;
        hotelLoading(false);
      } else {
        hotelLoading(false);
      }
    } catch (e) {
      hotelLoading(false);
    }
  }

  //Post Favorite
  Future<Response<FavorisModel>> postFavorite(
      HotelModel hotelModel, String userId, bool isFavorite) async {
    return await _hotelService.postFavorite(
        favoris: isFavorite,
        typeCategorie: 'hotel',
        typeCategorieId: hotelModel.id.toString(),
        userId: userId);
  }

  // Toggle favorite status
  void toggleFavorite(HotelModel hotelModel) {
    hotelModel.isFavorite.value = !hotelModel.isFavorite.value;
    countFavoris(hotelModel);
    postFavorite(
        hotelModel, _mainController.userId.value, hotelModel.isFavorite.value);
  }

  //increment and decrement countFavoris
  void countFavoris(HotelModel hotelModel) {
    hotelModel.countFavoris.value = hotelModel.isFavorite.value
        ? hotelModel.countFavoris.value + 1
        : hotelModel.countFavoris.value - 1;
    update();
  }

  //Post Like and Dislike
  Future<Response<Map<String, dynamic>>> postLikeAndDislike(
      HotelModel hotelModel, String userId, String status) async {
    return await _hotelService.addLikeAndDislike(
        userId, hotelModel.id.toString(), status);
  }

  //Toggle Like
  void toggleLike(HotelModel hotelModel) {
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
  void countLike(HotelModel hotelModel) {
    hotelModel.countLike.value = hotelModel.like.value
        ? hotelModel.countLike.value + 1
        : hotelModel.countLike.value - 1;

    update();
  }

  //Toggle Dislike
  void toggleDislike(HotelModel hotelModel) {
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
  void countDislike(HotelModel hotelModel) {
    hotelModel.countDislike.value = hotelModel.dislike.value
        ? hotelModel.countDislike.value + 1
        : hotelModel.countDislike.value - 1;
    // print([hotelModel.countDislike.value, hotelModel.like.value]);
    update();
  }

  @override
  void onClose() {
    _mainController.onClose();
    _hotelService.onClose();
    super.onClose();
  }
}
