import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:mon_plateau/app/modules/actualite/widgets/actualite_card_widget.dart';

import '../../../Utils/app_constantes.dart';
import '../../../Utils/app_routes.dart';
import '../../../data/repository/data/Env.dart';
import '../../../widgets/loading_widget.dart';
import '../../../widgets/no_data_widget.dart';
import '../../../widgets/text_widget.dart';
import '../controllers/actualite_controller.dart';

class ActualiteView extends GetView<ActualiteController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: appbarColorFromCode,
        title:TextWidget(text: 'Actualités et Evènements',fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white,),
        actions: [
          IconButton(
              onPressed: (){
                controller.refresh();
              },
              icon: Icon(Icons.refresh, color: Colors.white, size: 30,)
          )
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async{
          controller.refresh();
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
                                    controller.refresh();
                                  }
                                },
                                child: Chip(
                                  elevation: 2.0,
                                  backgroundColor: type.nom.toString() == controller.selectedType.value ? Colors.amber : Colors.black26,
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
        onPressed: (){
          Get.toNamed(AppRoutes.HOME);
        },
        child: Icon(Icons.home, color: Colors.white, size: 40,),
      ),
    );
  }
}
