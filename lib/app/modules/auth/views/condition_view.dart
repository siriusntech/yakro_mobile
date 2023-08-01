import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:jaime_yakro/app/Utils/app_constantes.dart';

import '../../../widgets/image_widget.dart';
import '../../../widgets/text_widget.dart';
import '../controllers/auth_controller.dart';

class ConditionView extends GetView {

  final AuthController authCtrl = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextWidget(text:"Conditions d'utilisation", fontSize: 20, fontWeight: FontWeight.bold,),
        centerTitle: true,
        elevation: 0.0,
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(15),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  height: 180,
                  child: ImageWidget(isNetWork: false, url: LOGO_SIRIUS,fit: BoxFit.cover,),
                ),
                TextWidget(text: "Les conditions d'utilisations", color: Colors.red,
                  fontSize: 25, alignement: TextAlign.center, fontWeight: FontWeight.bold
                ),
                SizedBox(height: 5,),
                TextWidget(text: authCtrl.condition_of_use.toString().trim(),
                  fontSize: 20, alignement: TextAlign.justify,
                ),
                Divider(),
                TextWidget(text: "La politique de confidentialité", color: Colors.red,
                    fontSize: 25, alignement: TextAlign.center, fontWeight: FontWeight.bold
                ),
                SizedBox(height: 5,),
                TextWidget(text: authCtrl.politique.toString().trim(),
                  fontSize: 20, alignement: TextAlign.justify,
                ),
                TextWidget(text: ''),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
