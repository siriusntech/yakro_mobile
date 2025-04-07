import 'package:get/get.dart';
import 'package:jaime_yakro/Providers/path_providers.dart';

class HomeScreenController extends GetxController {
  final MainController _mainController = Get.put(MainController());
  final CoursierConciergerieController _coursierConciergerieController =
      Get.put(CoursierConciergerieController());
  @override
  void onInit() {
    _mainController.onInit();
    _coursierConciergerieController.onInit();
    AnalyticsService().logScreenView('HomeScreen', 'HomeScreen', {
      'screen_name': 'HomeScreen',
      'user_id': _mainController.userId.value.toString(),
      'device_id': _mainController.deviceId.value.toString(),
    });
    coursierConciergerieController.connectedCoursierConcierge();
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

  //Getters
  CoursierConciergerieController get coursierConciergerieController =>
      _coursierConciergerieController;
  MainController get mainController => _mainController;
}
