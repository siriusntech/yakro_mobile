import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:mon_plateau/app/widgets/text_widget.dart';

import '../../../Utils/default_image.dart';
import '../../../data/repository/data/Env.dart';
import '../../../widgets/image_widget.dart';
import '../controllers/historique_controller.dart';

class InformationShow extends GetView<HistoriqueController> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextWidget(text: 'Bon à savoir', fontSize: 18, fontWeight: FontWeight.bold,),
        centerTitle: true,
        elevation: 0.0,
      ),
      body: SafeArea(
        child: Obx(() => Padding(
            padding: EdgeInsets.all(8.0),
            child: ListView(
              // shrinkWrap: true,
              // physics: ClampingScrollPhysics(),
              children: [
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SelectableTextWidget(text: controller.selectedInformation.value.titre, fontSize: 16, fontWeight: FontWeight.bold,),
                      SizedBox(height: 6,),
                      SelectableTextWidget(text: controller.selectedInformation.value.description.toString(), fontSize: 16,),
                      Container(
                        width: double.infinity,
                        height: 200,
                        child: ImageWidget(isNetWork: true, url:
                        controller.selectedInformation.value.medias![0].url, default_image: DefaultImage.BON_A_SAVOIR,
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      )
    );
  }
}
