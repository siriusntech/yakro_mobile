
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jaime_cocody/app/modules/commerce/commerce_model.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:clipboard/clipboard.dart';
import '../../../Utils/app_constantes.dart';
import '../../../data/repository/data/api_status.dart';
import '../../../widgets/text_widget.dart';
import '../../home/controllers/home_controller.dart';
import '../commerce_services.dart';
import '../commerce_type_model.dart';

class CommerceController extends GetxController {

  var commerceList = List<Commerce>.empty(growable: true).obs;
  var commerceTypesList = List<CommerceType>.empty(growable: true).obs;
  var selectedCommerce = Commerce().obs;
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
  getCommerceTypes() async{
    try{
      isDataProcessing(true);
      final response = await CommerceServices.getCommercetypes();
      if(response is Success){
        isDataProcessing(false);
        commerceTypesList.addAll(response.response as List<CommerceType>);
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
  getCommerces(var page) async{
    try{
      isDataProcessing(true);
      final response = await CommerceServices.getCommerces();
      if(response is Success){
        isDataProcessing(false);
        commerceList.addAll(response.response as List<Commerce>);
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
  getCommercesByType(var type) async{
    try{
      isDataProcessing(true);
      final response = await CommerceServices.getCommercesByType(type);
      if(response is Success){
        commerceList.clear();
        isDataProcessing(false);
        commerceList.addAll(response.response as List<Commerce>);
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
  getCommercesByName(var name) async{
    try{
      isDataProcessing(true);
      final response = await CommerceServices.getCommercesByNom(name);
      if(response is Success){
        commerceList.clear();
        isDataProcessing(false);
        commerceList.addAll(response.response as List<Commerce>);
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
  void setSelectedCommerce(Commerce commerce){
    selectedCommerce.value = commerce;
  }
  // SET SELECTED TYPE
  void setSelectedType(var type){
    selectedType.value = type;
  }
  // REFRESH PAGE
  refreshData() async{
    if(searchTextController.text == ""){
      commerceList.clear();
      commerceTypesList.clear();
      clearFields();
      setSelectedType('');
      await getCommerceTypes();
      await getCommerces(page);
    }else{
      await getCommercesByName(searchTextController.text);
    }
  }

  refreshOnly() async{
    commerceList.clear();
    commerceTypesList.clear();
    setSelectedType('');
    await getCommerceTypes();
    await getCommerces(page);
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
    await launchUrl(Uri.parse(phoneNumber));
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
  makeCommercesAsRead() async{
    try{
      final response = await CommerceServices.makeCommercesAsRead();
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
    getCommerces(page);
    getCommerceTypes();

    makeCommercesAsRead();
    homeCtrl.getUnReadItemsCounts();
  }
  @override
  void onReady() {
    super.onReady();
  }
  @override
  void onClose() {
    makeCommercesAsRead();
    homeCtrl.getUnReadItemsCounts();
  }
}
