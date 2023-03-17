import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:jaime_cocody/app/modules/zoom/controllers/zoom_controller.dart';
import 'package:jaime_cocody/app/modules/zoom/views/zoom_view.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../Utils/app_constantes.dart';
import '../../../Utils/default_image.dart';
import '../../../widgets/image_widget.dart';
import '../../../widgets/text_widget.dart';
import '../controllers/job_controller.dart';

class JobShowView extends GetView<JobController> {

  final ZoomController zoomCtrl = Get.put(ZoomController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: appbarColorFromCode,
        title: Text(controller.selectedJob.value.intitule!.toUpperCase(),
          style: TextStyle(
              fontSize: 12.0,
              color: Colors.white,
              fontWeight: FontWeight.bold
          ),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child: ListView(
            children: [
              // Visibility(
              //     visible: controller.selectedJob.value.entreprise != null && controller.selectedJob.value.entreprise != '',
              //     child: Container(
              //       child: TextWidget(text: controller.selectedJob.value.entreprise.toString().toUpperCase(),
              //         fontWeight: FontWeight.bold,
              //         fontSize: 14,color: Colors.red,
              //         maxLine: 50,
              //       ),
              //     )
              // ),
              SizedBox(height: 5,),
              Container(
                child: TextWidget(text: controller.selectedJob.value.intitule!.toUpperCase(),
                  fontWeight: FontWeight.bold, color: Colors.red,
                  fontSize: 15,maxLine: 50,
                ),
              ),
              SizedBox(height: 5.0,),
              Container(
                child: Row(
                  children: [
                    TextWidget(text: 'Date de publication: ',fontSize: 16, color: Colors.black54, fontWeight: FontWeight.w600,),
                    TextWidget(text: controller.selectedJob.value.date_publication.toString().toUpperCase(), fontWeight: FontWeight.w600,
                      fontSize: 16,maxLine: 50, color: Colors.black54,
                    )
                  ],
                ),
              ),
              SizedBox(height: 5,),
              Visibility(
                  visible: controller.selectedJob.value.date_limite != null && controller.selectedJob.value.date_limite != '',
                  child: Container(
                    child: Row(
                      children: [
                        TextWidget(text: 'Date limite: ',fontSize: 16, color: Colors.black54, fontWeight: FontWeight.w600,),
                        TextWidget(text: controller.selectedJob.value.date_limite.toString().toUpperCase(), fontWeight: FontWeight.w600,
                          fontSize: 16,maxLine: 50, color: Colors.black54,
                        )
                      ],
                    ),
                  )
              ),
              SizedBox(height: 5,),
              Visibility(
                  visible: controller.selectedJob.value.lien != null && controller.selectedJob.value.lien != '',
                  child: InkWell(
                    onTap: (){
                      // MapsLauncher.launchCoordinates(double.parse(controller.selectedJob.value.longitude!), double.parse(controller.selectedJob.value.latitude!), controller.selectedJob.value.nom);
                      launchUrl(Uri.parse(controller.selectedJob.value.lien.toString()));
                    },
                    child: Row(
                      children: [
                        TextWidget(text: controller.selectedJob.value.lien,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.blue,
                        ),
                      ],
                    ),
                  )
              ),
              SizedBox(height: 5,),
              Container(
                width: double.infinity,
                height: 250,
                child: GestureDetector(
                  child: ImageWidget(isNetWork: true, url:
                  controller.selectedJob.value.image, width: 250, height: 250, fit: BoxFit.contain,
                    default_image: DefaultImage.JOB,
                  ),
                  onTap: (){
                    zoomCtrl.setImageUrl(controller.selectedJob.value.image.toString());
                    Get.to(ZoomView(), fullscreenDialog: true);
                  },
                )
              ),
              SizedBox(height: 5,),
              TextWidget(text: controller.selectedJob.value.description!, fontWeight: FontWeight.bold, fontSize: 16, color: Colors.grey,),
              SizedBox(height: 5,),
            ],
          ),
        ),
      ),
    );;
  }
}
