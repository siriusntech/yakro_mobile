import 'package:flutter/material.dart';
import 'package:jaime_cocody/app/widgets/image_widget.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../Utils/app_constantes.dart';
import '../../../Utils/default_image.dart';
import '../../../widgets/text_widget.dart';
import '../actualite_model.dart';
import '../controllers/actualite_controller.dart';
import 'package:get/get.dart';

class ActualiteCardWidget extends StatelessWidget {
  final Actualite actualite;
  final VoidCallback? action;

  ActualiteCardWidget({required this.actualite, this.action});

  final controller = Get.find<ActualiteController>();

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: action,
      child: Card(
        elevation: 3,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextWidget(text: actualite.type.toString().toUpperCase(), fontWeight: FontWeight.bold, fontSize: 14,color: Colors.red,),
              SizedBox(height: 5,),
              Row(
                children: [
                  Image.asset(ICON_CALENDAR, width: 20, height: 20,),
                  SizedBox(width: 3,),
                  TextWidget(text: actualite.date.toString(), fontWeight: FontWeight.bold, fontSize: 15,color: Colors.grey,),
                ],
              ),
              SizedBox(height: 5,),
              TextWidget(text: actualite.titre.toString().toUpperCase(), fontWeight: FontWeight.bold, fontSize: 14,maxLine: 3,color: Colors.black,overFlow: TextOverflow.ellipsis),
              SizedBox(height: 5,),
              TextWidget(text: actualite.description, fontWeight: FontWeight.bold, fontSize: 16,maxLine: 4,color: Colors.grey,overFlow: TextOverflow.ellipsis,),
              SizedBox(height: 5,),
              Container(
                width: double.infinity,
                height: 250,
                child: ImageWidget(isNetWork: true, url:
                actualite.imageUrl, width: 250, height: 250, fit: BoxFit.cover,
                  default_image: DefaultImage.ACTUALITE,
                ),
              ),
              SizedBox(height: 2,),
            ],
          ),
        ),
      ),
    );
  }
}