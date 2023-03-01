import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:photo_view/photo_view.dart';

import '../../../data/repository/data/Env.dart';
import '../controllers/zoom_controller.dart';

class ZoomView extends GetView<ZoomController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white10,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.close, size: 30, color: Colors.red,),
          onPressed: (){
            Get.back();
          },
        )
      ),
      body: Center(
        child: Obx(() => Container(
          decoration: BoxDecoration(
            color: Colors.white10
          ),
          // padding: EdgeInsets.all(10),
          child: controller.image_url.value.toString().contains("http") ?
          PhotoView(
                  imageProvider: NetworkImage( controller.image_url.value,),
            )
            : Image.asset(
              controller.image_url.value,
              width: Get.width - 10,
              height: Get.height - 10,
          ),
        )),
      ),
    );
  }
}
