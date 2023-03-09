import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jaime_cocody/app/widgets/button_widget.dart';
import 'package:jaime_cocody/app/widgets/text_widget.dart';
import 'package:url_launcher/url_launcher.dart';

import '../Utils/app_constantes.dart';
import '../Utils/default_image.dart';

// SHOW SNACKBAR
showSnackBar(String title, String message, Color bgColor){
  Get.snackbar(title, message, backgroundColor: bgColor,
      snackPosition: SnackPosition.BOTTOM, colorText: Colors.white);
}

// SHOW ALERTE
showAlerte(String title, String message){
  Get.defaultDialog(
    title: title,
    titleStyle: TextStyle(fontSize: 16, color: Colors.black, fontWeight: FontWeight.bold),
    middleText: message,
    middleTextStyle: TextStyle(fontSize: 16, color: Colors.red, fontWeight: FontWeight.bold),
    textCancel: 'OK',
    cancelTextColor: Colors.red
  );
}
// PLAY SOUND ON NOTIFICATION
playSound() async {
  AssetsAudioPlayer audioPlayer = AssetsAudioPlayer();
  await audioPlayer.open(
    Audio(
      'assets/sound/single-press.mp3',
    ),
  );
}

// SHOW NOTICATION DIALOG
showNotificationBox(String title, String body, String action_url){
  Get.defaultDialog(
    barrierDismissible: false,
    title: title.toString().toUpperCase(),
    titleStyle: TextStyle(fontSize: 15, fontWeight: FontWeight.bold,),
    content: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        TextWidget(text: body, fontSize: 16,),
      ],
    ),
    actions: [
      IconButton(
          onPressed: (){
            Get.back();
          },
          icon: Icon(Icons.close, color: Colors.red, size: 25,),
        style: ButtonStyle(
          shape: MaterialStateProperty.all(RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              side: BorderSide(width: 1, color: Colors.red)
          )),
        )
      ),
      TextButtonWidget(text_widget: TextWidget(text: "OK", fontSize: 15, fontWeight: FontWeight.bold,),
        rounded: MaterialStateProperty.all(RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          side: BorderSide(width: 1, color: mainColor)
        )),
        action: () {
          Get.back();
          if(action_url == '/mise_a_jour'){
             launch('https://play.google.com/store/apps/details?id=com.siriusntech.jaime_cocody');
          }else{
            Get.toNamed(action_url);
          }
        },
      ),
    ],
  );
}
// SHOW NOTICATION DIALOG
showNotificationSnackBar(String title, String body, String action_url){
  Get.snackbar(
    title,
    body,
    icon: Image.asset(DefaultImage.LOGO),
    titleText: TextWidget(text: title, fontSize: 15, fontWeight: FontWeight.bold,),
    messageText: TextWidget(text: body, fontSize: 16),
    backgroundColor: Colors.white,
    borderColor: Colors.grey,
    borderWidth: 1,
    isDismissible: false,
    snackPosition: SnackPosition.TOP,
    // forwardAnimationCurve: Curves.elasticInOut,
    // reverseAnimationCurve: Curves.easeOut,
    borderRadius: 10,
    duration: Duration(seconds: 20),
    padding: EdgeInsets.all(8),
    margin: EdgeInsets.only(top: 80),
    onTap: (val){
      if(action_url == '/mise_a_jour'){
        launchUrl(Uri.parse('https://play.google.com/store/apps/details?id=com.siriusntech.jaime_cocody'));
      }else{
        Get.toNamed(action_url);
      }
      Get.back();
    },
  );
}

// SHOW NOTICATION BOTTOM SHEET
void showNotificationBottomSheet(String title, String body){
  Get.bottomSheet(
      SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(8),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            ),
          ),
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextWidget(text: title, fontSize: 14, fontWeight: FontWeight.bold,),
                SizedBox(height: 5,),
                TextWidget(text: body, fontSize: 16),
                SizedBox(height: 5,),
                TextButton(
                  child: TextWidget(text: "OK", fontSize: 14, fontWeight: FontWeight.bold,),
                  onPressed: () {
                    Get.back();
                  },
                )
              ],
            ),
          ),
        ),
      ),
      elevation: 15,
      isDismissible: false,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(35),
      ),
      enableDrag: false,
      clipBehavior: Clip.none
  );
}

// SHOW ALERTE ICONS
AlerteImage(String type){
  if(type.contains("Voirie")){
    return ICON_VOIRIE;
  }else if(type.contains("Securite")){
    return ICON_SECURITE;
  }else if(type.contains("Salubrite")){
    return ICON_SALUBRITE;
  }else{
    return ICON_ALERTE;
  }
}