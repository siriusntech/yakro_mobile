import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:mon_plateau/app/modules/annuaire/widgets/annuaire_card_widget.dart';

import '../../../Utils/app_routes.dart';
import '../../../widgets/loading_widget.dart';
import '../../../widgets/no_data_widget.dart';
import '../../../widgets/text_widget.dart';
import '../controllers/annuaire_controller.dart';

class AnnuaireView extends GetView<AnnuaireController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextWidget(text: 'Informations utiles',
          fontSize: 20,
          fontWeight: FontWeight.bold,),
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
      body: Center(
        child: RefreshIndicator(
          onRefresh: () async {
            controller.refresh();
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Expanded(
                  flex: 1,
                  child: ListView(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    children: [
                      controller.typeAnnuaireList.length > 0 ? Obx(() => Row(
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
                                  controller.refresh();
                                }
                              },
                              child: Chip(
                                elevation: 0.0,
                                backgroundColor: type.nom.toString() == controller.selectedTypeAnnuaireName.value ? Colors.amber : Colors.black26,
                                label: TextWidget(text: type.nom.toString(),
                                  fontSize: 14, fontWeight: FontWeight.bold, scaleFactor: 1.2,
                                ),
                              ),
                            ),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
                            color: Colors.transparent,
                          )
                        ],
                      )) : Container(),
                    ],
                  ),
                ),
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
