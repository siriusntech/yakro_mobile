import 'package:get/get.dart';
import 'package:jaime_yakro/Providers/path_providers.dart';

class ProduitBoutiqueController extends GetxController {
  final RxBool produitBoutiqueLoading = false.obs;
  final RxList<ProduitBoutiqueModel> _produitBoutiqueList =
      <ProduitBoutiqueModel>[].obs; //tableau de produit

  final RxList<ProduitBoutiqueModel> _produitBoutiqueListPub =
      <ProduitBoutiqueModel>[].obs;

  final ProduitBoutiqueService _produitBoutiqueService =
      ProduitBoutiqueService();
  @override
  void onInit() {
    _produitBoutiqueService.onInit();
    getAllProduitBoutique();
    getAllProduitBoutiqueByPub();
    super.onInit();
  }

  //Get All Produit
  Future<void> getAllProduitBoutique() async {
    // print('======GET ALL PRODUIT=======');
    produitBoutiqueLoading.value = true;
    try {
      final response = await _produitBoutiqueService.getAllProduitBoutique();
      // print(response.body);
      if (response.statusCode == 200) {
        _produitBoutiqueList.value = response.body!;
        produitBoutiqueLoading.value = false;
      } else {
        produitBoutiqueLoading.value = false;
      }
    } catch (e) {
      produitBoutiqueLoading.value = false;
    }
  }

  //get All produit by pub
  Future<void> getAllProduitBoutiqueByPub() async {
    // print('======GET ALL PRODUIT PUB=======');
    produitBoutiqueLoading.value = true;
    try {
      final response =
          await _produitBoutiqueService.getAllProduitBoutiqueByPub();
      // print(response.body);
      if (response.statusCode == 200) {
        _produitBoutiqueListPub.value = response.body!;
        produitBoutiqueLoading.value = false;
      } else {
        produitBoutiqueLoading.value = false;
      }
    } catch (e) {
      produitBoutiqueLoading.value = false;
    }
  }

  //Get all produit by CategorieBoutique Id
  Future<void> getAllProduitByCategorieBoutiqueId(
      int categorieBoutiqueId) async {
    produitBoutiqueLoading.value = true;
    try {
      final response = await _produitBoutiqueService
          .getAllProduitByCategorieBoutiqueId(categorieBoutiqueId);
      // print(response.body);
      if (response.statusCode == 200) {
        _produitBoutiqueList.value = response.body!;
        produitBoutiqueLoading.value = false;
      } else {
        produitBoutiqueLoading.value = false;
      }
    } catch (e) {
      produitBoutiqueLoading.value = false;
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

  //Getters
  List<ProduitBoutiqueModel> get produitBoutiqueListGetter =>
      _produitBoutiqueList;

  List<ProduitBoutiqueModel> get produitBoutiqueListPubGetter =>
      _produitBoutiqueListPub;
}
