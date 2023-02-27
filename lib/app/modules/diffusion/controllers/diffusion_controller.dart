import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/repository/data/api_status.dart';
import '../../../data/repository/diffusion_services.dart';
import '../../home/controllers/home_controller.dart';
import '../diffusion_model.dart';

class DiffusionController extends GetxController {

  var diffusionList = List<Diffusion>.empty(growable: true).obs;
  var selectedDiffusion = Diffusion().obs;
  var page = 1;
  var isDataProcessing = false.obs;

  final HomeController homeCtrl = Get.find();



  // GET ALL DIFFUSION
  getDiffusions(var page) async{
    try{
      isDataProcessing(true);
      final response = await DiffusionServices.getDiffusions();
      if(response is Success){
        isDataProcessing(false);
        diffusionList.addAll(response.response as List<Diffusion>);
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

  // SET SELECTED DIFFUSION
  void setSelectedDiffusion(Diffusion diffusion){
    selectedDiffusion.value = diffusion;

    makeDiffusionsAsRead(diffusion.id);
  }
  // REFRESH PAGE
  void refresh(){
    diffusionList.clear();
    getDiffusions(page);
  }

  // SHOW SNACKBAR
  showSnackBar(String title, String message, Color bgColor){
    Get.snackbar(title, message, backgroundColor: bgColor,
        snackPosition: SnackPosition.BOTTOM, colorText: Colors.white);
  }

  // MAKE ALL AS READS
  makeDiffusionsAsRead(diffusion_id) async{
    try{
      final response = await DiffusionServices.makeDiffusionAsRead(diffusion_id);
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
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
}
