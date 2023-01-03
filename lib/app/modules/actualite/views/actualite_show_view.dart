import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../Utils/app_constantes.dart';
import '../../../Utils/default_image.dart';
import '../../../data/repository/data/Env.dart';
import '../../../widgets/image_widget.dart';
import '../controllers/actualite_controller.dart';

class ActualiteShowView extends GetView<ActualiteController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: appbarColorFromCode,
        title: Text("Actualités et Evènements",
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
              Text(controller.selectedActualite.value.type.toString().toUpperCase()+". "+controller.selectedActualite.value.date.toString().toUpperCase(),
                style: TextStyle(
                    color: Colors.blue,
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold
                ),
              ),
              Text(controller.selectedActualite.value.titre.toString().toUpperCase(),
                style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold
                ),
              ),
              SizedBox(height: 10.0,),
              Container(
                width: double.infinity,
                height: 250,
                child: ImageWidget(isNetWork: true, url:
                controller.selectedActualite.value.imageUrl, width: 250, height: 250, fit: BoxFit.cover,
                  default_image: DefaultImage.ACTUALITE,
                ),
              ),
              SizedBox(height: 15.0,),
              Text(controller.selectedActualite.value.description.toString(),
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.normal,
                ),
                maxLines: 150,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
