import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:jaime_cocody/app/Utils/app_colors.dart';
import 'package:jaime_cocody/app/widgets/button_widget.dart';

import '../../../Utils/app_constantes.dart';
import '../../../Utils/app_routes.dart';
import '../../../Utils/default_image.dart';
import '../../../controllers/main_controller.dart';
import '../../../data/repository/data/Env.dart';
import '../../../widgets/alerte_widgets.dart';
import '../../../widgets/image_widget.dart';
import '../../../widgets/loading_widget.dart';
import '../../../widgets/my_alerte_tooltip_widget.dart';
import '../../../widgets/no_data_widget.dart';
import '../../../widgets/text_widget.dart';
import '../../../widgets/video_widget.dart';
import '../alerte_model.dart';
import '../controllers/alerte_controller.dart';

class AlerteView extends GetView<AlerteController> {
  final MainController settingsCtrl = Get.find();
  liked(Alerte alerte) {
    final key_alerte = GlobalKey<State<Tooltip>>();

    return Tooltip(
      key: key_alerte,
      message: "j'aime",
      textStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.red),
      waitDuration: Duration(seconds: 1),
      showDuration: Duration(seconds: 1),
      padding: EdgeInsets.all(10),
      preferBelow: false,
      triggerMode: TooltipTriggerMode.tap,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15)
      ),
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          final dynamic tooltip = key_alerte.currentState;
          tooltip?.ensureTooltipVisible();
          if(alerte.liked == 2 || alerte.liked == 0 || alerte.liked == null){
            controller.likeAlerte(alerte.id);
          }
        },
        child: Icon(Icons.thumb_up, color: alerte.liked == 1 ? Colors.red : Colors.black,),
      ),
    );
  }

  unLiked(Alerte alerte) {
    final key_alerte = GlobalKey<State<Tooltip>>();

    return Tooltip(
      key: key_alerte,
      message: "j'aime pas",
      textStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.red),
      waitDuration: Duration(seconds: 1),
      showDuration: Duration(seconds: 1),
      padding: EdgeInsets.all(10),
      preferBelow: false,
      triggerMode: TooltipTriggerMode.tap,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15)
      ),
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          final dynamic tooltip = key_alerte.currentState;
          tooltip?.ensureTooltipVisible();
          if(alerte.liked == 1 || alerte.liked == 0 || alerte.liked == null){
            controller.unLikeAlerte(alerte.id);
          }
        },
        child: Icon(Icons.thumb_down, color: alerte.liked == 2 ? Colors.red : Colors.black,),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: settingsCtrl.vert_color_fonce,
        title:TextWidget(text:'Signaler un incident', fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
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
      body: ListView(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                height: 250,
                color: Colors.white,
                child: Image(
                    image: AssetImage(ALERTE_BG),
                    fit: BoxFit.contain
                ),
              ),
              TextButtonWidget(text_widget: TextWidget(text: "Voir toutes mes alertes",
                color: Colors.red, fontSize: 15,
                scaleFactor: 1.2,fontWeight: FontWeight.bold,
               ),
               action: (){
                 Get.toNamed(AppRoutes.MES_ALERTES);
                },
                border_side: MaterialStateProperty.all(BorderSide(color: Colors.red)),
                rounded: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))),
              ),
              SizedBox(height: 10,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 0.0),
                child: Container(
                  width: double.infinity,
                  height: 115,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(width: 2, color: Colors.white)
                  ),
                  child: Card(
                    elevation: 10,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextWidget(text: "Nature de l'incident",
                            fontSize: 15.0, scaleFactor: 1.3, fontWeight: FontWeight.w600,
                            alignement: TextAlign.center,
                          ),
                          SizedBox(
                            height: 60,
                            child: Container(
                              width: double.infinity,
                              alignment: Alignment.center,
                              child: Obx(() => controller.createDropDownList()),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 30,),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 2.0),
            decoration: BoxDecoration(
                color: AppColors.vert_color_fonce
            ),
            child: Row(
              children: [
                TextWidget(text: "Autres Alertes",
                  fontSize: 20.0, color: Colors.white, fontWeight: FontWeight.w600,
                ),
                SizedBox(width: 5,),
                TextButtonWidget(
                  text_widget: TextWidget(text: "Voir tout",
                   fontSize: 18.0, color: Colors.white, fontWeight: FontWeight.bold,
                  ),
                  action: (){
                    Get.toNamed(AppRoutes.ALL_ALERTES);
                  },
                  border_side: MaterialStateProperty.all(BorderSide(color: Colors.white)),
                  rounded: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))),
                ),
              ],
            ),
          ),
          Container(
            // height: (MediaQuery.of(context).size.height / 1.2),
            padding: EdgeInsets.only(bottom: 10),
            child: Obx((){
              if(controller.isAllDataProcessing.value == true){
                return LoadingWidget();
              } else {
                if(controller.allAlerteList.length == 0){
                  return NoDataWidget();
                } else {
                  return ListView.builder(
                          shrinkWrap: true,
                          physics: ClampingScrollPhysics(),
                          itemCount: controller.allAlerteList.length,
                          itemBuilder: (context, index) {
                            var alerte = controller.allAlerteList[index];
                            return InkWell(
                              onTap: (){
                                controller.setSelectedAlerte(alerte);
                                Get.toNamed(AppRoutes.SHOW_ALERTE);
                              },
                              child: Card(
                                elevation: 3,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 5.0),
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          Flexible(
                                            flex: 1,
                                            child: Container(
                                              height: 50,
                                              width: 50,
                                              child: CircleAvatar(
                                                backgroundColor: Colors.amber,
                                                radius: 50,
                                                backgroundImage: AssetImage(ICON_USER_AVATAR),
                                              ),
                                            ),
                                          ),
                                          SizedBox(width: 10,),
                                          Flexible(
                                            flex: 2,
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                TextWidget(text: alerte.senderPseudo, fontWeight: FontWeight.bold, fontSize: 14,),
                                                SizedBox(width: 15,),
                                                TextWidget(text: alerte.date, color: Colors.grey, fontWeight: FontWeight.bold,),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 5,),
                                      Row(
                                        children: [
                                          SizedBox(width: 3,),
                                          Image.asset(AlerteImage(alerte.type.toString()),
                                            width: 25,
                                            height: 25,
                                          ),
                                          SizedBox(width: 10,),
                                          TextWidget(text: alerte.type, fontWeight: FontWeight.bold, scaleFactor: 1.2,color: Colors.blue,),
                                        ],
                                      ),
                                      SizedBox(height: 5,),
                                      Row(
                                        children: [
                                          SizedBox(width: 3,),
                                          Image.asset(ICON_LOCALISATION,
                                            width: 25,
                                            height: 25,
                                          ),
                                          SizedBox(width: 10,),
                                          Container(
                                            width: MediaQuery.of(context).size.width - 55,
                                            child: TextWidget(text: alerte.localisation, fontWeight: FontWeight.bold, scaleFactor: 1.2, color: Colors.red, maxLine: 3,),
                                          )
                                        ],
                                      ),
                                      SizedBox(height: 5,),
                                      Row(
                                        children: [
                                          SizedBox(width: 3,),
                                          Image.asset(ICON_CALENDAR,
                                            width: 25,
                                            height: 25,
                                          ),
                                          SizedBox(width: 10,),
                                          TextWidget(text: alerte.dateIncident, fontWeight: FontWeight.w600, color: Colors.black,),
                                        ],
                                      ),
                                      SizedBox(height: 5,),
                                      Padding(
                                        padding: const EdgeInsets.only(left: 3.0),
                                        child: Text(alerte.description!, overflow: TextOverflow.ellipsis, textScaleFactor: 1.2,
                                          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey),
                                          maxLines: 5,
                                        ),
                                      ),
                                      SizedBox(height: 5,),
                                      Container(
                                        width: double.infinity,
                                        height: 250,
                                        child: alerte.fileType == 'image' ? ImageWidget(isNetWork: true, url:
                                        alerte.fileUrl, width: 250, height: 250, fit: BoxFit.contain,
                                          default_image: DefaultImage.ALERTE,
                                        ) : VideoWidget(fileUrl: siteUrl+alerte.fileUrl.toString(),from: 'network',),
                                      ),
                                      SizedBox(height: 5,),
                                      Divider(),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          SizedBox(width: 3,),
                                          Row(
                                            children: [
                                              liked(alerte),
                                              SizedBox(width: 3,),
                                              TextWidget(text: alerte.likeCount.toString(), fontWeight: FontWeight.bold,color: Colors.blue,),
                                            ],
                                          ),
                                          SizedBox(width: 15,),
                                          Row(
                                            children: [
                                              unLiked(alerte),
                                              SizedBox(width: 3,),
                                              TextWidget(text: alerte.unLikeCount.toString(), fontWeight: FontWeight.bold,color: Colors.red,),
                                            ],
                                          )
                                        ],
                                      ),
                                      SizedBox(height: 8,),
                                      // ALERTE REPONSE
                                      alerte.reponse != null ? Row(
                                        children: [
                                          SizedBox(width: 35,),
                                          reponseWidget(context, reponse: alerte.reponse, alerte: alerte)
                                        ],
                                      ) : Container()
                                    ],
                                  ),
                                ),
                              ),
                            );;
                          }
                  );
                }
              }
            }),
          )
        ],
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

  reponseWidget(BuildContext context, {Reponse? reponse, Alerte? alerte}){
    return Container(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 5.0),
        child: Row(
          children: [
            // CircleAvatar(
            //   backgroundColor: Colors.grey,
            // ),
            SizedBox(width: 8,),
            Container(
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(8)
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextWidget(text: reponse?.sender_name.toString(), fontWeight: FontWeight.bold, fontSize: 16,
                    maxLine: 10,
                  ),
                  TextWidget(text: reponse?.sender_poste.toString(), color: Colors.blue, fontSize: 16,
                    maxLine: 10,),
                  SizedBox(height: 2,),
                  Container(
                    width: MediaQuery.of(context).size.width - 80,
                    child: Row(
                      children: [
                        Flexible(
                          child: TextWidget(text: reponse!.contenu.toString(), maxLine: 4,
                            fontSize: 16, overFlow: reponse.contenu.toString().length > 100 ? TextOverflow.ellipsis : null,
                          ),
                        )
                      ],
                    ),
                  ),
                  if(reponse.contenu.toString().length > 100 || reponse.fileUrl != null)
                    GestureDetector(
                      onTap: (){
                        controller.setSelectedAlerte(alerte!);
                        // Navigator.pushNamed(context, showAlerteRoute);
                      },
                      child: TextWidget(text: '...Voir plus', color: Colors.red, fontSize: 16, fontWeight: FontWeight.bold,),
                    )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }


}
