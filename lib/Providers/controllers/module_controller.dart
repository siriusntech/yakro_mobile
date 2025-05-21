import 'package:get/get.dart';
import 'package:jaime_yakro/Providers/path_providers.dart';

class ModuleController extends GetxController {
  final MainController _mainController = Get.put(MainController());
  final ModuleService _moduleService = ModuleService();

  RxList<ModuleModel> modulesList = <ModuleModel>[].obs;
  @override
  void onInit() {
    _moduleService.onInit();
    _mainController.onInit();
    getModules();
    getModules();
    _mainController.getModulesInfo();
    super.onInit();
  }

  Future<void> getModules() async {
    // print('======GET MODULES=======');
    var response = await _moduleService.getAllModules();
    // print(response.body);
    _mainController.setModuleEnabled(
        hotelEnable: response.body![0].hotel == 1 ? true : false,
        boutiqueEnable: response.body![6].boutique == 1 ? true : false,
        restaurantEnable: response.body![3].restaurantBar == 1 ? true : false,
        conciergerieEnable: response.body![2].conciergerie == 1 ? true : false,
        pharmacieEnable: response.body![5].pharmacie == 1 ? true : false,
        bonPlanEnable: response.body![4].bonPlans == 1 ? true : false,
        tourismeEnable: response.body![1].tourisme == 1 ? true : false,
        hotelReductionEnable:
            response.body![7].hotelReduction == 1 ? true : false);
    _mainController.saveSharedPreferenceModules(
        hotelEnable: response.body![0].hotel == 1 ? true : false,
        boutiqueEnable: response.body![6].boutique == 1 ? true : false,
        restaurantEnable: response.body![3].restaurantBar == 1 ? true : false,
        conciergerieEnable: response.body![2].conciergerie == 1 ? true : false,
        pharmacieEnable: response.body![5].pharmacie == 1 ? true : false,
        bonPlanEnable: response.body![4].bonPlans == 1 ? true : false,
        tourismeEnable: response.body![1].tourisme == 1 ? true : false,
        hotelReductionEnable:
            response.body![7].hotelReduction == 1 ? true : false);
    setModules(response.body!);
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  //SETTERS
  void setModules(List<ModuleModel> modules) {
    modulesList.value = modules;
  }

  //GETTERS
  RxList<ModuleModel> get modules => modulesList;
}
