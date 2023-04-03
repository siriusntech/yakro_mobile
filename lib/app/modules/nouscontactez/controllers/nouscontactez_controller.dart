import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/repository/data/api_status.dart';
import '../../../data/repository/main_services.dart';
import '../../../models/entreprise.dart';
import '../../../widgets/alerte_widgets.dart';

class NouscontactezController extends GetxController {

  var entrepriseInfo = Entreprise().obs;
  var isDataProcessing = false.obs;

  void getInfos() async{
    try{
      isDataProcessing(true);
      final response = await MainServices.getInfos();
      if(response is Success){
        isDataProcessing(false);
        entrepriseInfo.value = response.response as Entreprise;
      }
      if(response is Failure){
        isDataProcessing(false);
        print("Erreur "+response.errorResponse.toString());
      }
    }catch(ex){
      isDataProcessing(false);
      print("Exception  "+ex.toString());
    }
  }

  @override
  void onInit() {
    super.onInit();
    getInfos();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
}
