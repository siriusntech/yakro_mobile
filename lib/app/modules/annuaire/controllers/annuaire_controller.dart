import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../Utils/app_constantes.dart';
import '../../../data/repository/annuaire_services.dart';
import '../../../data/repository/data/api_status.dart';
import '../../../models/annuaire.dart';
import '../../../widgets/alerte_widgets.dart';
import '../../../widgets/text_widget.dart';

class AnnuaireController extends GetxController {

  var user_id = 0.obs;

  var annuaireList = List<Annuaire>.empty(growable: true).obs;

  var selectedAnnuaire = Annuaire().obs;

  var isDataProcessing = false.obs;

  getAnnuaires() async {
    try{
      SharedPreferences storage = await SharedPreferences.getInstance();
      user_id.value = storage.getInt('user_id') ?? 0;

      isDataProcessing(true);
      final response = await AnnuaireServices.getAnnuaires();
      if(response is Success){
        isDataProcessing(false);
        annuaireList.addAll(response.response as List<Annuaire>);
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

  setSelectedAnnuaire(Annuaire annuaire){
    selectedAnnuaire.value = annuaire;
  }

  // REFRESH PAGE
  void refresh(){
    annuaireList.clear();
    getAnnuaires();
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
    refresh();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
}
