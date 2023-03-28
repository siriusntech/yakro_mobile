import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:jaime_cocody/app/widgets/text_widget.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../Utils/app_constantes.dart';
import '../../../controllers/main_controller.dart';
import '../../../widgets/image_widget.dart';
import '../../../widgets/loading_widget.dart';
import '../controllers/nouscontactez_controller.dart';

class NouscontactezView extends GetView<NouscontactezController> {
  final MainController settingsCtrl = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextWidget(text: 'Nous contactez', fontSize: 20, fontWeight: FontWeight.bold,),
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: settingsCtrl.appbarColorFromCode,
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(5),
          child: Obx((){
            if(controller.isDataProcessing.value == true){
              return LoadingWidget();
            } else {
              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(height: 10,),
                  Flexible(
                      child: Container(
                        width: double.infinity,
                        height: 150,
                        child: ImageWidget(isNetWork: true, url: controller.entrepriseInfo.value.logo, fit: BoxFit.contain),
                      )
                  ),
                  Flexible(
                      child: ListTile(
                        leading: Icon(Icons.place),
                        title: TextWidget(text: "Adresse:", fontWeight: FontWeight.bold, fontSize: 18,),
                        subtitle: TextWidget(text: controller.entrepriseInfo.value.adresse,
                        fontSize: 18,),
                      )
                  ),
                  Divider(),
                  Flexible(
                      child: ListTile(
                        leading: Icon(Icons.mail),
                        title: TextWidget(text: "Email:", fontWeight: FontWeight.bold, fontSize: 18,),
                        subtitle: TextWidget(text: controller.entrepriseInfo.value.email,
                        fontSize: 18),
                      )
                  ),
                  Divider(),
                  Flexible(
                      child: ListTile(
                        leading: Icon(Icons.phone),
                        title: TextWidget(text: "Contact:", fontWeight: FontWeight.bold, fontSize: 18,),
                        subtitle: TextWidget(text: controller.entrepriseInfo.value.contact,
                        fontSize: 18),
                      )
                  ),
                  Divider(),
                  Flexible(
                      child: ListTile(
                        leading: Icon(Icons.phone),
                        title: TextWidget(text: "Site Internet:", fontWeight: FontWeight.bold, fontSize: 18,),
                        subtitle: InkWell(
                          onTap: (){
                            launch("https://sirius.com/");
                          },
                          child: TextWidget(text: "https://siriusntech.com", fontSize: 18, color: Colors.blue,),
                        ),
                      )
                  )
                ],
              );
            }
          })
        ),
      ),
    );
  }
}
