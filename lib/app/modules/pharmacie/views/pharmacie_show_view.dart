import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../Utils/app_constantes.dart';
import '../../../Utils/default_image.dart';
import '../../../controllers/main_controller.dart';
import '../../../widgets/image_widget.dart';
import '../../../widgets/text_widget.dart';
import '../../zoom/controllers/zoom_controller.dart';
import '../../zoom/views/zoom_view.dart';
import '../controllers/pharmacie_controller.dart';

class PharmacieShowView extends GetView<PharmacieController> {
  final ZoomController zoomCtrl = Get.put(ZoomController());
  final MainController settingsCtrl = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: settingsCtrl.vert_color_fonce,
        title: Center(
          child: Obx(() => Text(controller.selectedPharmacie.value.nom.toString(),
            style: TextStyle(
              fontSize: 16.0,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          )),
        ), leading: IconButton(
        onPressed: () {
          Get.back();
        },
        icon: Icon(Icons.arrow_back, color: Colors.white, size: 30),
      ),
        actions: [
          IconButton(
            onPressed: () async {
              await controller.refreshData();
            },
            icon: Icon(Icons.refresh, color: Colors.white, size: 30),
          )
        ],
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Obx(() => ListView(
            children: [
              Container(
                width: 250,
                height: 250,
                child: GestureDetector(
                  child: ImageWidget(isNetWork: true, url:
                  controller.selectedPharmacie.value.photo, width: 250, height: 250,
                    default_image: DefaultImage.PHARMACIE, fit: BoxFit.contain,
                  ),
                  onTap: (){
                    zoomCtrl.setImageUrl(controller.selectedPharmacie.value.photo.toString());
                    Get.to(ZoomView(), fullscreenDialog: true);
                  },
                )
              ),
              SizedBox(height: 10,),
              TextWidget(text: controller.selectedPharmacie.value.medecin, fontSize: 19, alignement: TextAlign.center, fontWeight: FontWeight.w600, color: mainColorYakro,),
              SizedBox(height: 10,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  for(var ct in controller.contactList)
                    TextButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                  side: BorderSide(color: Colors.grey)
                              )
                          )
                      ),
                      onPressed: (){
                         controller.showAlerte(ct.numero.toString());
                      },
                      child: TextWidget(text: ct.numero.toString(), fontSize: 18, color: Colors.black,),
                  )
                ],
              ),
              SizedBox(height: 10,),
              TextWidget(text: "Adresse: ", fontSize: 18, alignement: TextAlign.center, fontWeight: FontWeight.w600, color: Colors.red,),
              TextWidget(text: controller.selectedPharmacie.value.adresse, fontSize: 18, alignement: TextAlign.center, fontWeight: FontWeight.w600, color: Colors.blue,),
              SizedBox(height: 15,),
              TextButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                              side: BorderSide(color: Colors.grey)
                          )
                      )
                  ),
                  onPressed: (){
                    controller.launchMap(controller.selectedPharmacie.value.localisation.toString());
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.map, color: Colors.red,),
                      TextWidget(text: "Afficher sur la carte google", fontSize: 18, color: Colors.deepOrange, fontWeight: FontWeight.w600,),
                    ],
                  )
              )
            ],
          )),
        ),
      ),
    );
  }
}
