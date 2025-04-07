import 'package:get/get.dart';
import 'package:jaime_yakro/Providers/path_providers.dart';

class BonPlanApiController extends GetxController {
  final RxBool bonPlanLoading = false.obs;
  final RxList<BonPlanModel> bonPlanList = <BonPlanModel>[].obs;
  final BonPlanService _bonPlanService = BonPlanService();
  final MainController mainController = Get.put(MainController());
  final VisiteApiController _visiteApiController =
      Get.put(VisiteApiController());
  @override
  void onInit() {
    mainController.onInit();
    _bonPlanService.onInit();
    _visiteApiController.onInit();
    _visiteApiController.addVisite('bon_plan');
    getAllBonPlans();
    super.onInit();
  }

  //Get All Bon Plan
  Future<void> getAllBonPlans() async {
    bonPlanLoading.value = true;
    try {
      final response = await _bonPlanService.getAllBonPlans();
      // print(response.body);
      if (response.statusCode == 200) {
        bonPlanList.value = response.body!;
        bonPlanLoading.value = false;
      } else {
        bonPlanLoading.value = false;
      }
    } catch (e) {
      // print(e);
      bonPlanLoading.value = false;
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
