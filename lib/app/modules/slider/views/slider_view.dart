import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../Utils/default_image.dart';
import '../../../controllers/main_controller.dart';
import '../../../models/slider.dart';
import '../../../widgets/image_widget.dart';
import '../../../widgets/text_widget.dart';
import '../controllers/slider_controller.dart';

class SliderView extends GetView<SliderController> {
  final SliderModel? data;
  const SliderView( {Key? key,this.data,});
  @override
  Widget build(BuildContext context) {
      final SliderController sliderController = Get.find();
       final MainController settingsCtrl = Get.find();
    return Scaffold(
          appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: settingsCtrl.vert_color_fonce,
        title: TextWidget(
            text: 'Détails de la publicité',
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
      body: Obx((){
        return sliderController.isDataProcessing.value
              ?  Center(
                child: CircularProgressIndicator(),
              )
              : SingleChildScrollView(
                   child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                   ImageWidget(isNetWork: true, url: data!.imageUrl.toString(), width: 393, height: 275, fit: BoxFit.cover,
                default_image: DefaultImage.PUBLICITE,
              ),
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children:<Widget>[
                        Text(
                             "${data!.titre}",
                              style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 10),
                            Text(
                              // "${data!.description}",
                              data!.description.toString(),
                              style: TextStyle(
                                fontSize: 16.0,
                              ),
                            ),
                    ],
                  ),
                )
                         
                  ]
               )
           );
      }),
    );
    
  }
}
