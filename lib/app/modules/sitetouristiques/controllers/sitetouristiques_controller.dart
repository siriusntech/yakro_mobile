import 'dart:developer';

import 'package:clipboard/clipboard.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jaime_yakro/app/models/CategorieVt.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../Utils/app_constantes.dart';
import '../../../data/repository/data/api_status.dart';
import '../../../data/repository/site_touristique_services.dart';
import '../../../models/site_touristique.dart';
import '../../../widgets/alerte_widgets.dart';
import '../../../widgets/text_widget.dart';


class SitetouristiquesController extends GetxController {
  //TODO: Implement SitetouristiquesController
  var isLoading = true.obs;
  var isDataProcessingTypeVT = false.obs;
 
  var isDataProcessing = true.obs;
  var selectedType = ''.obs;
 
  final count = 0.obs;
  final visiteTouristiquesList = <DataVisiteTouristiqueModel>[].obs; // Utilisez une RxList pour observer les changements
  final vTAllTypeVT = <CategorieVT>[].obs;
  final type_vt_selected = 0.obs;



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
    final response = await VisiteTouristiqueServices.getVisitesTouristique(type_vt_selected.value);
    if (response is Success) {
      isDataProcessing(false);
      print('je suis dans getVisitesTouristiques');
      visiteTouristiquesList.value = response.response as List<DataVisiteTouristiqueModel>;
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

    Future<void> getButtonTypeVT() async {
    isDataProcessingTypeVT(true);
    final response = await VisiteTouristiqueServices.getButtonTypeVT();
    vTAllTypeVT.value = response;
    isDataProcessingTypeVT(false);
    isLoading.value = false;
  }


  // REFRESH PAGE
  refreshData() async{
    visiteTouristiquesList.clear();
    await getButtonTypeVT();
    await getVisitesTouristiques();
  }


}
