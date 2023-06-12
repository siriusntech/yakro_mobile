import 'package:get/get.dart';

import '../../../data/repository/data/api_status.dart';
import '../../../data/repository/site_touristique_services.dart';
import '../../../models/site_touristique.dart';
import '../../hotel/hotel_model_model.dart';

class SitetouristiquesController extends GetxController {
  //TODO: Implement SitetouristiquesController
  var isLoading = true.obs;


  var isDataProcessing = false.obs;
  var selectedType = ''.obs;
  final count = 0.obs;

  final visiteTouristiquesList =
      <DataVisiteTouristiqueModel>[].obs; // Utilisez une RxList pour observer les changements

  @override
  void onInit() {
    super.onInit();
    getVisitesTouristiques();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;

  getVisitesTouristiques() async {
    isDataProcessing(true);
    final response = await VisiteTouristiqueServices.getVisitesTouristique();
    if (response is Success) {
      isDataProcessing(false);
      visiteTouristiquesList.addAll(response.response as List<DataVisiteTouristiqueModel>);
      isLoading.value = false;
    }
    if (response is Failure) {
      isDataProcessing(false);
      print("Erreur " + response.errorResponse.toString());
      isLoading.value = false;
    }
    isDataProcessing(false);
    // print("Exception  " + ex.toString());
    isLoading.value = false;
  }


  // REFRESH PAGE
  refreshData() async{
    visiteTouristiquesList.clear();
    await getVisitesTouristiques();
  }


}
