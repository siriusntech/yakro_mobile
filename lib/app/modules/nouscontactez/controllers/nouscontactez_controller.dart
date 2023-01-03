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
        showSnackBar("Erreur", response.errorResponse.toString(), Colors.red);
      }
    }catch(ex){
      isDataProcessing(false);
      showSnackBar("Exception", ex.toString(), Colors.red);
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
