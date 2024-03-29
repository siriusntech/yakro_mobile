import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../Utils/app_constantes.dart';
import '../../../Utils/app_routes.dart';
import '../../../Utils/default_image.dart';
import '../../../controllers/main_controller.dart';

import '../../../widgets/image_widget.dart';
import '../../../widgets/loading_widget.dart';
import '../../../widgets/no_data_widget.dart';
import '../../../widgets/text_widget.dart';
import '../controllers/diffusion_controller.dart';

class DiffusionView extends GetView<DiffusionController> {
  final MainController settingsCtrl = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: settingsCtrl.vert_color_fonce,
        title:TextWidget(text: 'Les Bons Plans de Ta Ville',fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white,),
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
      body: RefreshIndicator(
        onRefresh: () async{
          await controller.refreshData();
        },
        child: Container(
          padding: EdgeInsets.all(2.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Obx((){
                if(controller.isDataProcessing.value == true){
                  return LoadingWidget();
                } else {
                  if(controller.diffusionList.length == 0){
                    return NoDataWidget();
                  } else {
                    return Expanded(
                        child: ListView.builder(
                            padding: EdgeInsets.only(top: 2),
                            itemCount: controller.diffusionList.length,
                            itemBuilder: (context, index){
                              final _diffusion = controller.diffusionList[index];
                              return InkWell(
                                onTap: (){
                                  controller.setSelectedDiffusion(_diffusion);
                                  Get.toNamed(AppRoutes.SHOW_DIFFUSION);
                                },
                                child: Card(
                                  elevation: 3,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 5.0),
                                    child: Column(
                                      children: [
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            TextWidget(text: '#'+_diffusion.objet.toString(), fontWeight: FontWeight.bold, fontSize: 14, color: Colors.blue,maxLine: 2,overFlow: TextOverflow.ellipsis),
                                            SizedBox(height: 5,),
                                            Row(
                                              children: [
                                                SizedBox(width: 3,),
                                                Image.asset(ICON_CALENDAR,
                                                  width: 25,
                                                  height: 25,
                                                ),
                                                SizedBox(width: 10,),
                                                TextWidget(text: _diffusion.date, fontWeight: FontWeight.w600, color: Colors.black,),
                                              ],
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 5,),
                                        Padding(
                                          padding: const EdgeInsets.only(left: 3.0),
                                          child: Text(_diffusion.message!, overflow: TextOverflow.ellipsis, textScaleFactor: 1.2,
                                            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey, overflow:TextOverflow.ellipsis),
                                            maxLines: 4,
                                          ),
                                        ),
                                        SizedBox(height: 5,),
                                        Container(
                                          width: double.infinity,
                                          height: 250,
                                          child: ImageWidget(isNetWork: true, url:
                                          _diffusion.imageUrl.toString(),
                                           width: 250, height: 250, fit: BoxFit.contain,
                                            default_image: DefaultImage.BON_PLAN,
                                          ),
                                          // child: Image.network(_diffusion.imageUrl.toString()),

                                        ),
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
