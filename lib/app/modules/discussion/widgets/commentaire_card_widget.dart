import 'package:flutter/material.dart';
import 'package:jaime_cocody/app/modules/discussion/controllers/discussion_controller.dart';
import 'package:jaime_cocody/app/modules/discussion/widgets/reponse_tooltip_widget.dart';
import 'package:jaime_cocody/app/widgets/text_widget.dart';
import 'package:get/get.dart';
import '../../../Utils/app_constantes.dart';
import '../commentaire_model.dart';
import 'commentaire_tooltip_widget.dart';

// COMMENT CARD
class CommentaireCardWidget extends StatelessWidget {
  final Commentaire commentaireModel;
  final VoidCallback? action;
  final VoidCallback? editAction;
  final VoidCallback? deleteAction;
  final VoidCallback? commentAction;
  final int? userId;

  CommentaireCardWidget({required this.commentaireModel, this.action, this.editAction, this.deleteAction, this.commentAction, this.userId});

  final controller = Get.find<DiscussionController>();

  @override
  Widget build(BuildContext context) {

    // var reponsesList = List<Commentaire>.empty(growable: true);
    // reponsesList.addAll(controller.getReponses(commentaireModel.id));

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          // margin: EdgeInsets.only(bottom: 1),
          padding: EdgeInsets.all(8),
          child: Card(
            color: Color(0xFFeeeeee),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
                side: commentaireModel.is_reponse == 0 ? BorderSide(color: Colors.grey, width: 1) : BorderSide.none,
            ),
            elevation: commentaireModel.is_reponse == 0 ? 4 : 0,
            child: Column(
              children: [
                ListTile(
                  leading: CircleAvatar(
                    child: Icon(Icons.person),
                  ),
                  title: Row(
                    children: [
                      TextWidget(text: commentaireModel.senderPseudo, fontSize: 16, fontWeight: FontWeight.bold,),
                      SizedBox(width: 25,),
                      userId == commentaireModel.senderId ? TextButton(
                        onPressed: editAction,
                        child: TextWidget(text: "Editer", fontSize: 14, fontWeight: FontWeight.bold, color: Colors.blue,),
                      ) : Container(),
                      userId == commentaireModel.senderId ? TextButton(
                        onPressed: deleteAction,
                        child: TextWidget(text: "Supprimer", fontSize: 14, fontWeight: FontWeight.bold, color: Colors.red,),
                      ) : Container(),
                    ],
                  ),
                  subtitle: TextWidget(text: commentaireModel.date, fontSize: 15, fontWeight: FontWeight.bold, color: Colors.grey,),
                  // trailing: IconButton(
                  //   onPressed: commentAction,
                  //   icon: Icon(Icons.textsms, size: 25,),
                  // ),
                ),
                TextWidget(text: commentaireModel.texte ?? '', alignement: TextAlign.start, fontSize: 15,),
                // Container(
                //   margin: EdgeInsets.only(top: 5, bottom: 5),
                //   alignment: Alignment.center,
                //   width: Get.width - 20,
                //   height: 250,
                //   child: ImageWidget(isNetWork: true,
                //     url: commentaire.medias![0].url, width: Get.width - 20, height: 250,
                //     fit: commentaire.medias![0].url.toString().contains('default') ? BoxFit.contain : BoxFit.cover,
                //   ),
                // ),
                Container(
                  height: 50,
                  padding: EdgeInsets.only(top: 3),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Flexible(
                          child: Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  border: Border(right: BorderSide(color: Colors.grey, width: 1))
                              ),
                              child: CommentaireToolTipWidget( action: 'like', message: "J'aime", commentaireModel: commentaireModel,
                                child: Column(
                                  children: [
                                    Icon(Icons.thumb_up, color: commentaireModel.liked == 1 ? Colors.red : mainColor,),
                                    TextWidget(text: commentaireModel.likeCount.toString(),alignement: TextAlign.center, fontSize: 16, fontWeight: FontWeight.bold,
                                      color: commentaireModel.liked == 1 ? Colors.red : mainColor,
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
                              child: CommentaireToolTipWidget( action: 'un_like', message: "J'aime pas", commentaireModel: commentaireModel,
                                child: Column(
                                  children: [
                                    Icon(Icons.thumb_down, color: commentaireModel.liked == 2 ? Colors.red : mainColor,),
                                    TextWidget(text: commentaireModel.unLikeCount.toString(),alignement: TextAlign.center,fontSize: 16, fontWeight: FontWeight.bold,
                                        color: commentaireModel.liked == 2 ? Colors.red : mainColor
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
                                    Icon(Icons.question_answer, color: mainColor,),
                                    TextWidget(text: commentaireModel.reponses.length.toString(),alignement: TextAlign.center,fontSize: 16, fontWeight: FontWeight.bold, color: mainColor,),
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
        ),
        commentaireModel.reponses.length > 0 ?
        Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  SizedBox(width: 18,),
                  TextWidget(text: 'Réponses:', fontWeight: FontWeight.bold, fontSize: 16,),
                ],
              ),
              Container(
                margin: EdgeInsets.only(left: 10),
                child: ListView.builder(
                    shrinkWrap: true,
                    physics: ClampingScrollPhysics(),
                    itemCount: commentaireModel.reponses.length,
                    itemBuilder: (context,index){
                      var comment = commentaireModel.reponses[index];
                      // print(comment.id.toString()+' '+comment.texte.toString()+' '+comment.date.toString());
                      return Column(
                        // shrinkWrap: true,
                        // physics: ClampingScrollPhysics(),
                        children: [
                          CommentaireCardWidget(commentaireModel: comment, userId: controller.user_id.value,
                            action: (){},
                            editAction: (){
                              print(comment.id.toString()+' '+comment.texte.toString());
                              controller.setSelectedCommentaire(comment);
                              controller.showEditCommentaireForm();
                            },
                            deleteAction: (){
                              controller.setSelectedCommentaire(comment);
                              controller.confirmComDelete(comment.id);
                            },
                            commentAction: (){
                              controller.setSelectedCommentaire(comment);
                              controller.showAddReponseForm();
                            },
                          )
                        ],
                      );
                    }
                ),
              ),
            ],
          ),
        ) : Container()
        // CommentaireReponseCardWidget(commentaireModel: commentaireModel, editAction: editAction, deleteAction: deleteAction, commentAction: commentAction, userId: userId,)
      ],
    );
  }
}

// COMMENT RESPONSE CARD
class CommentaireReponseCardWidget extends StatelessWidget {
  final Commentaire commentaireModel;
  final VoidCallback? action;
  final VoidCallback? editAction;
  final VoidCallback? deleteAction;
  final VoidCallback? commentAction;
  final int? userId;

  CommentaireReponseCardWidget({required this.commentaireModel, this.action, this.editAction, this.deleteAction, this.commentAction, this.userId});

  final controller = Get.find<DiscussionController>();

  @override
  Widget build(BuildContext context) {

    var reponse;

    return Container(
      // padding: EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              SizedBox(width: 35,),
              TextWidget(text: 'Réponses:', fontWeight: FontWeight.bold, fontSize: 16,),
            ],
          ),
          ListView.builder(
              shrinkWrap: true,
              physics: ClampingScrollPhysics(),
              itemCount: commentaireModel.reponses.length,
              itemBuilder: (context,index){
                var commentaire = commentaireModel.reponses[index];
                reponse = commentaire;
                return Column(
                  // shrinkWrap: true,
                  // physics: ClampingScrollPhysics(),
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 20),
                      padding: EdgeInsets.all(8),
                      child: Card(
                        color: Color(0xFFf2f2f2),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        elevation: 0.0,
                        child: Column(
                          children: [
                            ListTile(
                              leading: CircleAvatar(
                                child: Icon(Icons.person),
                              ),
                              title: Row(
                                children: [
                                  TextWidget(text: commentaire.senderPseudo, fontSize: 16, fontWeight: FontWeight.bold,),
                                  SizedBox(width: 25,),
                                  userId == commentaire.senderId ? TextButton(
                                    onPressed: editAction,
                                    child: TextWidget(text: "Editer", fontSize: 14, fontWeight: FontWeight.bold, color: Colors.blue,),
                                  ) : Container(),
                                  userId == commentaire.senderId ? TextButton(
                                    onPressed: deleteAction,
                                    child: TextWidget(text: "Supprimer", fontSize: 14, fontWeight: FontWeight.bold, color: Colors.red,),
                                  ) : Container(),
                                ],
                              ),
                              subtitle: TextWidget(text: commentaire.date, fontSize: 15, fontWeight: FontWeight.bold, color: Colors.grey,),
                            ),
                            // TextWidget(text: commentaire.senderPseudo ?? '', alignement: TextAlign.start, fontSize: 16, fontWeight: FontWeight.bold, color: Colors.blue,),
                            Text.rich(
                              TextSpan(
                                text: commentaire.senderPseudo.toString()+' ',
                                children: <InlineSpan>[
                                  TextSpan(
                                    text: commentaire.texte ?? '',
                                    style: TextStyle(fontSize: 15, color: Colors.black,fontWeight: FontWeight.normal),
                                  )
                                ],
                                style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold, color: Colors.blue,),
                              ),
                            ),
                            Container(
                              height: 50,
                              padding: EdgeInsets.only(top: 3),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Flexible(
                                      child: Container(
                                          width: double.infinity,
                                          decoration: BoxDecoration(
                                              border: Border(right: BorderSide(color: Colors.grey, width: 1))
                                          ),
                                          child: ReponseToolTipWidget( action: 'like', message: "J'aime", commentaireModel: commentaire,
                                            child: Column(
                                              children: [
                                                Icon(Icons.thumb_up, color: commentaire.liked == 1 ? Colors.red : mainColor,),
                                                TextWidget(text: commentaire.likeCount.toString(),alignement: TextAlign.center, fontSize: 16, fontWeight: FontWeight.bold,
                                                  color: commentaire.liked == 1 ? Colors.red : mainColor,
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
                                          child: ReponseToolTipWidget( action: 'un_like', message: "J'aime pas", commentaireModel: commentaire,
                                            child: Column(
                                              children: [
                                                Icon(Icons.thumb_down, color: commentaire.liked == 2 ? Colors.red : mainColor,),
                                                TextWidget(text: commentaire.unLikeCount.toString(),alignement: TextAlign.center,fontSize: 16, fontWeight: FontWeight.bold,
                                                    color: commentaire.liked == 2 ? Colors.red : mainColor
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
                                            onTap: (){
                                              controller.setSelectedCommentaire(commentaire);
                                              controller.showAddReponseForm();
                                            },
                                            child: Column(
                                              children: [
                                                Icon(Icons.question_answer, color: mainColor,),
                                                TextWidget(text: commentaire.reponses.length.toString(),alignement: TextAlign.center,fontSize: 16, fontWeight: FontWeight.bold, color: mainColor,),
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
                    ),
                    // Expanded(child: ),
                    //---- reponse---
                    // Row(
                    //   children: [
                    //     SizedBox(width: 60,),
                    //     TextWidget(text: 'Réponses:', fontWeight: FontWeight.bold, fontSize: 16,),
                    //   ],
                    // ),
                    // ListView.builder(
                    //     shrinkWrap: true,
                    //     physics: ClampingScrollPhysics(),
                    //     itemCount: commentaire.reponses.length,
                    //     itemBuilder: (context,index){
                    //       var comment = reponse.reponses[index];
                    //       return reponseCard(comment, userId, editAction, deleteAction, commentAction, controller);
                    //     }
                    // )
                    //----- reponse---
                  ],
                );
              }
          ),
        ],
      ),
    );
  }
}

Widget reponseCard(Commentaire commentaire, userId, editAction, deleteAction, commentAction, controller){
  return Container(
    margin: EdgeInsets.only(bottom: 1, left: 45),
    padding: EdgeInsets.all(8),
    child: Card(
      color: Color(0xFFf2f2f2),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 0.0,
      child: Column(
        children: [
          ListTile(
            leading: CircleAvatar(
              child: Icon(Icons.person),
            ),
            title: Row(
              children: [
                Flexible(child: TextWidget(text: commentaire.senderPseudo ?? '', fontSize: 16, fontWeight: FontWeight.bold,)),
                SizedBox(width: 25,),
                userId == commentaire.senderId ? Flexible(child: TextButton(
                  onPressed: editAction,
                  child: TextWidget(text: "Editer", fontSize: 14, fontWeight: FontWeight.bold, color: Colors.blue,),
                )) : Container(),
                userId == commentaire.senderId ? Flexible(child: TextButton(
                  onPressed: deleteAction,
                  child: TextWidget(text: "Supprimer", fontSize: 14, fontWeight: FontWeight.bold, color: Colors.red,),
                )) : Container(),
              ],
            ),
            subtitle: TextWidget(text: commentaire.date ?? '', fontSize: 15, fontWeight: FontWeight.bold, color: Colors.grey,),
          ),
          // TextWidget(text: commentaire.senderPseudo ?? '', alignement: TextAlign.start, fontSize: 16, fontWeight: FontWeight.bold, color: Colors.blue,),
          Text.rich(
            TextSpan(
              text: commentaire.senderPseudo.toString()+' ',
              children: <InlineSpan>[
                TextSpan(
                  text: commentaire.texte ?? '',
                  style: TextStyle(fontSize: 15, color: Colors.black,fontWeight: FontWeight.normal),
                )
              ],
              style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold, color: Colors.blue,),
            ),
          ),
          Container(
            height: 50,
            padding: EdgeInsets.only(top: 3),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Flexible(
                    child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                            border: Border(right: BorderSide(color: Colors.grey, width: 1))
                        ),
                        child: ReponseToolTipWidget( action: 'like', message: "J'aime", commentaireModel: commentaire,
                          child: Column(
                            children: [
                              Icon(Icons.thumb_up, color: commentaire.liked == 1 ? Colors.red : mainColor,),
                              TextWidget(text: commentaire.likeCount.toString(),alignement: TextAlign.center, fontSize: 16, fontWeight: FontWeight.bold,
                                color: commentaire.liked == 1 ? Colors.red : mainColor,
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
                        child: ReponseToolTipWidget( action: 'un_like', message: "J'aime pas", commentaireModel: commentaire,
                          child: Column(
                            children: [
                              Icon(Icons.thumb_down, color: commentaire.liked == 2 ? Colors.red : mainColor,),
                              TextWidget(text: commentaire.unLikeCount.toString(),alignement: TextAlign.center,fontSize: 16, fontWeight: FontWeight.bold,
                                  color: commentaire.liked == 2 ? Colors.red : mainColor
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
                          onTap: (){
                            controller.setSelectedCommentaire(commentaire);
                            controller.showAddReponseForm();
                          },
                          child: Column(
                            children: [
                              Flexible(child: Icon(Icons.question_answer, color: mainColor,),),
                              Flexible(
                                  child: TextWidget(
                                    text: commentaire.reponses.length.toString(),
                                    alignement: TextAlign.center,fontSize: 16, fontWeight: FontWeight.bold, color: mainColor,
                                  )
                              ),
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

// COMMENT SIMPLE CARD
class CommentaireSimpleCardWidget extends StatelessWidget {
  final Commentaire commentaire;
  final VoidCallback? action;
  final VoidCallback? editAction;
  final VoidCallback? deleteAction;
  final VoidCallback? commentAction;
  final int? userId;

  CommentaireSimpleCardWidget({required this.commentaire, this.action, this.editAction, this.deleteAction, this.commentAction, this.userId});


  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 8),
      padding: EdgeInsets.all(8),
      child: Card(
        color: Color(0xFFeeeeee),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        elevation: 0.0,
        child: Column(
          children: [
            ListTile(
              leading: CircleAvatar(
                child: Icon(Icons.person),
              ),
              title: Row(
                children: [
                  TextWidget(text: commentaire.senderPseudo, fontSize: 16, fontWeight: FontWeight.bold,),
                ],
              ),
              subtitle: TextWidget(text: commentaire.date, fontSize: 15, fontWeight: FontWeight.bold, color: Colors.grey,),
            ),
            TextWidget(text: commentaire.texte ?? '', alignement: TextAlign.start, fontSize: 15,),
          ],
        ),
      ),
    );
  }
}