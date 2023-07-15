import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jaime_cocody/app/widgets/text_widget.dart';
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
        automaticallyImplyLeading: false,
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: settingsCtrl.vert_color_fonce,
        title:TextWidget(text:'A propos de nous', fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
            size: 30,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () async {
            },
            icon: Icon(
              Icons.refresh,
              color: Colors.white,
              size: 30,
            ),
          ),
        ],
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
