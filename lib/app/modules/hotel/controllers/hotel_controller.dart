import 'dart:convert';
import 'dart:developer';
import 'package:get/get.dart';
import 'package:jaime_cocody/app/data/repository/data/api_status.dart';
import 'package:jaime_cocody/app/data/repository/hotel_services.dart';
import 'package:jaime_cocody/app/modules/hotel/hotel_model_model.dart';

class HotelController extends GetxController {
  var isLoading = true.obs;
  // var hotelList = <HotelModel>[].obs;

  // var hotelList = List<HotelModel>.empty(growable: true).obs;
  var selectedHotels = HotelModel().obs;
  var isDataProcessing = false.obs;
  var selectedType = ''.obs;
  final count = 0.obs;

  final hotelList =
      <DataHotelModel>[].obs; // Utilisez une RxList pour observer les changements

  @override
  void onInit() {
    super.onInit();
    getHotels();

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


  getHotels() async {
      isDataProcessing(true);
      final response = await HotelServices.getHotels();
      if (response is Success) {
        isDataProcessing(false);
        hotelList.addAll(response.response as List<DataHotelModel>);
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
    hotelList.clear();
    await getHotels();
  }


}
