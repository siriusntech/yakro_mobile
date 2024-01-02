import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../Utils/default_image.dart';
import '../../../controllers/main_controller.dart';
import '../../../models/slider.dart';
import '../../../widgets/image_widget.dart';

import '../../../widgets/text_widget.dart';
import '../../zoom/controllers/zoom_controller.dart';
import '../../zoom/views/zoom_view.dart';
import '../controllers/slider_controller.dart';

class SliderView extends GetView<SliderController> {
  final SliderModel? data;
  const SliderView({
    Key? key,
    this.data,
  });
  @override
  Widget build(BuildContext context) {
    final MainController settingsCtrl = Get.find();
    final ZoomController zoomCtrl = Get.put(ZoomController());
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
        body: SingleChildScrollView(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
              GestureDetector(
                child: ImageWidget(
                  isNetWork: true,
                  url: data!.imageUrl.toString(),
                  width: 393,
                  height: 275,
                  fit: BoxFit.cover,
                  default_image: DefaultImage.PUBLICITE,
                ),
                onTap: () {
                  zoomCtrl.setImageUrl(data!.imageUrl.toString());
                  Get.to(ZoomView(), fullscreenDialog: true);
                },
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: <Widget>[
                    Text(
                      "${data!.titre}",
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    Visibility(
                        visible: data!.description != null,
                        child: Text(
                          // "${data!.description}",
                          data!.description.toString(),
                          style: TextStyle(
                            fontSize: 16.0,
                          ),
                        )),
                    SizedBox(height: 20),
                    Visibility(
                      visible: data!.url != null,
                      child: InkWell(
                        onTap: () {
                          launchUrl(Uri.parse(data!.url.toString()));
                        },
                        child: TextField(
                          controller:
                              TextEditingController(text: data!.url.toString()),
                          enabled: false,
                          decoration: InputDecoration(
                            labelText: 'Site Internet',
                            prefixIcon: Icon(Icons.wb_shade),
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              )
            ])));
  }
}
