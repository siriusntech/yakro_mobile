import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../Utils/app_colors.dart';
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

class AlerteMineView extends GetView<AlerteController> {
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
      appBar: AppBar(
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: settingsCtrl.appbarColorFromCode,
        title: TextWidget(text: "Mes alertes",fontSize: 18.0,
            color: Colors.white, fontWeight: FontWeight.bold
        ),
        actions: [
          IconButton(
              onPressed: (){
                controller.refresh();
              },
              icon: Icon(Icons.refresh, color: Colors.white, size: 30,)
          )
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(2.0),
        child: RefreshIndicator(
          onRefresh: () async {
            controller.refresh();
          },
          child: Column(
            children: [
              Container(
                height: 45,
                width: double.infinity,
                child: Center(
                  child: ListView(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    children: [
                      Obx(() => Row(
                        children: [
                          for(var type in controller.type_alertes_list) Card(
                            elevation: 2.0,
                            child: InkWell(
                              onTap: () {
                                if(controller.selected_type_alerte.value == '' || controller.selected_type_alerte.value != type){
                                  controller.selected_type_alerte.value = type.nom.toString();
                                  controller.selectedTypeAlerteModel.value = type;
                                  controller.getMyAlertesByType();
                                }else{
                                  controller.refresh();
                                }
                              },
                              child: Chip(
                                backgroundColor: type.nom == controller.selected_type_alerte.value ? Colors.amber : AppColors.chip_color,
                                label: TextWidget(text: type.nom.toString().toLowerCase(),
                                  fontSize: 14, fontWeight: FontWeight.bold, scaleFactor: 1.2,
                                ),
                              ),
                            ),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
                            color: Colors.transparent,
                          )
                        ],
                      ))
                    ],
                  ),
                ),
              ),
              Obx((){
                if(controller.isDataProcessing.value == true){
                  return LoadingWidget();
                } else {
                  if(controller.alerteList.length == 0){
                    return NoDataWidget();
                  } else {
                    return Expanded(
                        child: ListView.builder(
                            itemCount: controller.alerteList.length,
                            itemBuilder: (context, index) {
                              var alerte = controller.alerteList[index];
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
                        )
                    );
                  }
                }
              })
            ],
          ),
        ),
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
