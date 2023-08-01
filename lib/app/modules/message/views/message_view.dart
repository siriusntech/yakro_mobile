import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:jaime_yakro/app/Utils/app_routes.dart';

import '../../../Utils/app_constantes.dart';
import '../../../controllers/main_controller.dart';
import '../../../data/repository/data/Env.dart';
import '../../../widgets/loading_widget.dart';
import '../../../widgets/my_message_tooltip_widget.dart';
import '../../../widgets/no_data_widget.dart';
import '../../../widgets/text_widget.dart';
import '../../../widgets/video_widget.dart';
import '../controllers/message_controller.dart';

class MessageView extends GetView<MessageController> {
  final MainController settingsCtrl = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: settingsCtrl.appbarColorFromCode,
        title: Text("Le maire vous écoute",
          style: TextStyle(
              fontSize: 18.0,
              color: Colors.white,
              fontWeight: FontWeight.bold
          ),
        ),
      ),
      body: ListView(
        shrinkWrap: true,
        children: [
          Container(
            margin: EdgeInsets.only(bottom: 5.0, top: 8),
            color: Colors.white,
            width: double.infinity,
            height: 200,
            child: Image(
              image: AssetImage(MESSAGE_BG),
              fit: BoxFit.contain,
            ),
          ),
          TextButton(
            onPressed: (){
              Get.toNamed(AppRoutes.MES_MESSAGES);
            },
            child: TextWidget(text: "Voir tous mes messages",
              color: Colors.red, fontSize: 15,
              scaleFactor: 1.2,fontWeight: FontWeight.bold,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Obx(() {
              return Column(
                children: [
                  if(controller.isAllDataProcessing.value == true)
                    LoadingWidget()
                  else if(controller.menuMessageTypesList.length == 0)
                    Container()
                  else
                    for(var msg in controller.menuMessageTypesList) Card(
                    elevation: 2.0,
                    child: InkWell(
                      onTap: () {
                        controller.setSelectedMessageType(msg);
                        controller.setSelectedType(msg.nom.toString());
                        Get.toNamed(AppRoutes.ADD_MESSAGE);
                      },
                      child: ListTile(
                        title: Text(msg.nom.toString(), style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.w600), textScaleFactor: 1.2,),
                        trailing: Icon(Icons.arrow_forward_ios),
                      ),
                    ),
                  ),
                  Card(
                    elevation: 2.0,
                    child: InkWell(
                      onTap: () {

                      },
                      child: ListTile(
                        title: Text("Nos Contacts", style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.w600), textScaleFactor: 1.2,),
                        trailing: Icon(Icons.arrow_forward_ios),
                      ),
                    ),
                  )
                ],
              );
            }),
          ),
          SizedBox(height: 20,),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 2.0),
            decoration: BoxDecoration(
                color: appbarColorFromCode
            ),
            child: Row(
              children: [
                TextWidget(text: "Autres Messages",
                  fontSize: 16.0, color: Colors.white, fontWeight: FontWeight.w600,
                ),
                TextButton(
                    onPressed: (){
                      Get.toNamed(AppRoutes.ALL_MESSAGES);
                    },
                    child: TextWidget(text: "Voir tout",
                      fontSize: 16.0, color: Colors.red, fontWeight: FontWeight.bold,
                    )
                )
              ],
            ),
          ),
          Container(
              width: double.infinity,
              // height: MediaQuery.of(context).size.height / 1.2,
              padding: EdgeInsets.only(bottom: 10),
              child: Column(
                children: [
                  Obx((){
                    if(controller.isAllDataProcessing.value == true){
                      return LoadingWidget();
                    } else {
                      if(controller.allMessageList.length == 0){
                        return NoDataWidget();
                      } else {
                        return Expanded(
                            child: ListView.builder(
                                shrinkWrap: true,
                                physics: ClampingScrollPhysics(),
                                itemCount: controller.allMessageList.length,
                                itemBuilder: (context, index) {
                                  var message = controller.allMessageList[index];
                                  return InkWell(
                                    onTap: (){
                                      controller.setSelectedMessage(message);
                                      Get.toNamed(AppRoutes.SHOW_MESSAGE);
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
                                                      TextWidget(text: message.senderPseudo, fontWeight: FontWeight.bold, fontSize: 14,),
                                                      SizedBox(width: 15,),
                                                      TextWidget(text: message.date, color: Colors.grey, fontWeight: FontWeight.bold,),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(height: 5,),
                                            Row(
                                              children: [
                                                SizedBox(width: 4,),
                                                TextWidget(text: '#'+message.type.toString(), fontWeight: FontWeight.bold, scaleFactor: 1.2,color: Colors.blue,),
                                              ],
                                            ),
                                            SizedBox(height: 5,),
                                            Row(
                                              children: [
                                                SizedBox(width: 5,),
                                                Container(
                                                  width: MediaQuery.of(context).size.width-30,
                                                  child: TextWidget(text: message.libelle, fontWeight: FontWeight.bold, scaleFactor: 1.2, color: Colors.red,maxLine: 3, ),
                                                )
                                              ],
                                            ),
                                            SizedBox(height: 5,),
                                            Padding(
                                              padding: const EdgeInsets.only(left: 3.0),
                                              child: Text(message.description!, overflow: TextOverflow.ellipsis, textScaleFactor: 1.2,
                                                style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey),
                                                maxLines: 5,
                                              ),
                                            ),
                                            SizedBox(height: 5,),
                                            Container(
                                              width: double.infinity,
                                              height: 250,
                                              child: message.fileType == 'image' ? Image(
                                                image: message.fileUrl.toString().contains('picsum') ?
                                                NetworkImage(message.fileUrl.toString()) : NetworkImage(siteUrl+message.fileUrl.toString()),
                                                fit: message.fileUrl.toString().contains('default') ? BoxFit.contain : BoxFit.cover,
                                              ) : VideoWidget(fileUrl: siteUrl+message.fileUrl.toString(),from: 'network',),
                                            ),
                                            SizedBox(height: 5,),
                                            Divider(),
                                            message.type.toString().contains('Felicitation') || message.type.toString().contains('Suggestion') ?
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              children: [
                                                SizedBox(width: 3,),
                                                Row(
                                                  children: [
                                                    MyMessageToolTipWidget(message: "j'aime", messageModel: message, action: 'like',
                                                      child: Icon(Icons.thumb_up, color: message.liked == 1 ? Colors.red : Colors.black,),
                                                    ),
                                                    SizedBox(width: 3,),
                                                    TextWidget(text: message.likeCount.toString(), fontWeight: FontWeight.bold,color: Colors.blue,),
                                                  ],
                                                ),
                                                SizedBox(width: 15,),
                                                Row(
                                                  children: [
                                                    MyMessageToolTipWidget(message: "j'aime pas", messageModel: message, action: 'un_like',
                                                      child: Icon(Icons.thumb_down, color: message.liked == 2 ? Colors.red : Colors.black,),
                                                    ),
                                                    SizedBox(width: 3,),
                                                    TextWidget(text: message.unLikeCount.toString(), fontWeight: FontWeight.bold,color: Colors.red,),
                                                  ],
                                                )
                                              ],
                                            ) :
                                            Container()
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                }
                            )
                        );
                      }
                    }
                  })
                ],
              )
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: settingsCtrl.mainColor,
        onPressed: (){
          Navigator.pushNamed(context, AppRoutes.HOME);
        },
        child: Icon(Icons.home, color: Colors.white, size: 40,),
      ),
    );
  }
}
