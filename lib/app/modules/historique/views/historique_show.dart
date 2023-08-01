import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jaime_yakro/app/widgets/image_widget%20_baseUrl.dart';
import 'package:jaime_yakro/app/widgets/text_widget.dart';
import '../../../Utils/app_routes.dart';
import '../../../controllers/main_controller.dart';
import '../../../widgets/image_widget.dart';
import '../../../widgets/loading_widget.dart';
import '../../../widgets/no_data_widget.dart';
import '../../zoom/controllers/zoom_controller.dart';
import '../../zoom/views/zoom_view.dart';
import '../controllers/historique_controller.dart';

import '../widgets/info_card_widget.dart';

class HistoriqueShow extends GetView<HistoriqueController> {

  final ZoomController zoomCtrl = Get.put(ZoomController());
  final MainController settingsCtrl = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextWidget(text: 'Les details de la Culture', fontSize: 20.0, fontWeight: FontWeight.bold,color:settingsCtrl.appbarTextColor ,),
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: settingsCtrl.vert_color_fonce,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(Icons.arrow_back, color: Colors.white, size: 30),
        ),
        actions: [
          IconButton(
              onPressed: () async{
                await controller.refreshData();
              },
              icon: Icon(Icons.refresh, color: Colors.white, size: 30,)
          ),


        ],
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
                      SelectableTextWidget(text: controller.selectedHistorique.value.titre, fontSize: 30, fontWeight: FontWeight.bold,),
                        SizedBox(height: 30,),
                      Container(
                        width: double.infinity,
                        height: 200,
                        child: GestureDetector(
                          child: ImageWidgetBaseUrl(url: controller.selectedHistorique.value.medias![0].url!, isNetWork: true,fit: BoxFit.contain,),
                          onTap: (){
                            zoomCtrl.setImageUrl(controller.selectedHistorique.value.medias![0].url!.toString());
                            Get.to(ZoomView(), fullscreenDialog: true);
                          },
                        )
                      ),
                      SizedBox(height: 30,),
                      SelectableTextWidget(text: controller.selectedHistorique.value.description.toString(), fontSize: 18,),

                    ],
                  ),
                ),
                controller.infosList.length > 0 ? Container(
                  decoration: BoxDecoration(
                    border: Border(top: BorderSide(color: Colors.grey, width: 1),)
                  ),
                  child: SelectableTextWidget(text: "Le saviez-vous ?", fontSize: 16, fontWeight: FontWeight.bold,),
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
