import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/repository/agenda_services.dart';
import '../../../data/repository/data/api_status.dart';
import '../../home/controllers/home_controller.dart';
import '../agenda_model.dart';
import '../agenda_type_model.dart';

class AgendaController extends GetxController {
  var agendaList = List<Agenda>.empty(growable: true).obs;
  var agendaTypesList = List<AgendaType>.empty(growable: true).obs;
  var selectedAgenda = Agenda().obs;
  var page = 1;
  var isDataProcessing = false.obs;
  var selectedType = ''.obs;
  var agendaTypes = ['Tout', 'Semaine'].obs;

  final HomeController homeCtrl = Get.find();


  // GET ALL COMMERCE
  getAgendas(var page) async{
    try{
      isDataProcessing(true);
      final response = await AgendaServices.getAgendas();
      if(response is Success){
        isDataProcessing(false);
        agendaList.addAll(response.response as List<Agenda>);
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
  // GET ALL COMMERCE BY WEEK
  getAgendasByWeek() async{
    try{
      isDataProcessing(true);
      final response = await AgendaServices.getAgendasByWeek();
      if(response is Success){
        agendaList.clear();
        isDataProcessing(false);
        agendaList.addAll(response.response as List<Agenda>);
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
  void setSelectedAgenda(Agenda agenda){
    selectedAgenda.value = agenda;
  }
  // SET SELECTED TYPE
  void setSelectedType(var type){
    selectedType.value = type;
  }
  // REFRESH PAGE
  void refresh(){
    agendaList.clear();
    agendaTypesList.clear();
    setSelectedType('');
    getAgendas(page);
  }



  // SHOW SNACKBAR
  showSnackBar(String title, String message, Color bgColor){
    Get.snackbar(title, message, backgroundColor: bgColor,
        snackPosition: SnackPosition.BOTTOM, colorText: Colors.white);
  }

  @override
  void onInit() {
    super.onInit();
    refresh();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {

  }
}
