import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../Utils/app_constantes.dart';
import '../../../Utils/default_image.dart';
import '../../../controllers/main_controller.dart';
import '../../../widgets/image_widget.dart';
import '../../../widgets/text_widget.dart';
import '../../zoom/controllers/zoom_controller.dart';
import '../../zoom/views/zoom_view.dart';
import '../controllers/diffusion_controller.dart';

class DiffusionShowView extends GetView<DiffusionController> {
  final ZoomController zoomCtrl = Get.put(ZoomController());
  final MainController settingsCtrl = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: settingsCtrl.vert_color_fonce,
        title:TextWidget(text: 'Les informations en détails',fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white,),
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
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextWidget(text: '#'+controller.selectedDiffusion.value.objet.toString(), fontWeight: FontWeight.bold, fontSize: 14,color: Colors.blue,),
                  SizedBox(height: 5,),
                  Row(
                    children: [
                      SizedBox(width: 3,),
                      Image.asset(ICON_CALENDAR,
                        width: 25,
                        height: 25,
                      ),
                      SizedBox(width: 10,),
                      TextWidget(text: controller.selectedDiffusion.value.date, fontWeight: FontWeight.w600, color: Colors.black,),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 5,),
              Padding(
                padding: const EdgeInsets.only(left: 3.0),
                child: Text(controller.selectedDiffusion.value.message!, overflow: TextOverflow.ellipsis, textScaleFactor: 1.2,
                  style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey),
                  maxLines: 150,
                ),
              ),
              SizedBox(height: 5,),
              Container(
                width: double.infinity,
                height: 250,
                child: GestureDetector(
                  child: ImageWidget(isNetWork: true, url:
                  controller.selectedDiffusion.value.imageUrl, width: 250, height: 250, fit: BoxFit.contain,
                    default_image: DefaultImage.BON_PLAN,
                  ),
                  onTap: (){
                    zoomCtrl.setImageUrl(controller.selectedDiffusion.value.imageUrl.toString());
                    Get.to(ZoomView(), fullscreenDialog: true);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
