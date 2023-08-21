import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../Utils/app_constantes.dart';
import '../../../data/repository/data/api_status.dart';
import '../../../data/repository/main_services.dart';
import '../../../models/entreprise.dart';
import '../../../widgets/text_widget.dart';
import 'package:url_launcher/url_launcher.dart';

class NouscontactezController extends GetxController {

  var entrepriseInfo = Entreprise().obs;
  var isDataProcessing = false.obs;

  void getInfos() async{
    try{
      isDataProcessing(true);
      final response = await MainServices.getInfos();
      if(response is Success){
        isDataProcessing(false);
        entrepriseInfo.value = response.response as Entreprise;
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



  final ButtonStyle buttonStyle = ButtonStyle(
      side: MaterialStateProperty.all(BorderSide(color: Colors.red)),
      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))));
          
    Future<Null> showAlerte(phoneNumber) async {
    Get.defaultDialog(
        title: "",
        content: Container(
          width: 100,
          height: 100,
          child: Column(
            children: [
              TextButton(
                onPressed: () {
                  Get.back();
                  makePhoneCall('tel:$phoneNumber');
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      ICON_TELEPHONE,
                      width: 20,
                      height: 20,
                    ),
                    SizedBox(
                      width: 3,
                    ),
                    TextWidget(
                      text: 'Appeler',
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      alignement: TextAlign.center,
                    )
                  ],
                ),
                style: buttonStyle,
              ),
              TextButton(
                onPressed: () {
                  Get.back();
                  makeCopieNumber(phoneNumber);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      ICON_COPIE,
                      width: 20,
                      height: 20,
                    ),
                    SizedBox(
                      width: 3,
                    ),
                    TextWidget(
                        text: 'Copier',
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        alignement: TextAlign.center)
                  ],
                ),
                style: buttonStyle,
              ),
            ],
          ),
        ),
        contentPadding: EdgeInsets.all(0.0),
        titlePadding: EdgeInsets.all(0.0));
  }
    Future<void> makeCopieNumber(String phoneNumber) async {
    FlutterClipboard.copy(phoneNumber).then((result) {
      Get.snackbar('', "Contact Copié dans le presse-papier",
          snackPosition: SnackPosition.BOTTOM);
    });
  }

  Future<void> makePhoneCall(String phoneNumber) async {
    // final Uri launchUri = Uri(
    //   scheme: 'tel',
    //   path: phoneNumber,
    // );
    // await launch(launchUri.toString());
    await launchUrl(Uri.parse(phoneNumber));
  }

  @override
  void onInit() {
    super.onInit();
    getInfos();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
}
