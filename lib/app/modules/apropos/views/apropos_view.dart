import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:jaime_cocody/app/widgets/text_widget.dart';

import '../../../Utils/app_constantes.dart';
import '../../../controllers/main_controller.dart';
import '../../../widgets/image_widget.dart';
import '../../../widgets/loading_widget.dart';
import '../controllers/apropos_controller.dart';

class AproposView extends GetView<AproposController> {
  final MainController settingsCtrl = Get.find();
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: TextWidget(text:'Apropos de nous', fontSize: 20, fontWeight: FontWeight.bold,),
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: settingsCtrl.appbarColorFromCode,
      ),
      body: Center(
        child: Obx((){
          if(controller.isDataProcessing.value == true){
            return LoadingWidget();
          } else {
            return ListView(
              padding: EdgeInsets.all(8),
              children: [
                Container(
                  child: ImageWidget(isNetWork: true, url: controller.entrepriseInfo.value.logo, fit: BoxFit.contain),
                ),
                TextWidget(text: controller.entrepriseInfo.value.presentation.toString().trim(),
                fontSize: 20,)
              ],
            );
          }
        })
      ),
    );
  }
}
