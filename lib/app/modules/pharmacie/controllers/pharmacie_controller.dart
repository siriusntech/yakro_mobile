import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jaime_yakro/app/models/zone_model.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../Utils/app_constantes.dart';
import '../../../data/repository/data/api_status.dart';
import '../../../data/repository/pharmacie_services.dart';
import '../../../data/repository/zone_services.dart';
import '../../../models/pharmacie_model.dart';
import '../../../widgets/text_widget.dart';

class PharmacieController extends GetxController {

  var pharmacieList = List<Pharmacie>.empty(growable: true).obs;
  var contactList = List<Contact>.empty(growable: true).obs;
  var selectedPharmacie = Pharmacie().obs;
  var zoneList = List<ZoneModel>.empty(growable: true).obs;
  var selectedZoneName = ''.obs;
  // var selectedPharmacieContactList = List<Contact>.empty(growable: true).obs;
  var page = 1;
  var isDataProcessing = false.obs;
  var selectedType = ''.obs;
  var periode = ''.obs;



  // GET ALL ZONES
  getZones() async{
    try{
      isDataProcessing(true);
      final response = await ZoneServices.getZones();
      if(response is Success){
        isDataProcessing(false);
        zoneList.clear();
        zoneList.addAll(response.response as List<ZoneModel>);
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

  // GET ALL PHARMACIE
  getPharmacies(var page) async{
    try{
      isDataProcessing(true);
      final response = await PharmacieServices.getPharmacies();
      if(response is Success){
        isDataProcessing(false);
        pharmacieList.addAll(response.response as List<Pharmacie>);
        if(pharmacieList.length > 0){
          periode.value = pharmacieList[0].periode!;
        }
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
  // GET ALL PHARMACIE BY NAME
  getPharmaciesByName(var name) async{
    try{
      isDataProcessing(true);
      final response = await PharmacieServices.getPharmaciesByNom(name);
      if(response is Success){
        pharmacieList.clear();
        isDataProcessing(false);
        pharmacieList.addAll(response.response as List<Pharmacie>);
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
  // GET ALL PHARMACIE BY Zone
  getPharmaciesByZone(zone_id) async{
    try{
      isDataProcessing(true);
      final response = await PharmacieServices.getPharmaciesByZone(zone_id);
      if(response is Success){
        pharmacieList.clear();
        isDataProcessing(false);
        pharmacieList.addAll(response.response as List<Pharmacie>);
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
  // SET SELECTED PHARMACIE
  void setSelectedPharmacie(Pharmacie pharmacie){
    selectedPharmacie.value = pharmacie;
  }
  // SET SELECTED CONTACTS
  void setSelectedContacts(List<Contact> list){
    contactList.clear();
    contactList.addAll(list);
  }
  // SET SELECTED ZONE
  void setSelectedZone(zoneId, zoneName){
    selectedZoneName.value = zoneName;
  }
  // REFRESH PAGE
  refreshData() async{
    setSelectedZone(null, '');
    pharmacieList.clear();
    await getZones();
    await getPharmacies(page);
  }

  void launchMap(String link){
    launchUrl(Uri.parse(link));
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


  @override
  void onInit(){
    super.onInit();
    getZones();
    getPharmacies(page);
  }
  @override
  void onReady() {
    super.onReady();
  }
  @override
  void onClose() {

  }
}
