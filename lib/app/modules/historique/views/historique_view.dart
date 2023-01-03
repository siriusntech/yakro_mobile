import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:mon_plateau/app/widgets/text_widget.dart';

import '../../../Utils/app_routes.dart';
import '../../../widgets/loading_widget.dart';
import '../../../widgets/no_data_widget.dart';
import '../controllers/historique_controller.dart';
import '../widgets/historique_card_widget.dart';

class HistoriqueView extends GetView<HistoriqueController> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextWidget(text: 'Bon à savoir', fontSize: 18, fontWeight: FontWeight.bold,),
        centerTitle: true,
        elevation: 0.0,
        actions: [
          IconButton(
              onPressed: (){
                controller.refresh();
              },
              icon: Icon(Icons.refresh, color: Colors.white, size: 30,)
          )
        ],
      ),
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async{
            controller.refresh();
          },
          child: Obx((){
            if(controller.isDataProcessing.value == true){
              return LoadingWidget();
            } else {
              if(controller.historiqueList.length == 0){
                return NoDataWidget();
              } else {
                return ListView.builder(
                    padding: EdgeInsets.all(8.0),
                    itemCount: controller.historiqueList.length,
                    itemBuilder: (context,index){
                      var historique =  controller.historiqueList[index];
                      return HistoriqueCardWidget(
                        historique: historique,
                        action: () async{
                          controller.setSelectedHistorique(historique);
                          await controller.makeHistoriqueIsRead(historique.id);
                          Get.toNamed(AppRoutes.SHOW_HISTORIQUE);
                        },
                      );
                    }
                );
              }
           }
          }),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Get.toNamed(AppRoutes.HOME);
        },
        child: Icon(Icons.home, color: Colors.white, size: 40,),
      ),
    );
  }
}
