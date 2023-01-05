
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../data/repository/data/api_status.dart';
import '../../../data/repository/historique_services.dart';
import '../../../widgets/alerte_widgets.dart';
import '../../home/controllers/home_controller.dart';
import '../historique_model.dart';
import '../information_model.dart';

class HistoriqueController extends GetxController {

  var user_id = 0.obs;

  var historiqueList = List<Historique>.empty(growable: true).obs;
  var infosList = List<Information>.empty(growable: true).obs;

  var selectedHistorique = Historique().obs;
  var selectedInformation = Information().obs;

  var isDataProcessing = false.obs;
  var isAllDataProcessing = false.obs;
  var isProcessing = false.obs;

  final HomeController homeCtrl = Get.find();

  getHistoriques() async {
    try{
      SharedPreferences storage = await SharedPreferences.getInstance();
      user_id.value = storage.getInt('user_id') ?? 0;

      isDataProcessing(true);
      final response = await HistoriqueServices.getHistoriques(user_id.value);
      if(response is Success){
        isDataProcessing(false);
        historiqueList.clear();
        historiqueList.addAll(response.response as List<Historique>);
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



  setSelectedHistorique(Historique historique){
    selectedHistorique.value = historique;
    infosList.clear();
    infosList.addAll(historique.informations ?? []);
  }

  setSelectedInformation(Information information){
    selectedInformation.value = information;
  }

  makeHistoriqueIsRead(historique_id) async{
    try{
      final response = await HistoriqueServices.makeHistoriqueIsRead(historique_id, user_id.value);
      if(response is Success){
        getRefreshHistoriques();
      }
      if(response is Failure){
        print("Erreur "+response.errorResponse.toString());
      }
    }catch(ex){
      print("Exception "+ex.toString());
    }
  }

  makeInformationIsRead(info_id) async{
    try{
      final response = await HistoriqueServices.makeInformationIsRead(info_id, user_id.value);
      if(response is Success){
        var index = infosList.indexWhere((element) => element.id == info_id);
        infosList[index].is_read = 1;
      }
      if(response is Failure){
        showSnackBar("Erreur", response.errorResponse.toString(), Colors.red);
      }
    }catch(ex){
      showSnackBar("Exception", ex.toString(), Colors.red);
    }
  }



  // MAKE ALL AS READS
  makeHistoriquesAsRead() async{
    try{
      final response = await HistoriqueServices.makeHistoriquesAsRead();
      if(response is Success){
        // refresh();
      }
      if(response is Failure){
        // isDataProcessing(false);
        // showSnackBar("Erreur", response.errorResponse.toString(), Colors.red);
      }
    }catch(ex){
      // isDataProcessing(false);
      // showSnackBar("Exception", ex.toString(), Colors.red);
    }
  }

  getRefreshHistoriques() async {
    try{
      final response = await HistoriqueServices.getHistoriques(user_id.value);
      if(response is Success){
        historiqueList.clear();
        historiqueList.addAll(response.response as List<Historique>);
      }
      if(response is Failure){
        print("Erreur "+response.errorResponse.toString());
      }
    }catch(ex){
      print("Exception "+ex.toString());
    }
  }

  // REFRESH PAGE
  void refresh(){
    historiqueList.clear();
    infosList.clear();
    // allHistoriqueList.clear();
    getHistoriques();
    // getAllHistoriques();
  }



  @override
  void onInit() {
    super.onInit();
    refresh();

    makeHistoriquesAsRead();
    homeCtrl.getUnReadItemsCounts();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    makeHistoriquesAsRead();
    homeCtrl.getUnReadItemsCounts();
  }


}
