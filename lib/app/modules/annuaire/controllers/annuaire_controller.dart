import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../Utils/app_constantes.dart';
import '../../../data/repository/annuaire_services.dart';
import '../../../data/repository/data/api_status.dart';
import '../../../data/repository/type_annuaire_services.dart';
import '../../../models/annuaire.dart';
import '../../../models/type_annuaire_model.dart';
import '../../../widgets/alerte_widgets.dart';
import '../../../widgets/text_widget.dart';

class AnnuaireController extends GetxController {

  var user_id = 0.obs;

  var annuaireList = List<Annuaire>.empty(growable: true).obs;
  var typeAnnuaireList = List<TypeAnnuaireModel>.empty(growable: true).obs;
  var selectedTypeAnnuaireName = ''.obs;
  var selectedAnnuaire = Annuaire().obs;

  var isDataProcessing = false.obs;

  getAnnuaires() async {
    try{
      SharedPreferences storage = await SharedPreferences.getInstance();
      user_id.value = storage.getInt('user_id') ?? 0;

      isDataProcessing(true);
      final response = await AnnuaireServices.getAnnuaires();
      if(response is Success){
        annuaireList.clear();
        isDataProcessing(false);
        annuaireList.addAll(response.response as List<Annuaire>);
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



  getAnnuairesByType(type_id) async {
    try{
      isDataProcessing(true);
      final response = await AnnuaireServices.getAnnuairesByType(type_id);
      if(response is Success){
        annuaireList.clear();
        isDataProcessing(false);
        annuaireList.addAll(response.response as List<Annuaire>);
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

  // SET SELECTED TYPE
  void setSelectedTypeAnnuaire(zoneId, zoneName){
    selectedTypeAnnuaireName.value = zoneName;
  }

  // GET ALL TYPES ANNUAIRES
  getTypesAnnuaire() async{
    try{
      isDataProcessing(true);
      final response = await TypeAnnuaireServices.getTypesAnnuaire();
      if(response is Success){
        isDataProcessing(false);
        typeAnnuaireList.clear();
        typeAnnuaireList.addAll(response.response as List<TypeAnnuaireModel>);
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

  setSelectedAnnuaire(Annuaire annuaire){
    selectedAnnuaire.value = annuaire;
  }

  // REFRESH PAGE
  refreshData() async{
    setSelectedTypeAnnuaire(null, '');
    annuaireList.clear();
    await getTypesAnnuaire();
    await getAnnuaires();
  }

final ButtonStyle buttonStyle = ButtonStyle(
    side: MaterialStateProperty.all(BorderSide(color: Colors.red)),
    shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)))
);

  Future<Null> showAlerte(phoneNumber) async{
    Get.defaultDialog(
        title: "",
        content: Container(
          width: 100,
          height: 100,
          child: Column(
            children: [
              TextButton(
                  onPressed: (){
                    Get.back();
                    _makePhoneCall('tel:$phoneNumber');
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(ICON_TELEPHONE, width: 20, height: 20,),
                      SizedBox(width: 3,),
                      TextWidget(text: 'Appeler', fontSize: 16, fontWeight: FontWeight.bold,alignement: TextAlign.center,)
                    ],
                  ),
                  style: buttonStyle,
              ),
              TextButton(
                  onPressed: (){
                    Get.back();
                    _makeCopieNumber(phoneNumber);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(ICON_COPIE, width: 20, height: 20,),
                      SizedBox(width: 3,),
                      TextWidget(text: 'Copier', fontSize: 16, fontWeight: FontWeight.bold, alignement: TextAlign.center)
                    ],
                  ),
                  style: buttonStyle,
              ),
            ],
          ),
        ),
        contentPadding: EdgeInsets.all(0.0),
        titlePadding: EdgeInsets.all(0.0)
    );
  }

  Future<void> _makePhoneCall(String phoneNumber) async {
    await launch(phoneNumber);
  }

  Future<void> _makeCopieNumber(String phoneNumber) async {
    FlutterClipboard.copy(phoneNumber).then(( result ) {
       showSnackBar('', "Contact Copié dans le presse-papier", Colors.black);
    });
  }

  @override
  void onInit() {
    super.onInit();
    refreshData();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {

  }
}
