import 'dart:developer';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:jaime_yakro/app/modules/sitetouristiques/views/detail_sitetouristiques_view.dart';
import '../../../controllers/main_controller.dart';
import '../../../widgets/loading_widget.dart';
import '../../../widgets/no_data_widget.dart';
import '../../../widgets/text_widget.dart';
import '../controllers/sitetouristiques_controller.dart';

class SitetouristiquesView extends GetView<SitetouristiquesController> {
  const SitetouristiquesView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    SitetouristiquesController visiteTouristiqueController = Get.put(SitetouristiquesController());
    final MainController settingsCtrl = Get.find();
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: settingsCtrl.vert_color_fonce,
        title: TextWidget(text: 'Sites Touristiques', fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
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
      body: Obx(() {
        return visiteTouristiqueController.isLoading.value
            ? Center(
          child: CircularProgressIndicator(),
        )
            : Column(
                      children: [
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              SizedBox(height: 15.0),
                              Padding(
                                padding: const EdgeInsets.only(right: 8.0),
                                child: FilterChip(
                                  label: Text("Tout"),
                                  onSelected: (onSelected) {
                                    visiteTouristiqueController.type_vt_selected.value = 0;
                                    visiteTouristiqueController.getVisitesTouristiques();
                                  },
                                  selected: visiteTouristiqueController
                                          .type_vt_selected.value == 0,
                                ),
                              ),
                              ...controller.vTAllTypeVT
                                  .map((typeByVt) => Padding(
                                        padding:
                                            const EdgeInsets.only(right: 8.0),
                                        child: FilterChip(
                                          label:
                                              Text(typeByVt.nomCategorie!.toString()),
                                          onSelected: (onSelected) {
                                            visiteTouristiqueController.type_vt_selected.value = typeByVt.id!;
                                            print('je teste'+onSelected.toString());
                                            visiteTouristiqueController.getVisitesTouristiques();
                                          },
                                          selected: visiteTouristiqueController
                                                  .type_vt_selected.value ==
                                              typeByVt.id!,
                                        ),
                                      )
                                  )
                            ],

                          ),
                        ),
                        SizedBox(height:15.0),
          Obx(() => controller.isDataProcessing.value
                ? LoadingWidget()
                : controller.visiteTouristiquesList.isEmpty
                    ? NoDataWidget()
                    : Expanded(
                        child: ListView.builder(
                          padding: EdgeInsets.all(10),
                          itemCount: visiteTouristiqueController.visiteTouristiquesList.length,
                          itemBuilder: (context, index) {
                            final visiteTouristiqueData = visiteTouristiqueController.visiteTouristiquesList[index];
                            return Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ListTile(
                                  onTap: (){
                                    Get.to(DetailSitetouristiquesView(
                                      data: visiteTouristiqueData,
                                    )
                                    );
                                  },
                                  title: TextWidget(
                                    text: visiteTouristiqueData.nomVt!,
                                    color: Colors.black,
                                    fontSize: 19,
                                    fontWeight: FontWeight.bold,
                                    alignement: TextAlign.center,
                                  ),
                                  trailing: Icon(Icons.arrow_right),
                                  subtitle: Text(
                                    visiteTouristiqueData.description!,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  leading: Container(
                                    height: 70,
                                    width: 70,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      image: DecorationImage(
                                        image:  NetworkImage(
                                  visiteTouristiqueData.vtMedias[0].url ?? ''
                              ),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                      )),   
                      ],
                    ); }),
    );
  }


}
