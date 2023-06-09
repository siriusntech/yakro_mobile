import 'dart:convert';
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

  final hotelList = <HotelModel>[].obs; // Utilisez une RxList pour observer les changements



  @override
  void onInit() {
    super.onInit();
    getHotels();
    fetchHotels();

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


  // GET ALL GET HOTELS
/*  void getHotels() async {
    try {
      isDataProcessing(true);
      final response = await HotelServices.getHotels();
      if (response is Success) {
        isDataProcessing(false);
        hotelList.addAll(response.response as List<HotelModel>);

      }
      if (response is Failure) {
        isDataProcessing(false);
        print("Erreur " + response.errorResponse.toString());
      }
    } catch(ex){
      isDataProcessing(false);
      print("Exception  " + ex.toString());
    }
  }*/

   getHotels() async {
    try {
      isDataProcessing(true);
      final response = await HotelServices.getHotels();
      if (response is Success) {
        isDataProcessing(false);
        hotelList.addAll(response.response as List<HotelModel>);

      }
      if (response is Failure) {
        isDataProcessing(false);
        print("Erreur " + response.errorResponse.toString());
      }
    } catch(ex){
      isDataProcessing(false);
      print("Exception  " + ex.toString());
    }
  }

  void fetchHotels() async {
    final response = await getHotels();
    if (response is Success) {
      final hotelModel = response.response as HotelModel;
      hotelList.value = [hotelModel]; // Mettez à jour la liste des hôtels avec les données reçues
    } else if (response is Failure) {
      final errorCode = response.code;
      final errorMessage = response.errorResponse;
      // Gérez les erreurs en fonction du code et du message
    }
  }









}

