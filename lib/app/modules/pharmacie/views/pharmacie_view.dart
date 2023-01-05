import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../Utils/app_constantes.dart';
import '../../../Utils/app_routes.dart';
import '../../../widgets/loading_widget.dart';
import '../../../widgets/no_data_widget.dart';
import '../../../widgets/text_widget.dart';
import '../controllers/pharmacie_controller.dart';
import '../widgets/pharmacie_card_widget.dart';

class PharmacieView extends GetView<PharmacieController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: appbarColorFromCode,
        title:TextWidget(text: 'Pharmacies de garde',fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white,),
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
        child: Padding(
          padding: EdgeInsets.all(8),
          child: Column(
            children: [
              Obx(() => TextWidget(text: controller.periode.value, color: mainColor,
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
                              controller.refresh();
                            }
                          },
                        ),
                      ),
                    ),
                    Visibility(
                      visible: controller.zoneList.length > 1,
                      child: SizedBox(height: 3,)
                    ),
                    Visibility(
                      visible: controller.zoneList.length > 1,
                        child: Expanded(
                          child: ListView(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            children: [
                              Obx(() => Row(
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
                                          controller.refresh();
                                        }
                                      },
                                      child: Chip(
                                        elevation: 4.0,
                                        backgroundColor: zone.nom.toString() == controller.selectedZoneName.value ? Colors.amber : Colors.black26,
                                        label: TextWidget(text: zone.nom.toString(),
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
                    )
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
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Get.toNamed(AppRoutes.HOME);
        },
        child: Icon(Icons.home, color: Colors.white, size: 40,),
      ),
    );
  }
}
