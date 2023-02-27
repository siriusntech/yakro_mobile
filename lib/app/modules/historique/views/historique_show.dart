import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:jaime_cocody/app/widgets/text_widget.dart';

import '../../../Utils/app_routes.dart';
import '../../../data/repository/data/Env.dart';
import '../../../widgets/image_widget.dart';
import '../../../widgets/loading_widget.dart';
import '../../../widgets/no_data_widget.dart';
import '../controllers/historique_controller.dart';
import '../widgets/historique_card_widget.dart';
import '../widgets/info_card_widget.dart';

class HistoriqueShow extends GetView<HistoriqueController> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextWidget(text: 'Culture', fontSize: 18, fontWeight: FontWeight.bold,),
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
                      SelectableTextWidget(text: controller.selectedHistorique.value.titre, fontSize: 16, fontWeight: FontWeight.bold,),
                      SizedBox(height: 6,),
                      SelectableTextWidget(text: controller.selectedHistorique.value.description.toString(), fontSize: 16,),
                      Container(
                        width: double.infinity,
                        height: 200,
                        child: ImageWidget(url: controller.selectedHistorique.value.medias![0].url!, isNetWork: true,fit: BoxFit.contain,),
                      )
                    ],
                  ),
                ),
                controller.infosList.length > 0 ? Container(
                  decoration: BoxDecoration(
                    border: Border(top: BorderSide(color: Colors.grey, width: 1),)
                  ),
                  child: SelectableTextWidget(text: "Le savie-vous ?", fontSize: 16, fontWeight: FontWeight.bold,),
                ): Container(),
                Container(
                  child: controller.isDataProcessing.value == true ?
                         LoadingWidget() :
                         controller.historiqueList.length == 0 ?
                         NoDataWidget() :
                         ListView.builder(
                             shrinkWrap: true,
                             physics: ClampingScrollPhysics(),
                             padding: EdgeInsets.all(8.0),
                             itemCount: controller.infosList.length,
                             itemBuilder: (context,index){
                               var information =  controller.infosList[index];
                               return InfoCardWidget(
                                 information: information,
                                 action: () async{
                                   controller.setSelectedInformation(information);
                                   await controller.makeInformationIsRead(information.id);
                                   Get.toNamed(AppRoutes.SHOW_INFORMATION);
                                 },
                               );
                             }
                         )
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
