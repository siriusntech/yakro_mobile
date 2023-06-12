import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:jaime_cocody/app/Utils/app_colors.dart';

import '../../../Utils/app_constantes.dart';
import '../../../Utils/app_routes.dart';
import '../../../controllers/main_controller.dart';
import '../../../widgets/loading_widget.dart';
import '../../../widgets/no_data_widget.dart';
import '../../../widgets/text_widget.dart';
import '../controllers/pharmacie_controller.dart';
import '../widgets/pharmacie_card_widget.dart';

class PharmacieView extends GetView<PharmacieController> {
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
        title: TextWidget(text: 'Pharmacies de garde', fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
        leading: IconButton(
          onPressed: () {
           Get.back();
          },
          icon: Icon(Icons.arrow_back, color: Colors.white, size: 30),
        ),
        actions: [
          IconButton(
            onPressed: () async {
              await controller.refreshData();
            },
            icon: Icon(Icons.refresh, color: Colors.white, size: 30),
          )
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async{
          await controller.refreshData();
        },
        child: Container(
          color: settingsCtrl.gris,// Couleur d'arrière-plan définie ici
          child: Padding(
            padding: EdgeInsets.all(8),
            child: Column(
              children: [
                Obx(() => TextWidget(text: controller.periode.value, color: Colors.black,
                  fontSize: 18, fontWeight: FontWeight.bold, alignement: TextAlign.center,
                )),
                SizedBox(height: 5,),
                Expanded(
                  flex: context.isLandscape ? 5 : 2,
                  child: Column(
                    children: [
                      Expanded(
                        child: Container(
                          width: 300,
                          height: 45,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15)
                          ),
                          child: TextField(
                            decoration: InputDecoration(
                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
                              prefixIcon: Icon(Icons.search, color: Colors.black, size: 30,),
                              hintText: "Ex: Pharmacie du Commerce",
                            ),
                            style: TextStyle(color: Colors.black, fontSize: 14, fontWeight: FontWeight.bold,),
                            onChanged: (val){
                              if(val.length > 0){
                                controller.getPharmaciesByName(val);
                              }else{
                                controller.refreshData();
                              }
                            },
                          ),
                        ),
                      ),
                      Obx(() => Visibility(
                          visible: controller.zoneList.length > 1,
                          child: SizedBox(height: 3,)
                      )),
                      Obx(() => Visibility(
                        visible: controller.zoneList.length > 1,
                        child: Expanded(
                          child: ListView(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            children: [
                              Row(
                                children: [
                                  for(var zone in controller.zoneList) Card(
                                    elevation: 0.0,
                                    child: InkWell(
                                      onTap: () {
                                        if(controller.selectedZoneName.value == '' || controller.selectedZoneName.value != zone.nom!.toString()){
                                          controller.setSelectedZone(zone.id, zone.nom);
                                          controller.getPharmaciesByZone(zone.id);
                                        }else{
                                          controller.setSelectedZone(null, '');
                                          controller.refreshData();
                                        }
                                      },
                                      child: Chip(
                                        elevation: 4.0,
                                        backgroundColor: zone.nom.toString() == controller.selectedZoneName.value ? Colors.white : AppColors.vert_color,
                                        label: TextWidget(text: zone.nom.toString(),
                                          fontSize: 14, fontWeight: FontWeight.bold, scaleFactor: 1.2,
                                        ),
                                      ),
                                    ),
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
                                    color: Colors.transparent,
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ))
                    ],
                  ),
                ),
                SizedBox(height: 10,),
                Expanded(
                  flex: context.isLandscape ? 12 : 15,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Obx((){
                        if(controller.isDataProcessing.value == true){
                          return LoadingWidget();
                        } else {
                          if(controller.pharmacieList.length == 0){
                            return NoDataWidget();
                          } else {
                            return Expanded(
                                child: ListView.builder(
                                    padding: EdgeInsets.only(bottom: 20),
                                    itemCount: controller.pharmacieList.length,
                                    itemBuilder: (context, index) {
                                      var pharmacie = controller.pharmacieList[index];
                                      return PharmacieCardWidget(
                                          pharmacie: pharmacie,
                                          action: (){
                                            controller.setSelectedPharmacie(pharmacie);
                                            controller.setSelectedContacts(pharmacie.contacts!);
                                            Get.toNamed(AppRoutes.SHOW_PHARMACIE);
                                          }
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
