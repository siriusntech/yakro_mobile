import 'dart:io';

import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:mon_plateau/app/models/media.dart';
import 'package:mon_plateau/app/models/media.dart';

import '../../../Utils/app_routes.dart';
import '../../../data/repository/data/api_status.dart';
import '../../../data/repository/historique_services.dart';
import '../../../widgets/alerte_widgets.dart';
import '../../../widgets/text_widget.dart';
import '../historique_model.dart';
import '../information_model.dart';

class HistoriqueController extends GetxController {

  var user_id = 0.obs;

  var historiqueList = List<Historique>.empty(growable: true).obs;
  var infosList = List<Information>.empty(growable: true).obs;
  var allHistoriqueList = List<Historique>.empty(growable: true).obs;


  var selectedHistorique = Historique().obs;
  var selectedInformation = Information().obs;

  var isDataProcessing = false.obs;
  var isAllDataProcessing = false.obs;
  var isProcessing = false.obs;


  getHistoriques() async {
    try{
      SharedPreferences storage = await SharedPreferences.getInstance();
      user_id.value = storage.getInt('user_id') ?? 0;

      isDataProcessing(true);
      final response = await HistoriqueServices.getHistoriques(user_id.value);
      if(response is Success){
        isDataProcessing(false);
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


  getAllHistoriques() async {
    try{
      isAllDataProcessing(true);
      final response = await HistoriqueServices.getAllHistoriques(user_id.value);
      if(response is Success){
        isAllDataProcessing(false);
        allHistoriqueList.clear();
        allHistoriqueList.addAll(response.response as List<Historique>);
      }
      if(response is Failure){
        isAllDataProcessing(false);
        showSnackBar("Erreur", response.errorResponse.toString(), Colors.red);
      }
    }catch(ex){
      isAllDataProcessing(false);
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
        var index = historiqueList.indexWhere((element) => element.id == historique_id);
        historiqueList[index].is_read = 1;
      }
      if(response is Failure){
        showSnackBar("Erreur", response.errorResponse.toString(), Colors.red);
      }
    }catch(ex){
      showSnackBar("Exception", ex.toString(), Colors.red);
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


  likeHistorique(historique_id) async {
    try{
      final response = await HistoriqueServices.likeHistorique(historique_id, user_id.value);
      if(response is Success){
        final historique_index = allHistoriqueList.indexWhere((element) => element.id == historique_id);
        final _historique = allHistoriqueList[historique_index];
        manageLike(_historique, historique_index);
      }
      if(response is Failure){
        showSnackBar("Erreur", response.errorResponse.toString(), Colors.red);
      }
    }catch(ex){
      showSnackBar("Exception", ex.toString(), Colors.red);
    }
  }

  manageLike(Historique historique, index) async{
    if(historique.id != null){
      if(historique.liked == 2){
        historique.unLikeCount! > 0 ? historique.unLikeCount = historique.unLikeCount! - 1 : historique.unLikeCount = 0;
      }
      historique.liked = 1;
      historique.likeCount = historique.likeCount! + 1;

      allHistoriqueList.replaceRange(index, index+1, [historique]);
      historiqueList.replaceRange(index, index+1, [historique]);
      selectedHistorique.value = Historique();
      selectedHistorique.value = allHistoriqueList[index] == historique ? allHistoriqueList[index] : historiqueList[index];

    }
  }

  unLikeHistorique(historique_id) async {
    try{
      final response = await HistoriqueServices.unLikeHistorique(historique_id, user_id.value);
      if(response is Success){
        final historique_index = allHistoriqueList.indexWhere((element) => element.id == historique_id);
        final _historique = allHistoriqueList[historique_index];
        manageUnlike(_historique, historique_index);
      }
      if(response is Failure){
        showSnackBar("Erreur", response.errorResponse.toString(), Colors.red);
      }
    }catch(ex){
      showSnackBar("Exception", ex.toString(), Colors.red);
    }
  }

  manageUnlike(Historique historique, index) async{
    if(historique.liked == 1){
      historique.likeCount! > 0 ? historique.likeCount = historique.likeCount! - 1 : historique.likeCount = 0;
    }
    historique.liked = 2;
    historique.unLikeCount = historique.unLikeCount! + 1;

    allHistoriqueList.replaceRange(index, index+1, [historique]);
    historiqueList.replaceRange(index, index+1, [historique]);
    selectedHistorique.value = Historique();
    selectedHistorique.value = allHistoriqueList[index] == historique ? allHistoriqueList[index] : historiqueList[index];
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

    // makeHistoriquesAsRead();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    // makeHistoriquesAsRead();
  }


}
