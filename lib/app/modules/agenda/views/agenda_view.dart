import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../Utils/app_colors.dart';
import '../../../Utils/app_constantes.dart';
import '../../../Utils/app_routes.dart';
import '../../../Utils/default_image.dart';
import '../../../controllers/main_controller.dart';
import '../../../data/repository/data/Env.dart';
import '../../../widgets/image_widget.dart';
import '../../../widgets/loading_widget.dart';
import '../../../widgets/no_data_widget.dart';
import '../../../widgets/text_widget.dart';
import '../controllers/agenda_controller.dart';

class AgendaView extends GetView<AgendaController> {
  final MainController settingsCtrl = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: settingsCtrl.appbarColorFromCode,
        title: Text("Agenda de la mairie",
          style: TextStyle(
              fontSize: 18.0,
              color: Colors.white,
              fontWeight: FontWeight.bold
          ),
        ),
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
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Container(
                  height: 45,
                  width: double.infinity,
                  child: ListView(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    children: [
                      Obx(()=>Row(
                        children: [
                          for(var type in controller.agendaTypes) Card(
                            elevation: 0.0,
                            child: InkWell(
                              onTap: () {
                                if(controller.selectedType.value.toString() == '' || controller.selectedType.value.toString() != type.toString()){
                                  controller.setSelectedType(type.toString());
                                  if(type != 'Tout'){
                                    controller.getAgendasByWeek();
                                  }else{
                                    // controller.setSelectedType('');
                                    controller.getAgendas(1);
                                  }
                                }
                              },
                              child: Chip(
                                elevation: 5.0,
                                backgroundColor: type.toString() == controller.selectedType.value.toString() ? Colors.amber : AppColors.chip_color,
                                label: TextWidget(text: type.toString().toLowerCase(),
                                  fontSize: 14, fontWeight: FontWeight.bold, scaleFactor: 1.2,
                                ),
                              ),
                            ),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
                            color: Colors.transparent,
                          )
                        ],
                      ))
                    ],
                  ),
                ),
                Expanded(
                  flex: 14,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Obx((){
                        if(controller.isDataProcessing.value == true){
                          return LoadingWidget();
                        } else {
                          if(controller.agendaList.length == 0){
                            return NoDataWidget();
                          } else {
                            return Expanded(
                                child: ListView.builder(
                                    itemCount: controller.agendaList.length,
                                    itemBuilder: (context, index) {
                                      var agenda = controller.agendaList[index];
                                      return InkWell(
                                        onTap: (){
                                          controller.setSelectedAgenda(agenda);
                                          Get.toNamed(AppRoutes.SHOW_AGENDA);
                                        },
                                        child: Card(
                                          elevation: 3,
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5.0),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                TextWidget(text: agenda.titre.toString().toUpperCase(), fontWeight: FontWeight.bold, fontSize: 14,color: Colors.red,maxLine: 3,overFlow: TextOverflow.ellipsis),
                                                SizedBox(height: 5,),
                                                Row(
                                                  children: [
                                                    Image.asset(ICON_CALENDAR, width: 20, height: 20,),
                                                    SizedBox(width: 3,),
                                                    TextWidget(text: agenda.date.toString(), fontWeight: FontWeight.w600, fontSize: 15,),
                                                  ],
                                                ),
                                                SizedBox(height: 5,),
                                                TextWidget(text: agenda.description, fontWeight: FontWeight.bold, fontSize: 16,maxLine: 4,color: Colors.grey,),
                                                SizedBox(height: 5,),
                                                Container(
                                                  width: double.infinity,
                                                  height: 250,
                                                  child: ImageWidget(isNetWork: true, url:
                                                  agenda.imageUrl, width: 250, height: 250, fit: BoxFit.contain,
                                                    default_image: DefaultImage.AGENDA,
                                                  ),
                                                ),
                                                SizedBox(height: 2,),
                                              ],
                                            ),
                                          ),
                                        ),
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
        backgroundColor: settingsCtrl.mainColor,
        onPressed: (){
          Get.toNamed(AppRoutes.HOME);
        },
        child: Icon(Icons.home, color: Colors.white, size: 40,),
      ),
    );
  }
}
