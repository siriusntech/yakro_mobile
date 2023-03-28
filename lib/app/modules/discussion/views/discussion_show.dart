import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:get/get.dart';
import 'package:jaime_cocody/app/modules/discussion/discussion_model.dart';
import '../../../Utils/app_constantes.dart';
import '../../../Utils/app_routes.dart';
import '../../../Utils/default_image.dart';
import '../../../controllers/main_controller.dart';
import '../../../widgets/image_widget.dart';
import '../../../widgets/loading_widget.dart';
import '../../../widgets/no_data_widget.dart';
import '../../../widgets/text_widget.dart';
import '../../../widgets/video_widget.dart';
import '../../zoom/controllers/zoom_controller.dart';
import '../../zoom/views/zoom_view.dart';
import '../controllers/discussion_controller.dart';
import '../widgets/commentaire_card_widget.dart';
import '../widgets/discussion_card_widget.dart';
import '../widgets/discussion_tooltip_widget.dart';

class DiscussionShow extends GetView<DiscussionController> {

  final ZoomController zoomCtrl = Get.put(ZoomController());
  final MainController settingsCtrl = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: TextWidget(text: 'Liste des commentaires', fontSize: 20, fontWeight: FontWeight.bold,),
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: settingsCtrl.appbarColorFromCode,
      ),
      body: GestureDetector(
         onTap: (){
           FocusScope.of(context).requestFocus(FocusNode());
         },
        child: SafeArea(
           child: Obx(() => Padding(
             padding: EdgeInsets.only(top: 8, right: 8, left: 8, bottom: 50),
               child: ListView(
                 // shrinkWrap: true,
                 // physics: ClampingScrollPhysics(),
                 children: [
                   Container(
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
                                 TextWidget(text: controller.selectedDiscussion.value.senderPseudo, fontSize: 16, fontWeight: FontWeight.bold,),
                                 SizedBox(width: 25,),
                                 controller.selectedDiscussion.value.senderId == controller.user_id.value ? TextButton(
                                   onPressed: (){
                                     controller.setSelectedDiscussion(controller.selectedDiscussion.value);
                                     controller.showEditHistoriqueForm();
                                   },
                                   child: TextWidget(text: "Editer", fontSize: 14, fontWeight: FontWeight.bold, color: Colors.blue,),
                                 ) : Container(),
                                 controller.selectedDiscussion.value.senderId == controller.user_id.value ? TextButton(
                                   onPressed: (){
                                     controller.setSelectedDiscussion(controller.selectedDiscussion.value);
                                     controller.confirmDelete(controller.selectedDiscussion.value.id);
                                   },
                                   child: TextWidget(text: "Supprimer", fontSize: 14, fontWeight: FontWeight.bold, color: Colors.red,),
                                 ) : Container(),
                               ],
                             ),
                             subtitle: TextWidget(text: controller.selectedDiscussion.value.date, fontSize: 15, fontWeight: FontWeight.bold, color: Colors.grey,),
                             // trailing: IconButton(
                             //   onPressed: (){
                             //     controller.setSelectedDiscussion(controller.selectedDiscussion.value);
                             //     controller.showAddCommentaireForm();
                             //   },
                             //   icon: Icon(Icons.textsms, size: 25,),
                             // ),
                           ),
                           TextWidget(text: controller.selectedDiscussion.value.sujet, alignement: TextAlign.start, fontSize: 16,),
                           Container(
                             margin: EdgeInsets.only(top: 5, bottom: 5),
                             alignment: Alignment.center,
                             width: Get.width - 20,
                             height: 250,
                             child: GestureDetector(
                               child: ImageWidget(isNetWork: true, url:
                               controller.selectedDiscussion.value.medias![0].url, width: 250, height: 250, fit: BoxFit.contain,
                                 default_image: DefaultImage.DISCUSSION,
                               ),
                               onTap: (){
                                 zoomCtrl.setImageUrl(controller.selectedDiscussion.value.medias![0].url.toString());
                                 Get.to(ZoomView(), fullscreenDialog: true);
                               },
                             ),
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
                                         child: DiscussionToolTipWidget( action: 'like', message: "J'aime", discussionModel: controller.selectedDiscussion.value,
                                           child: Column(
                                             children: [
                                               Icon(Icons.thumb_up, color: controller.selectedDiscussion.value.liked == 1 ? Colors.red : mainColor,),
                                               TextWidget(text: controller.selectedDiscussion.value.likeCount.toString(),alignement: TextAlign.center, fontSize: 16, fontWeight: FontWeight.bold,
                                                 color: controller.selectedDiscussion.value.liked == 1 ? Colors.red : mainColor,
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
                                         child: DiscussionToolTipWidget( action: 'un_like', message: "J'aime pas", discussionModel: controller.selectedDiscussion.value,
                                           child: Column(
                                             children: [
                                               Icon(Icons.thumb_down, color: controller.selectedDiscussion.value.liked == 2 ? Colors.red : mainColor,),
                                               TextWidget(text: controller.selectedDiscussion.value.unLikeCount.toString(),alignement: TextAlign.center,fontSize: 16, fontWeight: FontWeight.bold,
                                                   color: controller.selectedDiscussion.value.liked == 2 ? Colors.red : mainColor
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
                                             controller.showAddCommentaireForm();
                                           },
                                           child: Column(
                                             children: [
                                               Icon(Icons.comment, color: mainColor,),
                                               TextWidget(text: controller.selectedDiscussion.value.commentaires?.length.toString(),alignement: TextAlign.center,fontSize: 16, fontWeight: FontWeight.bold, color: mainColor,),
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
                   controller.commentaireList.length > 0 ? Container(
                     decoration: BoxDecoration(
                         border: Border(top: BorderSide(color: Colors.grey, width: 1),)
                     ),
                     child: TextWidget(text: "Commentaires", fontSize: 16, fontWeight: FontWeight.bold,),
                   ): Container(),
                   Container(
                       child: controller.isDataProcessing.value == true ?
                       LoadingWidget() :
                       controller.commentaireList.length == 0 ?
                       NoDataWidget() :
                       ListView.builder(
                           shrinkWrap: true,
                           physics: ClampingScrollPhysics(),
                           padding: EdgeInsets.only(top: 8,right: 8,left: 8, bottom:40),
                           itemCount: controller.commentaireList.length,
                           itemBuilder: (context,index){
                             var commentaire = controller.commentaireList[index];
                             return Column(
                               children: [
                                 CommentaireCardWidget(commentaireModel: commentaire, userId: controller.user_id.value,
                                   action: (){},
                                   editAction: (){
                                     controller.setSelectedCommentaire(commentaire);
                                     controller.showEditCommentaireForm();
                                   },
                                   deleteAction: (){
                                     controller.setSelectedCommentaire(commentaire);
                                     controller.confirmComDelete(commentaire.id);
                                   },
                                   commentAction: (){
                                     controller.setSelectedCommentaire(commentaire);
                                     controller.showAddReponseForm();
                                   },
                                 ),
                                 // commentaire.reponses?.length != 0 ?
                                 // ListView.builder(
                                 //     shrinkWrap: true,
                                 //     physics: ClampingScrollPhysics(),
                                 //     itemCount: commentaire.reponses?.length,
                                 //     itemBuilder: (context,index){
                                 //       var comment = commentaire.reponses![index];
                                 //       return CommentaireCardWidget(commentaireModel: comment, userId: controller.user_id.value,
                                 //         action: (){},
                                 //         editAction: (){
                                 //           controller.setSelectedCommentaire(commentaire);
                                 //           controller.showEditCommentaireForm();
                                 //         },
                                 //         deleteAction: (){
                                 //           controller.setSelectedCommentaire(commentaire);
                                 //           controller.confirmComDelete(commentaire.id);
                                 //         },
                                 //         commentAction: (){
                                 //           controller.setSelectedCommentaire(commentaire);
                                 //           controller.showAddReponseForm();
                                 //         },
                                 //       );
                                 //     }
                                 // )
                                 // : Container(),
                               ],
                             );
                           }
                       ),
                   )
                 ],
               )
           )),
        )
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: (){
          controller.showAddCommentaireForm();
        },
        icon: Icon(Icons.chat, color: Colors.white, size: 30,),
        label: TextWidget(text: 'Nouveau commentaire', fontSize: 16, fontWeight: FontWeight.bold,),
      ),
    );
  }
}


// Obx(() => Padding(
// padding: EdgeInsets.all(8.0),
// child: ListView(
// // shrinkWrap: true,
// // physics: ClampingScrollPhysics(),
// children: [
// Container(
// child: Column(
// crossAxisAlignment: CrossAxisAlignment.start,
// children: [
// SelectableTextWidget(text: controller.selectedHistorique.value.titre, fontSize: 16, fontWeight: FontWeight.bold,),
// SizedBox(height: 6,),
// SelectableTextWidget(text: controller.selectedHistorique.value.description.toString(), fontSize: 16,),
// Container(
// width: double.infinity,
// height: 200,
// child: ImageWidget(url: siteUrl+controller.selectedHistorique.value.medias![0].url!, isNetWork: true,),
// )
// ],
// ),
// ),
// controller.infosList.length > 0 ? Container(
// decoration: BoxDecoration(
// border: Border(top: BorderSide(color: Colors.grey, width: 1),)
// ),
// child: SelectableTextWidget(text: "Le savie-vous ?", fontSize: 16, fontWeight: FontWeight.bold,),
// ): Container(),
// Container(
// child: controller.isDataProcessing.value == true ?
// LoadingWidget() :
// controller.historiqueList.length == 0 ?
// NoDataWidget() :
// ListView.builder(
// shrinkWrap: true,
// physics: ClampingScrollPhysics(),
// padding: EdgeInsets.all(8.0),
// itemCount: controller.infosList.length,
// itemBuilder: (context,index){
// var information =  controller.infosList[index];
// return InfoCardWidget(
// information: information,
// action: () async{
// controller.setSelectedInformation(information);
// await controller.makeInformationIsRead(information.id);
// Get.toNamed(AppRoutes.SHOW_INFORMATION);
// },
// );
// }
// )
// )
// ],
// ),
// )