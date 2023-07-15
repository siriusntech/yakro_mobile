import 'package:flutter/material.dart';
import 'package:jaime_cocody/app/Utils/app_icons.dart';
import 'package:jaime_cocody/app/widgets/image_widget.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../Utils/app_constantes.dart';
import '../../../Utils/default_image.dart';
import '../../../widgets/text_widget.dart';
import '../commerce_model.dart';
import '../controllers/commerce_controller.dart';
import 'package:get/get.dart';

class CommerceCardWidget extends StatelessWidget {
  final Commerce commerce;
  final VoidCallback? action;

  CommerceCardWidget({required this.commerce, this.action});

  final CommerceController controller = Get.find();

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
              Container(
                width: MediaQuery.of(context).size.width - 50,
                child: TextWidget(text: commerce.type.toString().toUpperCase(),
                  fontWeight: FontWeight.bold,
                  fontSize: 14,color: Colors.red,
                  maxLine: 50,
                ),
              ),
              SizedBox(height: 5,),
              Row(
                children: [
                  Image.asset(ICON_STORE, width: 20, height: 20,),
                  SizedBox(width: 3,),
                  Container(
                    width: MediaQuery.of(context).size.width - 50,
                    child: TextWidget(text: commerce.nom!.toUpperCase(), fontWeight: FontWeight.w600,
                      fontSize: 15,maxLine: 50,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 3.0,),
              Visibility(
                  visible: commerce.site != null && commerce.site != '',
                  child: InkWell(
                    onTap: (){
                      launchUrl(Uri.parse(commerce.site.toString()));
                    },
                    child: Row(
                      children: [
                        TextWidget(text: 'Site Internet: ', fontWeight: FontWeight.w600, fontSize: 14),
                        SizedBox(width: 3,),
                        Container(
                          width: MediaQuery.of(context).size.width - 50,
                          child: TextWidget(text: commerce.site.toString(), fontWeight: FontWeight.w600,
                            fontSize: 15,maxLine: 50,
                          ),
                        ),
                      ],
                    ),
                  )
              ),
              SizedBox(height: 3.0,),
              Visibility(
                  visible: commerce.email != null && commerce.email != '',
                  child: InkWell(
                    onTap: (){
                      launchUrl(Uri.parse(commerce.email.toString()));
                    },
                    child: Row(
                      children: [
                        TextWidget(text: 'Adresse Email: ', fontWeight: FontWeight.w600, fontSize: 14),
                        SizedBox(width: 3,),
                        Container(
                          width: MediaQuery.of(context).size.width - 50,
                          child: TextWidget(text: commerce.email.toString(), fontWeight: FontWeight.w600,
                            fontSize: 15,maxLine: 50,
                          ),
                        ),
                      ],
                    ),
                  )
              ),
              SizedBox(height: 3.0,),
              Visibility(
                  visible: commerce.facebook != null && commerce.facebook != '',
                  child: InkWell(
                    onTap: (){
                      launchUrl(Uri.parse(commerce.facebook.toString()));
                    },
                    child: Row(
                      children: [
                        Image.asset(AppIcons.FACEBOOK, width: 20, height: 20,),
                        SizedBox(width: 3,),
                        Container(
                          width: MediaQuery.of(context).size.width - 50,
                          child: TextWidget(text: commerce.facebook.toString(), fontWeight: FontWeight.w600,
                            fontSize: 15,maxLine: 50,
                          ),
                        ),
                      ],
                    ),
                  )
              ),
              SizedBox(height: 3.0,),
              Visibility(
                  visible: commerce.linkedln != null && commerce.linkedln != '',
                  child: InkWell(
                    onTap: (){
                      launchUrl(Uri.parse(commerce.linkedln.toString()));
                    },
                    child: Row(
                      children: [
                        Image.asset(AppIcons.LINKEDIN, width: 20, height: 20,),
                        SizedBox(width: 3,),
                        Container(
                          width: MediaQuery.of(context).size.width - 50,
                          child: TextWidget(text: commerce.linkedln.toString(), fontWeight: FontWeight.w600,
                            fontSize: 15,maxLine: 50,
                          ),
                        ),
                      ],
                    ),
                  )
              ),
              SizedBox(height: 5.0,),
              Row(
                children: [
                  Image.asset(ICON_NAME, width: 20, height: 20,),
                  SizedBox(width: 3,),
                  Container(
                    width: MediaQuery.of(context).size.width - 50,
                    child: TextWidget(text: commerce.responsable.toString().toUpperCase(), fontWeight: FontWeight.w600,
                      fontSize: 15,maxLine: 50, color: Colors.grey,
                    ),
                  )
                ],
              ),
              SizedBox(height: 5,),
              InkWell(
                onTap: (){
                  controller.showAlerte(commerce.contact.toString());
                },
                child: Row(
                  children: [
                    Image.asset(ICON_TELEPHONE, width: 20, height: 20,),
                    SizedBox(width: 3,),
                    TextWidget(text: commerce.contact.toString(), fontWeight: FontWeight.bold, fontSize: 14,color: Colors.blue,),
                  ],
                ),
              ),
              SizedBox(height: 5,),
              TextWidget(text: commerce.description!, fontWeight: FontWeight.bold, fontSize: 16,maxLine: 4,color: Colors.grey,),
              SizedBox(height: 5,),
              Container(
                width: double.infinity,
                height: 210,
                child: ImageWidget(isNetWork: true, url:
                commerce.imageUrl, width: 200, height: 200, fit: BoxFit.contain,
                  default_image: DefaultImage.COMMERCE,
                ),
              ),
              SizedBox(height: 2,),
              Divider(),
              SizedBox(height: 4,),
              InkWell(
                onTap: (){
                  // MapsLauncher.launchCoordinates(double.parse(commerce.longitude!), double.parse(commerce.latitude!), commerce.nom);
                  launch(commerce.lien.toString());
                },
                child: Row(
                  children: [
                    Icon(Icons.map, color: Colors.red,),
                    TextWidget(text:"Itinéraire",
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.red,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}