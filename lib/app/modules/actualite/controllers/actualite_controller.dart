
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jaime_cocody/app/modules/home/controllers/home_controller.dart';

import '../../../data/repository/actualite_services.dart';
import '../../../data/repository/data/api_status.dart';
import '../actualite_model.dart';
import '../actualite_type_model.dart';

class ActualiteController extends GetxController {

  var actualiteList = List<Actualite>.empty(growable: true).obs;
  var actualiteTypesList = List<ActualiteType>.empty(growable: true).obs;
  var selectedActualite = Actualite().obs;
  var page = 1;
  var isDataProcessing = false.obs;
  var selectedType = ''.obs;

   final HomeController homeCtrl = Get.find();

  // GET ALL COMMERCE TYPES
  void getActualiteTypes() async{
    try{
      isDataProcessing(true);
      final response = await ActualiteServices.getActualitetypes();
      if(response is Success){
        isDataProcessing(false);
        actualiteTypesList.addAll(response.response as List<ActualiteType>);
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

  // GET ALL COMMERCE
  getActualites(var page) async{
    try{
      isDataProcessing(true);
      final response = await ActualiteServices.getActualites();
      if(response is Success){
        isDataProcessing(false);
        actualiteList.addAll(response.response as List<Actualite>);
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
  // GET ALL COMMERCE BY TYPE
  getActualitesByType(var type) async{
    try{
      isDataProcessing(true);
      final response = await ActualiteServices.getActualitesByType(type);
      if(response is Success){
        actualiteList.clear();
        isDataProcessing(false);
        actualiteList.addAll(response.response as List<Actualite>);
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

  // SET SELECTED COMMERCE
  void setSelectedActualite(Actualite actualite){
    selectedActualite.value = actualite;
  }
  // SET SELECTED TYPE
  void setSelectedType(var type){
    selectedType.value = type;
  }
  // REFRESH PAGE
  void refresh(){
    actualiteList.clear();
    actualiteTypesList.clear();
    setSelectedType('');
    getActualiteTypes();
    getActualites(page);
  }

  // SHOW SNACKBAR
  showSnackBar(String title, String message, Color bgColor){
    Get.snackbar(title, message, backgroundColor: bgColor,
        snackPosition: SnackPosition.BOTTOM, colorText: Colors.white);
  }

  // MAKE ALL AS READS
  makeActualitesAsRead() async{
    try{
      final response = await ActualiteServices.makeActualitesAsRead();
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

  @override
  void onInit() {
    super.onInit();
    refresh();

    makeActualitesAsRead();
    homeCtrl.getUnReadItemsCounts();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    makeActualitesAsRead();
    homeCtrl.getUnReadItemsCounts();
  }
}
