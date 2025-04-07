import 'package:get/get.dart';
import 'package:jaime_yakro/Providers/path_providers.dart';

class CategorieBoutiqueController extends GetxController {
  final RxBool categorieBoutiqueLoading = false.obs;
  final RxList<CategorieBoutiqueModel> _categorieBoutiqueList =
      <CategorieBoutiqueModel>[].obs; //Tableau de categorie

  final CategorieBoutiqueService _categorieBoutiqueService =
      CategorieBoutiqueService();

  @override
  void onInit() {
    _categorieBoutiqueService.onInit();
    getAllCategorieBoutique();
    super.onInit();
  }

  //Get all categorieBoutique
  Future<void> getAllCategorieBoutique() async {
    categorieBoutiqueLoading.value = true;
    try {
      final response =
          await _categorieBoutiqueService.getAllCategorieBoutique();
      // print(response.body);
      if (response.statusCode == 200) {
        _categorieBoutiqueList.value = response.body!;
        categorieBoutiqueLoading.value = false;
      } else {
        categorieBoutiqueLoading.value = false;
      }
    } catch (e) {
      categorieBoutiqueLoading.value = false;
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

  List<CategorieBoutiqueModel> get categorieBoutiqueListGetter =>
      _categorieBoutiqueList;
}
