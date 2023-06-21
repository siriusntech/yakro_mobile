import 'dart:convert';
import 'dart:developer';
import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jaime_cocody/app/data/repository/data/api_status.dart';
import 'package:jaime_cocody/app/data/repository/hotel_services.dart';
import 'package:jaime_cocody/app/modules/hotel/hotel_model_model.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../Utils/app_constantes.dart';
import '../../../widgets/alerte_widgets.dart';
import '../../../widgets/text_widget.dart';

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

  final ButtonStyle buttonStyle = ButtonStyle(
      side: MaterialStateProperty.all(BorderSide(color: Colors.red)),
      shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)))
  );

  Future<Null> showAlerte(phoneNumber) async{
    Get.defaultDialog(
        title: "",
        content: Container(
          width: 100,
          height: 100,
          child: Column(
            children: [
              TextButton(
                onPressed: (){
                  Get.back();
                  _makePhoneCall('tel:$phoneNumber');
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(ICON_TELEPHONE, width: 20, height: 20,),
                    SizedBox(width: 3,),
                    TextWidget(text: 'Appeler', fontSize: 16, fontWeight: FontWeight.bold,alignement: TextAlign.center,)
                  ],
                ),
                style: buttonStyle,
              ),
              TextButton(
                onPressed: (){
                  Get.back();
                  _makeCopieNumber(phoneNumber);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(ICON_COPIE, width: 20, height: 20,),
                    SizedBox(width: 3,),
                    TextWidget(text: 'Copier', fontSize: 16, fontWeight: FontWeight.bold, alignement: TextAlign.center)
                  ],
                ),
                style: buttonStyle,
              ),
            ],
          ),
        ),
        contentPadding: EdgeInsets.all(0.0),
        titlePadding: EdgeInsets.all(0.0)
    );
  }
  Future<void> _makePhoneCall(String phoneNumber) async {
    await launch(phoneNumber);
  }
  Future<void> _makeCopieNumber(String phoneNumber) async {
    FlutterClipboard.copy(phoneNumber).then(( result ) {
      showSnackBar('', "Contact Copié dans le presse-papier", Colors.black);
    });
  }

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
