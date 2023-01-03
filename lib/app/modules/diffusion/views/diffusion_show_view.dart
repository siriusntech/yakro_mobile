import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../Utils/app_constantes.dart';
import '../../../Utils/default_image.dart';
import '../../../widgets/image_widget.dart';
import '../../../widgets/text_widget.dart';
import '../controllers/diffusion_controller.dart';

class DiffusionShowView extends GetView<DiffusionController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: appbarColorFromCode,
        title: Text("Détails de notifcation",
          style: TextStyle(
              fontSize: 18.0,
              color: Colors.white,
              fontWeight: FontWeight.bold
          ),
        ),
        actions: [
          IconButton(
              onPressed: (){

              },
              icon: Icon(Icons.delete, color: Colors.red,)
          ),
        ],
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextWidget(text: '#'+controller.selectedDiffusion.value.objet.toString(), fontWeight: FontWeight.bold, fontSize: 14,color: Colors.blue,),
                  SizedBox(height: 5,),
                  Row(
                    children: [
                      SizedBox(width: 3,),
                      Image.asset(ICON_CALENDAR,
                        width: 25,
                        height: 25,
                      ),
                      SizedBox(width: 10,),
                      TextWidget(text: controller.selectedDiffusion.value.date, fontWeight: FontWeight.w600, color: Colors.black,),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 5,),
              Padding(
                padding: const EdgeInsets.only(left: 3.0),
                child: Text(controller.selectedDiffusion.value.message!, overflow: TextOverflow.ellipsis, textScaleFactor: 1.2,
                  style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey),
                  maxLines: 150,
                ),
              ),
              SizedBox(height: 5,),
              Container(
                width: double.infinity,
                height: 250,
                child: ImageWidget(isNetWork: true, url:
                controller.selectedDiffusion.value.imageUrl, width: 250, height: 250, fit: BoxFit.cover,
                  default_image: DefaultImage.DIFFUSION,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
