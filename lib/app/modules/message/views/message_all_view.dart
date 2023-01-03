import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../Utils/app_constantes.dart';
import '../../../Utils/app_routes.dart';
import '../../../data/repository/data/Env.dart';
import '../../../widgets/loading_widget.dart';
import '../../../widgets/my_message_tooltip_widget.dart';
import '../../../widgets/no_data_widget.dart';
import '../../../widgets/text_widget.dart';
import '../../../widgets/video_widget.dart';
import '../controllers/message_controller.dart';

class MessageAllView extends GetView<MessageController> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: appbarColorFromCode,
        title: Text("Tous les Messages envoyés",
          style: TextStyle(
              fontSize: 18.0,
              color: Colors.white,
              fontWeight: FontWeight.bold
          ),
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
      body: RefreshIndicator(
        onRefresh: () async{
          controller.refresh();
        },
        child: Container(
          padding: EdgeInsets.all(2.0),
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
                      Obx(()=>Row(
                        children: [
                          if(controller.allMessagesTypesList.length == 0)
                            Container()
                          else
                            for(var type in controller.allMessagesTypesList) Card(
                              elevation: 0.0,
                              child: InkWell(
                                onTap: () async{
                                  if(controller.selectedType.value == '' || controller.selectedType.value != type.nom){
                                    controller.setSelectedType(type.nom);
                                    controller.setSelectedMessageType(type);
                                    controller.getMessagesByType(type.id);
                                    // print(type.id);
                                  }else{
                                    controller.refresh();
                                  }
                                },
                                child: Chip(
                                  elevation: 5.0,
                                  backgroundColor: controller.selectedType.value ==  type.nom.toString() ? Colors.amber : Colors.black26,
                                  label: TextWidget(text: type.nom.toString().toLowerCase(),
                                    fontSize: 14, fontWeight: FontWeight.bold, scaleFactor: 1.2,
                                  ),
                                ),
                              ),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
                              color: Colors.transparent,
                            ),
                        ],
                      ))
                    ],
                  ),
                ),
              ),
              Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
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
        ),
      ),
    );
  }
}
