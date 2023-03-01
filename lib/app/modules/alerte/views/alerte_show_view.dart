import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:jaime_cocody/app/Utils/app_routes.dart';

import '../../../Utils/app_constantes.dart';
import '../../../Utils/default_image.dart';
import '../../../data/repository/data/Env.dart';
import '../../../widgets/alerte_widgets.dart';
import '../../../widgets/image_widget.dart';
import '../../../widgets/my_alerte_tooltip_widget.dart';
import '../../../widgets/text_widget.dart';
import '../../../widgets/video_widget.dart';
import '../../zoom/controllers/zoom_controller.dart';
import '../../zoom/views/zoom_view.dart';
import '../alerte_model.dart';
import '../controllers/alerte_controller.dart';

class AlerteShowView extends GetView<AlerteController> {

  final ZoomController zoomCtrl = Get.put(ZoomController());

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
        elevation: 0.0,
        backgroundColor: appbarColorFromCode,
        title: Text("Incidents signalés",
          style: TextStyle(
              fontSize: 18.0,
              color: Colors.white,
              fontWeight: FontWeight.bold
          ),
        ),
        actions: controller.user_id.value == controller.selectedAlerte.value.senderId ? [
          IconButton(
              onPressed: (){
                // Navigator.push(context,
                //     MaterialPageRoute(builder: (context) => EditAlertePage())
                // );
                controller.setSelectedAlerte(controller.selectedAlerte.value);
                controller.goToEditPage();
              },
              icon: Icon(Icons.edit, color: Colors.white,)
          ),
          IconButton(
              onPressed: (){
                controller.confirmDelete(controller.selectedAlerte.value.id);
                // showDeleteAlerte(context, "Voulez-vous supprimer cette alerte ?", controller.selectedAlerte.value.id.toString(), controller);
              },
              icon: Icon(Icons.delete, color: Colors.red,)
          ),
        ] : [],
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Obx(() => ListView(
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
                        TextWidget(text: controller.selectedAlerte.value.senderPseudo, fontWeight: FontWeight.bold, fontSize: 14,),
                        SizedBox(width: 15,),
                        TextWidget(text: controller.selectedAlerte.value.date, color: Colors.grey, fontWeight: FontWeight.bold,),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 5,),
              Row(
                children: [
                  SizedBox(width: 3,),
                  Image.asset(AlerteImage(controller.selectedAlerte.value.type.toString()),
                    width: 25,
                    height: 25,
                  ),
                  SizedBox(width: 10,),
                  TextWidget(text: controller.selectedAlerte.value.type, fontWeight: FontWeight.bold, scaleFactor: 1.2,color: Colors.blue,),
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
                    width: MediaQuery.of(context).size.width-56,
                    child: TextWidget(text: controller.selectedAlerte.value.localisation, fontWeight: FontWeight.bold, scaleFactor: 1.2, color: Colors.red, maxLine: 3,),
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
                  TextWidget(text: controller.selectedAlerte.value.dateIncident, fontWeight: FontWeight.w600, color: Colors.black,),
                ],
              ),
              SizedBox(height: 5,),
              Padding(
                padding: const EdgeInsets.only(left: 3.0),
                child: Text(controller.selectedAlerte.value.description!, overflow: TextOverflow.ellipsis, textScaleFactor: 1.2,
                  style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey),
                  maxLines: 15,
                ),
              ),
              SizedBox(height: 5,),
              Container(
                width: double.infinity,
                height: 250,
                child: controller.selectedAlerte.value.fileType == 'image' ?
                GestureDetector(
                  child: ImageWidget(isNetWork: true, url:
                  controller.selectedAlerte.value.fileUrl, width: 250, height: 250, fit: BoxFit.contain,
                    default_image: DefaultImage.ALERTE,
                  ),
                  onTap: (){
                    zoomCtrl.setImageUrl(controller.selectedAlerte.value.fileUrl.toString());
                    Get.to(ZoomView(), fullscreenDialog: true);
                  },
                ) : VideoWidget(fileUrl: siteUrl+controller.selectedAlerte.value.fileUrl.toString(),from: 'network',),
              ),
              SizedBox(height: 5,),
              Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(width: 3,),
                  Row(
                    children: [
                      liked(controller.selectedAlerte.value),
                      SizedBox(width: 3,),
                      TextWidget(text: controller.selectedAlerte.value.likeCount.toString(), fontWeight: FontWeight.bold,color: Colors.blue,),
                    ],
                  ),
                  SizedBox(width: 15,),
                  Row(
                    children: [
                      unLiked(controller.selectedAlerte.value),
                      SizedBox(width: 3,),
                      TextWidget(text: controller.selectedAlerte.value.unLikeCount.toString(), fontWeight: FontWeight.bold,color: Colors.red,),
                    ],
                  )
                ],
              ),
              SizedBox(height: 8,),
              // ALERTE REPONSE
              controller.selectedAlerte.value.reponse != null ? Row(
                children: [
                  SizedBox(width: 35,),
                  reponseWidget(context, reponse: controller.selectedAlerte.value.reponse, alerte: controller.selectedAlerte.value),
                ],
              ) : Container()
            ],
          )),
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
