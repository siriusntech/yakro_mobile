import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jaime_yakro/app/modules/discussion/discussion_model.dart';
import 'package:jaime_yakro/app/widgets/text_widget.dart';

import '../../../Utils/app_constantes.dart';
import '../../../Utils/default_image.dart';
import '../../../widgets/image_widget.dart';
import '../../zoom/controllers/zoom_controller.dart';
import '../../zoom/views/zoom_view.dart';
import 'discussion_tooltip_widget.dart';

class DiscussionCardWidget extends StatelessWidget {
  final Discussion discussion;
  final VoidCallback? action;
  final VoidCallback? editAction;
  final VoidCallback? deleteAction;
  final VoidCallback? commentAction;
  final int? userId;

  DiscussionCardWidget({required this.discussion, this.action, this.editAction, this.deleteAction, this.commentAction, this.userId});
  final ZoomController zoomCtrl = Get.put(ZoomController());
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 8),
      padding: EdgeInsets.all(8),
      child: Card(
        elevation: 0.0,
        child: Column(
          children: [
            ListTile(
              leading: CircleAvatar(
                child: Icon(Icons.person),
              ),
              title: Row(
                children: [
                  TextWidget(text: discussion.senderPseudo ?? '', fontSize: 16, fontWeight: FontWeight.bold,),
                  SizedBox(width: 25,),
                  userId == discussion.senderId ? IconButton(
                    onPressed: editAction,
                    icon: Icon(Icons.edit, color: Colors.blue, size: 25,),
                  ) : Container(),
                  userId == discussion.senderId ? IconButton(
                    onPressed: deleteAction,
                    icon: Icon(Icons.delete, color: Colors.red, size: 25,),
                  ) : Container(),
                ],
              ),
              subtitle: TextWidget(text: discussion.date, fontSize: 15, fontWeight: FontWeight.bold, color: Colors.grey,),
              // trailing: IconButton(
              //   onPressed: commentAction,
              //   icon: Icon(Icons.textsms, size: 25,),
              // ),
            ),
            TextWidget(text: discussion.sujet, alignement: TextAlign.start, fontSize: 18,),
            TextButton(onPressed: action,
                child: TextWidget(text: "Lire la suite...", alignement: TextAlign.start,
                  fontSize: 15, color: Colors.red, fontWeight: FontWeight.w600,
                ),
            ),
            Container(
              margin: EdgeInsets.only(top: 5, bottom: 5),
              alignment: Alignment.center,
              width: Get.width - 20,
              height: 250,
              child: GestureDetector(
                  child: ImageWidget(isNetWork: true, url:
                  discussion.medias![0].url, width: 250, height: 250, fit: BoxFit.contain,
                    default_image: DefaultImage.DISCUSSION,
                  ),
                  onTap: (){
                  zoomCtrl.setImageUrl(discussion.medias![0].url.toString());
                  Get.to(ZoomView(), fullscreenDialog: true);
                  },
              )
            ),
            Container(
              height: 50,
              padding: EdgeInsets.only(top: 3),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Flexible(
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          border: Border(right: BorderSide(color: Colors.grey, width: 1))
                        ),
                        child: DiscussionToolTipWidget( action: 'like', message: "J'aime", discussionModel: discussion,
                          child: Column(
                            children: [
                              Icon(Icons.thumb_up, color: discussion.liked == 1 ? Colors.red : mainColor,),
                              TextWidget(text: discussion.likeCount.toString(),alignement: TextAlign.center, fontSize: 16, fontWeight: FontWeight.bold,
                                color: discussion.liked == 1 ? Colors.red : mainColor,
                              ),
                            ],
                          ),
                        )
                      )
                  ),
                  Flexible(
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                            border: Border(right: BorderSide(color: Colors.grey, width: 1))
                        ),
                        child: DiscussionToolTipWidget( action: 'un_like', message: "J'aime pas", discussionModel: discussion,
                          child: Column(
                            children: [
                              Icon(Icons.thumb_down, color: discussion.liked == 2 ? Colors.red : mainColor,),
                              TextWidget(text: discussion.unLikeCount.toString(),alignement: TextAlign.center,fontSize: 16, fontWeight: FontWeight.bold,
                                  color: discussion.liked == 2 ? Colors.red : mainColor
                              ),
                            ],
                          ),
                        )
                      )
                  ),
                  Flexible(
                      child: Container(
                        width: double.infinity,
                        child: InkWell(
                          onTap: commentAction,
                          child: Column(
                            children: [
                              Icon(Icons.comment, color: mainColor,),
                              TextWidget(text: discussion.commentaires?.length.toString(),alignement: TextAlign.center,fontSize: 16, fontWeight: FontWeight.bold, color: mainColor,),
                            ],
                          ),
                        )
                      )
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}



class DiscussionSimpleCardWidget extends StatelessWidget {
  final Discussion discussion;
  final VoidCallback? action;
  final VoidCallback? editAction;
  final VoidCallback? deleteAction;
  final VoidCallback? commentAction;
  final int? userId;

  DiscussionSimpleCardWidget({required this.discussion, this.action, this.editAction, this.deleteAction, this.commentAction, this.userId});


  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 8),
      padding: EdgeInsets.all(8),
      child: Card(
        elevation: 0.0,
        child: Column(
          children: [
            ListTile(
              leading: CircleAvatar(
                child: Icon(Icons.person),
              ),
              title: Row(
                children: [
                  TextWidget(text: discussion.senderPseudo, fontSize: 16, fontWeight: FontWeight.bold,),
                ],
              ),
              subtitle: TextWidget(text: discussion.date, fontSize: 15, fontWeight: FontWeight.bold, color: Colors.grey,),
            ),
            TextWidget(text: discussion.sujet, alignement: TextAlign.start, fontSize: 16,),
          ],
        ),
      ),
    );
  }
}