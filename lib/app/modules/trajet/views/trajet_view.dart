import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:jaime_cocody/app/widgets/text_widget.dart';

import '../controllers/trajet_controller.dart';
import '../widgets/trajet_card.dart';

class TrajetView extends GetView<TrajetController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextWidget(text: "",),
        centerTitle: true,
        bottom: TabBar(
          controller: controller.tabsController,
          tabs: controller.myTabs,
        ),
      ),
      body: TabBarView(

        controller: controller.tabsController,

        children: controller.myTabs.map((Tab tab) {

          final String label = tab.text!.toLowerCase();

          return Center(
            child: Padding(
              padding: EdgeInsets.all(8),
              child: Obx(() => ListView.builder(
                  padding: EdgeInsets.only(bottom: 20),
                  itemCount: controller.trajetList.length,
                  itemBuilder: (context, index) {
                    var trajet = controller.trajetList[index];
                    return TrajetCardWidget(
                      trajet: trajet,
                      action: (){

                      },
                    );
                  }
              )),
            ),

          );

        }).toList(),
      ),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: (){},
          label: TextWidget(text:  "Poster un trajet",
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
         icon: Icon(Icons.add_road, color: Colors.white,),
      ),
    );
  }
}
