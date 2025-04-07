import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jaime_yakro/Config/Theme/Constant/const_colors.dart';
import 'package:jaime_yakro/Screens/Modules/Hotel/path_hotel.dart';
import 'package:jaime_yakro/Screens/Modules/Reduction/reduction_path.dart';

import '../../../../Providers/path_providers.dart';

class TypeChambreHotelScreenController extends GetxController {
  Rx<Color> colorPrimary =  ConstColors.alertDanger.obs;
  Rx<Color> colorSecondary = Colors.amber.obs;
  final HotelSingleScreenController hotelSingleScreenController = Get.find();
  final HotelScreenController controllerHotelScreeen = Get.find();
  final ReservationScreenController controllerReservation = Get.find();
  TypeChambreHotel? typeChambreHotel ;
  RxBool isSwitched = false.obs;
  RxBool listTypeChambreLoading = false.obs;
  var selectedIndex = RxnInt(); // null au départ
  @override
  void onInit(){
    print("===========${hotelSingleScreenController.hotelModel.value.typeChambreHotels}==========}");
  this.typeChambreHotel = null;
    super.onInit();
  }



  void selectIndex(int index) {
    if (selectedIndex.value == index) {
      selectedIndex.value = null; // pour désélectionner si on clique encore
    } else {
      selectedIndex.value = index;
    }
    update();
  }

  void setChambreHotel(TypeChambreHotel typeChambreHotel){
    this.typeChambreHotel = typeChambreHotel;
    controllerReservation.setChambreHotel(typeChambreHotel);
    update();
  }

  @override
  void onReady(){
    super.onReady();
  }



  //Getter
  HotelModel get hotelModel => hotelSingleScreenController.hotelModel.value;
}