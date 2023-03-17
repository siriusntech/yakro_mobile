import 'package:flutter/material.dart';
import 'package:jaime_cocody/app/widgets/image_widget.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../Utils/app_constantes.dart';
import '../../../Utils/default_image.dart';
import '../../../widgets/text_widget.dart';
import '../job_model.dart';
import '../controllers/job_controller.dart';
import 'package:get/get.dart';


class JobCardWidget extends StatelessWidget {
  final JobModel job;
  final VoidCallback? action;

  JobCardWidget({required this.job, this.action});

  final controller = Get.find<JobController>();

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: action,
      child: Card(
        elevation: 3,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Visibility(
              //     visible: job.entreprise != null && job.entreprise != '',
              //     child: Container(
              //       child: TextWidget(text: job.entreprise.toString().toUpperCase(),
              //         fontWeight: FontWeight.bold,
              //         fontSize: 14,color: Colors.red,
              //         maxLine: 50,
              //       ),
              //     )
              // ),
              SizedBox(height: 5,),
              Container(
                child: TextWidget(text: job.intitule!.toUpperCase(), fontWeight: FontWeight.bold,
                  fontSize: 15,maxLine: 50, color: Colors.red
                ),
              ),
              SizedBox(height: 5.0,),
              Container(
                child: Row(
                  children: [
                    TextWidget(text: 'Date de publication: ',fontSize: 16, color: Colors.black54, fontWeight: FontWeight.w600,),
                    TextWidget(text: job.date_publication.toString().toUpperCase(), fontWeight: FontWeight.w600,
                      fontSize: 16,maxLine: 50, color: Colors.black54,
                    )
                  ],
                ),
              ),
              SizedBox(height: 5,),
              Visibility(
                visible: job.date_limite != null && job.date_limite != '',
               child: Container(
                child: Row(
                  children: [
                    TextWidget(text: 'Date limite: ',fontSize: 16, color: Colors.black54, fontWeight: FontWeight.w600,),
                    TextWidget(text: job.date_limite.toString().toUpperCase(), fontWeight: FontWeight.w600,
                      fontSize: 16,maxLine: 50, color: Colors.black54,
                    )
                  ],
                ),
              )),
              SizedBox(height: 5,),
              Visibility(
                  visible: job.lien != null && job.lien != '',
                  child: InkWell(
                    onTap: (){
                      // MapsLauncher.launchCoordinates(double.parse(job.longitude!), double.parse(job.latitude!), job.nom);
                      launchUrl(Uri.parse(job.lien.toString()));
                    },
                    child: Row(
                      children: [
                        TextWidget(text: job.lien,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.blue,
                        ),
                      ],
                    ),
                  )
              ),
              SizedBox(height: 5,),
              TextWidget(text: job.description!, fontWeight: FontWeight.bold, fontSize: 16,maxLine: 4,color: Colors.grey,),
              SizedBox(height: 5,),
              Container(
                width: double.infinity,
                height: 250,
                child: ImageWidget(isNetWork: true, url:
                job.image, width: 250, height: 250, fit: BoxFit.contain,
                  default_image: DefaultImage.JOB,
                ),
              ),
              SizedBox(height: 6,),

            ],
          ),
        ),
      ),
    );
  }
}