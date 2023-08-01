import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jaime_yakro/app/controllers/main_controller.dart';
import 'package:jaime_yakro/app/modules/actualite/widgets/actualite_card_widget.dart';
import '../../../Utils/app_colors.dart';
import '../../../Utils/app_routes.dart';
import '../../../widgets/loading_widget.dart';
import '../../../widgets/no_data_widget.dart';
import '../../../widgets/text_widget.dart';
import '../controllers/actualite_controller.dart';

class ActualiteView extends GetView<ActualiteController> {

  final MainController settingsCtrl = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
            appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: settingsCtrl.vert_color_fonce,
        title:TextWidget(text: 'Actualités et événements',fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white,),
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
          )
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async{
          controller.refreshData();
        },
        child: Column(
          children: [
            Expanded(
              flex: context.isLandscape ? 2 : 1,
              child: Column(
                children: [
                  Flexible(
                    child: ListView(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      children: [
                        Obx(() => Row(
                          children: [
                            for(var type in controller.actualiteTypesList) Card(
                              elevation: 0.0,
                              child: InkWell(
                                onTap: () {
                                  if(controller.selectedType.value == '' || controller.selectedType.value != type.nom.toString()){
                                    controller.setSelectedType(type.nom.toString());
                                    controller.getActualitesByType(type.nom.toString());
                                  }else{
                                    controller.setSelectedType('');
                                    controller.refreshData();
                                  }
                                },
                                child: Chip(
                                  elevation: 2.0,
                                  backgroundColor: type.nom.toString() == controller.selectedType.value ? Colors.amber : AppColors.chip_color,
                                  label: TextWidget(text: type.nom.toString().toLowerCase(),
                                    fontSize: 14, fontWeight: FontWeight.bold, scaleFactor: 1.2,
                                  ),
                                ),
                              ),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
                              color: Colors.transparent,
                            )
                          ],
                        )),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: context.isLandscape ? 12 : 14,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Obx((){
                    if(controller.isDataProcessing.value == true){
                      return LoadingWidget();
                    } else {
                      if(controller.actualiteList.length == 0){
                        return NoDataWidget();
                      } else {
                        return Expanded(
                            child: ListView.builder(
                                itemCount: controller.actualiteList.length,
                                itemBuilder: (context, index) {
                                  var actualite = controller.actualiteList[index];
                                  return ActualiteCardWidget(
                                      actualite: actualite,
                                      action: (){
                                        controller.setSelectedActualite(actualite);
                                        Get.toNamed(AppRoutes.SHOW_ACTUALITE);
                                      },
                                  );
                                }
                            )
                        );
                      }
                    }
                  })
                ],
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: settingsCtrl.vert_color_fonce,
        onPressed: (){
          Get.toNamed(AppRoutes.HOME);
        },
        child: Icon(Icons.home, color: Colors.white, size: 40,),
      ),
    );
  }
}
