import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../Utils/app_constantes.dart';
import '../../../Utils/default_image.dart';
import '../../../data/repository/data/Env.dart';
import '../../../widgets/image_widget.dart';
import '../../../widgets/text_widget.dart';
import '../controllers/commerce_controller.dart';

class CommerceShowView extends GetView<CommerceController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: appbarColorFromCode,
        title: Text("Commerces et autres",
          style: TextStyle(
              fontSize: 18.0,
              color: Colors.white,
              fontWeight: FontWeight.bold
          ),
        ),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: ListView(
            children: [
              Container(
                width: MediaQuery.of(context).size.width - 50,
                child: TextWidget(text: controller.selectedCommerce.value.type.toString().toUpperCase(), fontWeight: FontWeight.w600,
                  fontSize: 15,maxLine: 50,
                ),
              ),
              SizedBox(height: 5,),
              Row(
                children: [
                  Image.asset(ICON_STORE, width: 20, height: 20,),
                  SizedBox(width: 3,),
                  Container(
                    width: MediaQuery.of(context).size.width - 50,
                    child: TextWidget(text: controller.selectedCommerce.value.nom.toString().toUpperCase(), fontWeight: FontWeight.w600,
                      fontSize: 15,maxLine: 50,
                    ),
                  )
                ],
              ),
              SizedBox(height: 5.0,),
              Row(
                children: [
                  Image.asset(ICON_NAME, width: 20, height: 20,),
                  SizedBox(width: 3,),
                  Container(
                    width: MediaQuery.of(context).size.width - 50,
                    child: TextWidget(text: controller.selectedCommerce.value.responsable.toString().toUpperCase(), fontWeight: FontWeight.w600,
                      fontSize: 15,maxLine: 50, color: Colors.grey,
                    ),
                  )
                ],
              ),
              SizedBox(height: 5,),
              InkWell(
                onTap: (){
                  controller.showAlerte(controller.selectedCommerce.value.contact.toString());
                },
                child: Row(
                  children: [
                    Image.asset(ICON_TELEPHONE, width: 20, height: 20,),
                    SizedBox(width: 3,),
                    TextWidget(text: controller.selectedCommerce.value.contact.toString(), fontWeight: FontWeight.bold, fontSize: 14,color: Colors.blue,),
                  ],
                ),
              ),
              SizedBox(height: 10.0,),
              Container(
                width: double.infinity,
                height: 250,
                child: ImageWidget(isNetWork: true, url:
                controller.selectedCommerce.value.imageUrl, width: 250, height: 250, fit: BoxFit.cover,
                  default_image: DefaultImage.COMMERCE,
                ),
              ),
              SizedBox(height: 15.0,),
              Text(controller.selectedCommerce.value.description.toString(),
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.normal,
                ),
                maxLines: 150,
              ),
              Divider(),
              TextButton(
                onPressed: (){
                  // MapsLauncher.launchCoordinates(double.parse(controller.selectedCommerce.value.longitude!), double.parse(controller.selectedCommerce.value.latitude!), controller.selectedCommerce.value.nom);
                  launch(controller.selectedCommerce.value.lien.toString());
                },
                child: Row(
                  children: [
                    Icon(Icons.map, color: Colors.red,),
                    TextWidget(text:"Itinéraire",
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.red,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );;
  }
}
