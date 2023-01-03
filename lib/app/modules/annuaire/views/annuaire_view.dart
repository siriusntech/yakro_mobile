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
                _ui()
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
    return Obx(() {
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
    });
  }

}
