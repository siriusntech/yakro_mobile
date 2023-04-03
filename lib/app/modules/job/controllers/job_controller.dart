import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../Utils/app_constantes.dart';
import '../../../data/repository/data/api_status.dart';
import '../../../widgets/text_widget.dart';
import '../../home/controllers/home_controller.dart';
import '../job_model.dart';
import '../job_services.dart';
import '../job_type_model.dart';


class JobController extends GetxController {

  var jobList = List<JobModel>.empty(growable: true).obs;
  var jobTypesList = List<JobTypeModel>.empty(growable: true).obs;
  var selectedJob = JobModel().obs;
  var page = 1;
  var isDataProcessing = false.obs;
  var selectedType = ''.obs;

  final HomeController homeCtrl = Get.find();

  late TextEditingController searchTextController;

  initFields() async{
    searchTextController  = TextEditingController();
  }

  disposeFields(){
    searchTextController.dispose();
  }

  clearFields(){
    searchTextController.clear();
  }

  // GET ALL COMMERCE TYPES
  getJobTypes() async{
    try{
      isDataProcessing(true);
      final response = await JobServices.getJobtypes();
      if(response is Success){
        isDataProcessing(false);
        jobTypesList.addAll(response.response as List<JobTypeModel>);
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


  // GET ALL COMMERCE
  getJobs(var page) async{
    try{
      isDataProcessing(true);
      final response = await JobServices.getJobs();
      if(response is Success){
        isDataProcessing(false);
        jobList.addAll(response.response as List<JobModel>);
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
  // GET ALL COMMERCE BY TYPE
  getJobsByType(var type) async{
    try{
      isDataProcessing(true);
      final response = await JobServices.getJobsByType(type);
      if(response is Success){
        jobList.clear();
        isDataProcessing(false);
        jobList.addAll(response.response as List<JobModel>);
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
  // GET ALL COMMERCE BY NAME
  getJobsByName(var name) async{
    try{
      isDataProcessing(true);
      final response = await JobServices.getJobsByNom(name);
      if(response is Success){
        jobList.clear();
        isDataProcessing(false);
        jobList.addAll(response.response as List<JobModel>);
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
  // SET SELECTED COMMERCE
  void setSelectedJob(JobModel job){
    selectedJob.value = job;
  }
  // SET SELECTED TYPE
  void setSelectedType(var type){
    selectedType.value = type;
  }
  // REFRESH PAGE
  refreshData() async{
    if(searchTextController.text == ""){
      jobList.clear();
      jobTypesList.clear();
      clearFields();
      setSelectedType('');
      await getJobTypes();
      await getJobs(page);
    }else{
      await getJobsByName(searchTextController.text);
    }
  }

  Future<Null> showAlerte(phoneNumber) async{
    return Get.defaultDialog(
        title: '',
        content: Container(
          child: Column(
            children: [
              TextButton(
                  onPressed: (){
                    Get.back();
                    makePhoneCall('tel:$phoneNumber');
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(ICON_TELEPHONE, width: 20, height: 20,),
                      SizedBox(width: 3,),
                      TextWidget(text: 'Appeler', fontSize: 16, fontWeight: FontWeight.bold,alignement: TextAlign.center,)
                    ],
                  )
              ),
              TextButton(
                  onPressed: (){
                    Get.back();
                    makeCopieNumber(phoneNumber);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(ICON_COPIE, width: 20, height: 20,),
                      SizedBox(width: 3,),
                      TextWidget(text: 'Copier', fontSize: 16, fontWeight: FontWeight.bold, alignement: TextAlign.center)
                    ],
                  )
              ),
            ],
          ),
        ));
  }

  Future<void> makePhoneCall(String phoneNumber) async {
    // final Uri launchUri = Uri(
    //   scheme: 'tel',
    //   path: phoneNumber,
    // );
    // await launch(launchUri.toString());
    await launch(phoneNumber);
  }

  Future<void> makeCopieNumber(String phoneNumber) async {
    FlutterClipboard.copy(phoneNumber).then(( result ) {
      Get.snackbar('', "Contact Copié dans le presse-papier", snackPosition: SnackPosition.BOTTOM);
    });
  }
  // SHOW SNACKBAR
  showSnackBar(String title, String message, Color bgColor){
    Get.snackbar(title, message, backgroundColor: bgColor,
        snackPosition: SnackPosition.BOTTOM, colorText: Colors.white);
  }

  // MAKE ALL AS READS
  makeJobsAsRead() async{
    try{
      final response = await JobServices.makeJobsAsRead();
      if(response is Success){
        // refresh();
      }
      if(response is Failure){
        // isDataProcessing(false);
        // print("Erreur "+response.errorResponse.toString());
      }
    }catch(ex){
      // isDataProcessing(false);
      // print("Exception  "+ex.toString());
    }
  }


  @override
  void onInit(){
    super.onInit();
    initFields();
    getJobs(page);
    getJobTypes();

    makeJobsAsRead();
    homeCtrl.getUnReadItemsCounts();
  }
  @override
  void onReady() {
    super.onReady();
  }
  @override
  void onClose() {
    makeJobsAsRead();
    homeCtrl.getUnReadItemsCounts();
  }

}
