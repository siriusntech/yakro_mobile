import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:jaime_yakro/app/Utils/app_routes.dart';
import 'package:jaime_yakro/app/modules/job/widgets/job_card_widget.dart';
import 'package:jaime_yakro/app/widgets/no_data_widget.dart';
import '../../../Utils/app_colors.dart';
import '../../../controllers/main_controller.dart';
import '../../../widgets/loading_widget.dart';
import '../../../widgets/text_widget.dart';
import '../controllers/job_controller.dart';

class JobView extends GetView<JobController> {

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
        title: TextWidget(
            text: 'Jobs / Annonces',
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.white),
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
                          controller: controller.searchTextController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
                            prefixIcon: Icon(Icons.search, color: Colors.black, size: 30,),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(width: 1, color: Colors.grey),
                                borderRadius: BorderRadius.circular(15)
                            ),
                            hintText: "Ex: Secrétaire, Comptabilité, Electricien...",
                            contentPadding: EdgeInsets.fromLTRB(0, 5, 0, 0),
                            // contentPadding: EdgeInsets.all(8)
                          ),
                          style: TextStyle(color: Colors.black, fontSize: 14, fontWeight: FontWeight.bold,),
                          onChanged: (val){
                            if(val.length > 0){
                              controller.getJobsByName(val);
                            }else{
                              controller.refreshData();
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
                            for(var type in controller.jobTypesList) Card(
                              elevation: 0.0,
                              child: InkWell(
                                onTap: () {
                                  if(controller.selectedType.value == '' || controller.selectedType.value != type.nom.toString()){
                                    controller.setSelectedType(type.nom.toString());
                                    controller.getJobsByType(type.nom.toString());
                                  }else{
                                    controller.setSelectedType('');
                                    controller.refreshData();
                                  }
                                },
                                child: Chip(
                                  elevation: 0.0,
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
              flex: context.isLandscape ? 12 : 15,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Obx((){
                    if(controller.isDataProcessing.value == true){
                      return LoadingWidget();
                    } else {
                      if(controller.jobList.length == 0){
                        return NoDataWidget();
                      } else {
                        return Expanded(
                            child: ListView.builder(
                                padding: EdgeInsets.only(bottom: 20),
                                itemCount: controller.jobList.length,
                                itemBuilder: (context, index) {
                                  var job = controller.jobList[index];
                                  return JobCardWidget(
                                      job: job,
                                      action: (){
                                        controller.setSelectedJob(job);
                                        Get.toNamed(AppRoutes.SHOW_JOB);
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
        backgroundColor: AppColors.vert_colorFonce,
        onPressed: (){
          Get.toNamed(AppRoutes.HOME);
        },
        child: Icon(Icons.home, color: Colors.white, size: 40,),
      ),
    );
  }


}
