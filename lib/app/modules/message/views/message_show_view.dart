import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../Utils/app_constantes.dart';
import '../../../Utils/app_routes.dart';
import '../../../data/repository/data/Env.dart';
import '../../../widgets/my_message_tooltip_widget.dart';
import '../../../widgets/text_widget.dart';
import '../../../widgets/video_widget.dart';
import '../controllers/message_controller.dart';

class MessageShowView extends GetView<MessageController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: appbarColorFromCode,
        title: Text("Messages envoyés",
          style: TextStyle(
              fontSize: 18.0,
              color: Colors.white,
              fontWeight: FontWeight.bold
          ),
        ),
        actions: [
          IconButton(
              onPressed: (){
                 controller.goToEditPage();
                 Get.toNamed(AppRoutes.EDIT_MESSAGE);
              },
              icon: Icon(Icons.edit, color: Colors.white,)
          ),
          IconButton(
              onPressed: (){
                 controller.confirmDelete(controller.selectedMessage.value.id);
              },
              icon: Icon(Icons.delete, color: Colors.red,)
          ),
        ],
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Obx(()=>Column(
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
                        TextWidget(text: controller.selectedMessage.value.senderPseudo, fontWeight: FontWeight.bold, fontSize: 14,),
                        SizedBox(width: 15,),
                        TextWidget(text: controller.selectedMessage.value.date, color: Colors.grey, fontWeight: FontWeight.bold,),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 5,),
              Row(
                children: [
                  SizedBox(width: 4,),
                  TextWidget(text: '#'+controller.selectedMessage.value.type.toString(), fontWeight: FontWeight.bold, scaleFactor: 1.2,color: Colors.blue,),
                ],
              ),
              SizedBox(height: 5,),
              Row(
                children: [
                  SizedBox(width: 5,),
                  Container(
                    width: MediaQuery.of(context).size.width-30,
                    child: TextWidget(text: controller.selectedMessage.value.libelle, fontWeight: FontWeight.bold, scaleFactor: 1.2, color: Colors.red, maxLine: 3,),
                  )
                ],
              ),
              SizedBox(height: 5,),
              Padding(
                padding: const EdgeInsets.only(left: 3.0),
                child: Text(controller.selectedMessage.value.description!, overflow: TextOverflow.ellipsis, textScaleFactor: 1.2,
                  style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey),
                  maxLines: 15,
                ),
              ),
              SizedBox(height: 5,),
              Container(
                width: double.infinity,
                height: 250,
                child: controller.selectedMessage.value.fileType == 'image' ? Image(
                  image: controller.selectedMessage.value.fileUrl.toString().contains('picsum') ?
                  NetworkImage(controller.selectedMessage.value.fileUrl.toString()) : NetworkImage(siteUrl+controller.selectedMessage.value.fileUrl.toString()),
                  fit: controller.selectedMessage.value.fileUrl.toString().contains('default') ? BoxFit.contain : BoxFit.cover,
                ) : VideoWidget(fileUrl: siteUrl+controller.selectedMessage.value.fileUrl.toString(),from: 'network',),
              ),
              SizedBox(height: 5,),
              Divider(),
              controller.selectedMessage.value.type.toString().contains('Felicitation') || controller.selectedMessage.value.type.toString().contains('Suggestion') ?
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(width: 3,),
                  Row(
                    children: [
                      MyMessageToolTipWidget(message: "j'aime", messageModel: controller.selectedMessage.value, action: 'like',
                        child: Icon(Icons.thumb_up, color: controller.selectedMessage.value.liked == 1 ? Colors.red : Colors.black,),
                      ),
                      SizedBox(width: 3,),
                      TextWidget(text: controller.selectedMessage.value.likeCount.toString(), fontWeight: FontWeight.bold,color: Colors.blue,),
                    ],
                  ),
                  SizedBox(width: 15,),
                  Row(
                    children: [
                      MyMessageToolTipWidget(message: "j'aime pas", messageModel: controller.selectedMessage.value, action: 'un_like',
                        child: Icon(Icons.thumb_down, color: controller.selectedMessage.value.liked == 2 ? Colors.red : Colors.black,),
                      ),
                      SizedBox(width: 3,),
                      TextWidget(text: controller.selectedMessage.value.unLikeCount.toString(), fontWeight: FontWeight.bold,color: Colors.red,),
                    ],
                  )
                ],
              ) : Container()
            ],
          )),
        ),
      ),
    );
  }

}
