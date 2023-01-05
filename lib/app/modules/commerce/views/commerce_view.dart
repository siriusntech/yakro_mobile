import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:mon_plateau/app/Utils/app_routes.dart';
import 'package:mon_plateau/app/modules/commerce/widgets/commerce_card_widget.dart';
import 'package:mon_plateau/app/widgets/no_data_widget.dart';

import '../../../Utils/app_constantes.dart';
import '../../../widgets/loading_widget.dart';
import '../../../widgets/text_widget.dart';
import '../controllers/commerce_controller.dart';

class CommerceView extends GetView<CommerceController> {



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: appbarColorFromCode,
        title:TextWidget(text: 'Commerces et autres',fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white,),
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
                      child: Card(
                        color: Colors.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                        child: TextField(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
                            prefixIcon: Icon(Icons.search, color: Colors.black, size: 30,),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(width: 1, color: Colors.grey),
                                borderRadius: BorderRadius.circular(15)
                            ),
                            hintText: "Ex: Sococe, Pizza, Charwama",
                            contentPadding: EdgeInsets.fromLTRB(0, 5, 0, 0),
                            // contentPadding: EdgeInsets.all(8)
                          ),
                          style: TextStyle(color: Colors.black, fontSize: 14, fontWeight: FontWeight.bold,),
                          onChanged: (val){
                            if(val.length > 0){
                              controller.getCommercesByName(val);
                            }else{
                              controller.refresh();
                            }
                          },
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: ListView(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      children: [
                        Obx(() => Row(
                          children: [
                            for(var type in controller.commerceTypesList) Card(
                              elevation: 0.0,
                              child: InkWell(
                                onTap: () {
                                  if(controller.selectedType.value == '' || controller.selectedType.value != type.nom.toString()){
                                    controller.setSelectedType(type.nom.toString());
                                    controller.getCommercesByType(type.nom.toString());
                                  }else{
                                    controller.setSelectedType('');
                                    controller.refresh();
                                  }
                                },
                                child: Chip(
                                  elevation: 0.0,
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
              flex: context.isLandscape ? 12 : 15,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Obx((){
                    if(controller.isDataProcessing.value == true){
                      return LoadingWidget();
                    } else {
                      if(controller.commerceList.length == 0){
                        return NoDataWidget();
                      } else {
                        return Expanded(
                            child: ListView.builder(
                                padding: EdgeInsets.only(bottom: 20),
                                itemCount: controller.commerceList.length,
                                itemBuilder: (context, index) {
                                  var commerce = controller.commerceList[index];
                                  return CommerceCardWidget(
                                      commerce: commerce,
                                      action: (){
                                        controller.setSelectedCommerce(commerce);
                                        Get.toNamed(AppRoutes.SHOW_COMMERCE);
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
