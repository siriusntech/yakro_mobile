import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../Utils/app_constantes.dart';
import '../../../Utils/app_icons.dart';
import '../../../Utils/default_image.dart';
import '../../../controllers/main_controller.dart';
import '../../../widgets/image_widget.dart';
import '../../../widgets/text_widget.dart';
import '../../zoom/controllers/zoom_controller.dart';
import '../../zoom/views/zoom_view.dart';
import '../controllers/restaurant_controller.dart';

class ShowRestaurantView extends GetView<RestaurantController>{
  const ShowRestaurantView({Key? key}) : super(key: key);
 
  @override
  Widget build(BuildContext context) {
     final ZoomController zoomCtrl = Get.put(ZoomController());
     final MainController settingsCtrl = Get.find();
    return Scaffold(
      appBar:AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: settingsCtrl.vert_color_fonce,
        title:TextWidget(text: 'Restaurants et autres',fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white,),
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
          child: ListView(
            children: [
              Container(
                width: MediaQuery.of(context).size.width - 50,
                child: TextWidget(text: controller.selectedCommerce.value.type.toString().toUpperCase(), fontWeight: FontWeight.w600,
                  fontSize: 15,maxLine: 50,
                ),
              ),
              SizedBox(height: 5,),
              Row(
                children: [
                  Image.asset(ICON_STORE, width: 20, height: 20,),
                  SizedBox(width: 3,),
                  Container(
                    width: MediaQuery.of(context).size.width - 50,
                    child: TextWidget(text: controller.selectedCommerce.value.nom.toString().toUpperCase(), fontWeight: FontWeight.w600,
                      fontSize: 15,maxLine: 50,
                    ),
                  )
                ],
              ),
              SizedBox(height: 3.0,),
              Visibility(
                  visible: controller.selectedCommerce.value.site != null && controller.selectedCommerce.value.site != '',
                  child: InkWell(
                    onTap: (){
                      launchUrl(Uri.parse(controller.selectedCommerce.value.site.toString()));
                    },
                    child: Row(
                      children: [
                        TextWidget(text: 'Site Internet: ', fontWeight: FontWeight.w600, fontSize: 14),
                        SizedBox(width: 3,),
                        Container(
                          width: MediaQuery.of(context).size.width - 50,
                          child: TextWidget(text: controller.selectedCommerce.value.site.toString(), fontWeight: FontWeight.w600,
                            fontSize: 15,maxLine: 50,
                          ),
                        ),
                      ],
                    ),
                  )
              ),
              SizedBox(height: 3.0,),
              Visibility(
                  visible: controller.selectedCommerce.value.email != null && controller.selectedCommerce.value.email != '',
                  child: InkWell(
                    onTap: (){
                      launchUrl(Uri.parse(controller.selectedCommerce.value.email.toString()));
                    },
                    child: Row(
                      children: [
                        TextWidget(text: 'Adresse Email: ', fontWeight: FontWeight.w600, fontSize: 14),
                        SizedBox(width: 3,),
                        Container(
                          width: MediaQuery.of(context).size.width - 50,
                          child: TextWidget(text: controller.selectedCommerce.value.email.toString(), fontWeight: FontWeight.w600,
                            fontSize: 15,maxLine: 50,
                          ),
                        ),
                      ],
                    ),
                  )
              ),
              SizedBox(height: 3.0,),
              Visibility(
                  visible: controller.selectedCommerce.value.facebook != null && controller.selectedCommerce.value.facebook != '',
                  child: InkWell(
                    onTap: (){
                      launchUrl(Uri.parse(controller.selectedCommerce.value.facebook.toString()));
                    },
                    child: Row(
                      children: [
                        Image.asset(AppIcons.FACEBOOK, width: 20, height: 20,),
                        SizedBox(width: 3,),
                        Container(
                          width: MediaQuery.of(context).size.width - 50,
                          child: TextWidget(text: controller.selectedCommerce.value.facebook.toString(), fontWeight: FontWeight.w600,
                            fontSize: 15,maxLine: 50,
                          ),
                        ),
                      ],
                    ),
                  )
              ),
              SizedBox(height: 3.0,),
              Visibility(
                  visible: controller.selectedCommerce.value.linkedln != null && controller.selectedCommerce.value.linkedln != '',
                  child: InkWell(
                    onTap: (){
                      launchUrl(Uri.parse(controller.selectedCommerce.value.linkedln.toString()));
                    },
                    child: Row(
                      children: [
                        Image.asset(AppIcons.LINKEDIN, width: 20, height: 20,),
                        SizedBox(width: 3,),
                        Container(
                          width: MediaQuery.of(context).size.width - 50,
                          child: TextWidget(text: controller.selectedCommerce.value.linkedln.toString(), fontWeight: FontWeight.w600,
                            fontSize: 15,maxLine: 50,
                          ),
                        ),
                      ],
                    ),
                  )
              ),
              SizedBox(height: 3.0,),
              Visibility(
                  visible: controller.selectedCommerce.value.instagram != null && controller.selectedCommerce.value.instagram != '',
                  child: InkWell(
                    onTap: (){
                      launchUrl(Uri.parse(controller.selectedCommerce.value.instagram.toString()));
                    },
                    child: Row(
                      children: [
                        Image.asset(AppIcons.INSTAGRAM, width: 20, height: 20,),
                        SizedBox(width: 3,),
                        Container(
                          width: MediaQuery.of(context).size.width - 50,
                          child: TextWidget(text: controller.selectedCommerce.value.instagram.toString(), fontWeight: FontWeight.w600,
                            fontSize: 15,maxLine: 50,
                          ),
                        ),
                      ],
                    ),
                  )
              ),
              SizedBox(height: 3.0,),
              Visibility(
                  visible: controller.selectedCommerce.value.youtube != null && controller.selectedCommerce.value.youtube != '',
                  child: InkWell(
                    onTap: (){
                      launchUrl(Uri.parse(controller.selectedCommerce.value.youtube.toString()));
                    },
                    child: Row(
                      children: [
                        Image.asset(AppIcons.YOUTUBE, width: 20, height: 20,),
                        SizedBox(width: 3,),
                        Container(
                          width: MediaQuery.of(context).size.width - 50,
                          child: TextWidget(text: controller.selectedCommerce.value.youtube.toString(), fontWeight: FontWeight.w600,
                            fontSize: 15,maxLine: 50,
                          ),
                        ),
                      ],
                    ),
                  ),
              ),
              SizedBox(height: 5.0,),
              Row(
                children: [
                  Image.asset(ICON_NAME, width: 20, height: 20,),
                  SizedBox(width: 3,),
                  Container(
                    width: MediaQuery.of(context).size.width - 50,
                    child: TextWidget(text: controller.selectedCommerce.value.responsable.toString().toUpperCase(), fontWeight: FontWeight.w600,
                      fontSize: 15,maxLine: 50, color: Colors.grey,
                    ),
                  )
                ],
              ),
              SizedBox(height: 5,),
              InkWell(
                onTap: (){
                  controller.showAlerte(controller.selectedCommerce.value.contact.toString());
                },
                child: Row(
                  children: [
                    Image.asset(ICON_TELEPHONE, width: 20, height: 20,),
                    SizedBox(width: 3,),
                    TextWidget(text: controller.selectedCommerce.value.contact.toString(), fontWeight: FontWeight.bold, fontSize: 14,color: Colors.blue,),
                  ],
                ),
              ),
              SizedBox(height: 10.0,),
              Container(
                width: double.infinity,
                height: 250,
                child: GestureDetector(
                  child: ImageWidget(isNetWork: true, url:
                  controller.selectedCommerce.value.imageUrl, width: 250, height: 250, fit: BoxFit.contain,
                    default_image: DefaultImage.COMMERCE,
                  ),
                  onTap: (){
                    zoomCtrl.setImageUrl(controller.selectedCommerce.value.imageUrl.toString());
                    Get.to(ZoomView(), fullscreenDialog: true);
                  },
                ),
              ),
              SizedBox(height: 15.0,),
              Text(controller.selectedCommerce.value.description.toString(),
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.normal,
                ),
                maxLines: 150,
              ),
              Divider(),
              TextButton(
                onPressed: (){
                  // MapsLauncher.launchCoordinates(double.parse(controller.selectedCommerce.value.longitude!), double.parse(controller.selectedCommerce.value.latitude!), controller.selectedCommerce.value.nom);
                  launchUrl(Uri.parse(controller.selectedCommerce.value.lien.toString()));
                },
                child: Row(
                  children: [
                    Icon(Icons.map, color: Colors.red,),
                    TextWidget(text:"Itinéraire",
                      fontSize: 16,
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
    );;
  }

}
