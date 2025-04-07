import 'package:get/get.dart';
import 'package:jaime_yakro/Providers/path_providers.dart';

class PharmacieApiController extends GetxController {
  RxBool pharmacieLoading = false.obs;
  final MainController _mainController = Get.put(MainController());
  final PharmacieService _pharmacieService = PharmacieService();
  RxList<PharmacieModel> pharmacieList = <PharmacieModel>[].obs;
  RxList<ZoneModel> zoneList = <ZoneModel>[].obs;

  final VisiteApiController _visiteApiController =
      Get.put(VisiteApiController());

  @override
  void onInit() {
    _mainController.onInit();
    _pharmacieService.onInit();
    _visiteApiController.onInit();
    _visiteApiController.addVisite('pharmacie');
    getPharmacieList();
    getZoneList();
    super.onInit();
  }

  //get all Pharmacie
  Future<void> getPharmacieList() async {
    // print('==============GET ALL PHARMACIE==============');
    pharmacieLoading.value = true;
    try {
      final response = await _pharmacieService.getAllPharmacie();
      // print(response.body);
      if (response.statusCode == 200) {
        pharmacieList.value = response.body!;
        pharmacieLoading.value = false;
      } else {
        pharmacieLoading.value = false;
      }
    } catch (e) {
      pharmacieLoading.value = false;
    }
  }

  //get all Zone
  Future<void> getZoneList() async {
    // print('==============GET ALL ZONE==============');
    pharmacieLoading.value = true;
    try {
      final response = await _pharmacieService.getAllZone();
      // print(response.body);
      if (response.statusCode == 200) {
        zoneList.value = response.body!;
        pharmacieLoading.value = false;
      } else {
        pharmacieLoading.value = false;
      }
    } catch (e) {
      pharmacieLoading.value = false;
    }
  }

  //get all Pharmacie by Zone
  Future<void> getAllPharmacieByZone(int zoneId) async {
    pharmacieLoading.value = true;
    try {
      final response = await _pharmacieService.getAllPharmacieByZone(zoneId);
      // print(response.body);
      if (response.statusCode == 200) {
        pharmacieList.value = response.body!;
        pharmacieLoading.value = false;
      } else {
        pharmacieLoading.value = false;
      }
    } catch (e) {
      pharmacieLoading.value = false;
    }
  }

  @override
  void onReady() {
    _mainController.onInit();
    super.onReady();
  }

  @override
  void onClose() {
    _mainController.onClose();
    super.onClose();
  }
}
