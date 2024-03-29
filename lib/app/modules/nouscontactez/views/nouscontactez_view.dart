import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:jaime_yakro/app/widgets/image_widget%20_baseUrl.dart';
import 'package:jaime_yakro/app/widgets/text_widget.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../controllers/main_controller.dart';
import '../../../widgets/loading_widget.dart';
import '../controllers/nouscontactez_controller.dart';

class NouscontactezView extends GetView<NouscontactezController> {
  final MainController settingsCtrl = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
            appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: settingsCtrl.vert_color_fonce,
        title:TextWidget(text:'Contactez-nous', fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
            size: 30,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () async {
            },
            icon: Icon(
              Icons.refresh,
              color: Colors.white,
              size: 30,
            ),
          ),
        ],
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(5),
          child: Obx((){
            if(controller.isDataProcessing.value == true){
              return LoadingWidget();
            } else {
              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(height: 10),
                  Flexible(
                    flex: 2,
                      child: Container(
                        width: double.infinity,
                        child: ImageWidgetBaseUrl(isNetWork: true, url:controller.entrepriseInfo.value.logo.toString(), fit: BoxFit.contain),
                      )
                  ),
                     SizedBox(height: 10),
              
                  SizedBox(height: 15),
                   Divider(),
                  Flexible(
                         flex: 2,
                      child: ListTile(
                        leading: Icon(Icons.place),
                        title: TextWidget(text: "Adresse:", fontWeight: FontWeight.bold, fontSize: 16),
                        subtitle: TextWidget(text: controller.entrepriseInfo.value.adresse,
                        fontSize: 16,),
                      )
                  ),
                    SizedBox(height: 10),
                  Divider(),
                  Flexible(
                      child: ListTile(
                        leading: Icon(Icons.mail),
                        title: TextWidget(text: "Email:", fontWeight: FontWeight.bold, fontSize: 18,),
                        subtitle: TextWidget(text: controller.entrepriseInfo.value.email,
                        fontSize: 16),
                      )
                  ),
                  Divider(),
                       Flexible(
                                  child: ListTile(
                                    leading: Icon(Icons.phone),
                                    title: TextWidget(text: "Contact:", fontWeight: FontWeight.bold, fontSize: 16),
                                    subtitle: InkWell(
                                    onTap: () {
                                controller.showAlerte( controller.entrepriseInfo.value.contact);
                            },
                              child: TextWidget(text: controller.entrepriseInfo.value.contact, fontSize: 18, color: Colors.blue,),
                               ),
                         ),
                      ),
               
                  Divider(),
                  Flexible(
                      child: ListTile(
                        leading: Icon(FontAwesomeIcons.internetExplorer),
                        title: TextWidget(text: "Site Internet:", fontWeight: FontWeight.bold, fontSize: 18,),
                        subtitle: InkWell(
                          onTap: (){
                            launchUrl(Uri.parse("https://sirius.com/"));
                          },
                          child: TextWidget(text: "https://siriusntech.com", fontSize: 18, color: Colors.blue,),
                        ),
                      )
                  )
                ],
              );
            }
          })
        ),
      ),
    );
  }
}
