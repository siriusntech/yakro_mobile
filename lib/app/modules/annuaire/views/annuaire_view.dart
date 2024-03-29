import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:jaime_yakro/app/modules/annuaire/widgets/annuaire_card_widget.dart';

import '../../../Utils/app_colors.dart';
import '../../../Utils/app_routes.dart';
import '../../../controllers/main_controller.dart';
import '../../../widgets/loading_widget.dart';
import '../../../widgets/no_data_widget.dart';
import '../../../widgets/text_widget.dart';
import '../controllers/annuaire_controller.dart';

class AnnuaireView extends GetView<AnnuaireController> {
  final MainController settingsCtrl = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextWidget(text: 'Numéros utiles',
          fontSize: 20,
          fontWeight: FontWeight.bold, color: Colors.white,
        ),
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
          )
        ],
      ),
      body: Center(
        child: RefreshIndicator(
          onRefresh: () async {
             await controller.refreshData();
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Obx(() => Visibility(
                    visible: controller.typeAnnuaireList.length > 1,
                    child: Expanded(
                      flex: 1,
                      child: ListView(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        children: [
                          Obx(() => Row(
                            children: [
                              for(var type in controller.typeAnnuaireList) Card(
                                elevation: 0.0,
                                child: InkWell(
                                  onTap: () {
                                    if(controller.selectedTypeAnnuaireName.value == '' || controller.selectedTypeAnnuaireName.value != type.nom!.toString()){
                                      controller.setSelectedTypeAnnuaire(type.id, type.nom);
                                      controller.getAnnuairesByType(type.id);
                                    }else{
                                      controller.setSelectedTypeAnnuaire(null, '');
                                      controller.refreshData();
                                    }
                                  },
                                  child: Chip(
                                    elevation: 0.0,
                                    backgroundColor: type.nom.toString() == controller.selectedTypeAnnuaireName.value ?  AppColors.vert_color_fonce : AppColors.vert_color,
                                    label: TextWidget(text: type.nom.toString(),
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
                    )
                )),
                Expanded(
                    flex: 16,
                    child: _ui()
                )
              ],
            ),
          ),
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

  _ui() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Obx(() {
          if (controller.isDataProcessing.value == true) {
            return LoadingWidget();
          } else {
            if (controller.annuaireList.length == 0) {
              return NoDataWidget();
            } else {
              return Expanded(
                  child: ListView.builder(
                      itemCount: controller.annuaireList.length,
                      itemBuilder: (context, index) {
                        var annuaire = controller.annuaireList[index];
                        return AnnuaireCardWidget(annuaire: annuaire);
                      }
                  )
              );
            }
          }
        })
      ],
    );
  }

}
