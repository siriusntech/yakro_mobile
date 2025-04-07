import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jaime_yakro/Providers/path_providers.dart';
import 'package:jaime_yakro/Screens/Modules/Hotel/path_hotel.dart';

class HotelScreenController extends GetxController {
  // var currentRangeValues = const RangeValues(0, 100000).obs;
  RxBool isLoading = false.obs;
  Rx<Color> colorPrimary = const Color(0xff3D81B0).obs;
  Rx<Color> colorSecondary = Colors.amber.obs;
  RxString title = "Hotel".obs;
  Rx<AuthModel?> authModel = Rx<AuthModel?>(null);
  final MainController _mainController = Get.put(MainController());

  final HotelController _hotelController = Get.put(HotelController());
  final TypeHotelController _typeHotelController =
      Get.put(TypeHotelController());
  // final CommentaireHotelController _commentaireHotelController =
  //     Get.put(CommentaireHotelController());
  final HotelSingleScreenController _hotelSingleController =
      Get.put(HotelSingleScreenController());

  final AuthController authController = Get.put(AuthController());

  final searchController = TextEditingController().obs;

  @override
  void onInit() {
    _mainController.onInit();
    authController.onInit();
    _hotelController.onInit();
    _typeHotelController.onInit();
    setAuthModel(authController.authModel.value);
    // _commentaireHotelController.onInit();
    _hotelSingleController.onInit();
    AnalyticsService().logScreenView('HotelScreen', 'HotelScreen', {
      'screen_name': 'HotelScreen',
      'user_id': _mainController.userId.value.toString(),
      'device_id': _mainController.deviceId.value.toString(),
    });
    super.onInit();
  }

  void setAuthModel(AuthModel? authModel) => this.authModel.value = authModel;

  @override
  void onReady() {
    super.onReady();
  }

  // void updateCurrentRangeValues(double start, double end) {
  //   currentRangeValues.value = RangeValues(start, end);
  // }

  @override
  void onClose() {
    super.onClose();
  }

  //Get
  TypeHotelController get typeHotelController => _typeHotelController;
  MainController get mainController => _mainController;
  HotelController get hotelController => _hotelController;
  // CommentaireHotelController get commentaireHotelController =>
  //     _commentaireHotelController;
  HotelSingleScreenController get hotelSingleScreenController =>
      _hotelSingleController;

  Rx<AuthModel?> get authModelget => authModel;
}
