import 'package:get/get.dart';
import '../path_providers.dart';

class CoursierConciergerieController extends GetxController {
  final CoursierConciergerieService _coursierConciergerieService = CoursierConciergerieService();
  final MainController mainController = Get.find();
  Rx<CoursierConciergeModel?> coursierConciergeModel = CoursierConciergeModel().obs; //coursier concierge>
  RxBool coursierConciergeLoading = false.obs;
  @override
  void onInit() {
    _coursierConciergerieService.onInit();
    showCoursierConcierge();
    super.onInit();
  }

  Future <void> showCoursierConcierge() async {
    coursierConciergeLoading.value = true;
    try {
      final response = await _coursierConciergerieService.showCoursierConcierge();
      coursierConciergeModel.value = response!.body!;
      coursierConciergeLoading.value = false;
    }catch (e) {
      coursierConciergeLoading.value = false;
      // Get.snackbar('Erreur', e.toString(), icon: const Icon(Icons.close, color: Colors.white,), backgroundColor: ConstColors.alertDanger, colorText: Colors.white);
    }
  }

  //connected coursier concierge
  bool connectedCoursierConcierge() {
    return mainController.getCoursierConciergeConnected();
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