import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:get/get.dart';
import 'package:mon_plateau/app/modules/discussion/discussion_model.dart';
import '../../../Utils/app_routes.dart';
import '../../../widgets/loading_widget.dart';
import '../../../widgets/no_data_widget.dart';
import '../../../widgets/text_widget.dart';
import '../controllers/discussion_controller.dart';
import '../widgets/discussion_card_widget.dart';

class DiscussionView extends GetView<DiscussionController> {

  Discussion disc = Discussion();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: TextWidget(text: 'Discussions', fontSize: 20, fontWeight: FontWeight.bold,),
        centerTitle: true,
        elevation: 0.0,
        actions: [
          IconButton(
              onPressed: (){
                controller.refresh();
              },
              icon: Icon(Icons.refresh, color: Colors.white, size: 30,)
          )
        ],
      ),
      body: GestureDetector(
         onTap: (){
           FocusScope.of(context).requestFocus(FocusNode());
         },
        child: RefreshIndicator(
          onRefresh: () async{
            controller.refresh();
          },
          child: SafeArea(
            child: Obx((){
              if(controller.isDataProcessing.value == true){
                return LoadingWidget();
              } else {
                if(controller.discussionList.length == 0){
                  return NoDataWidget();
                } else {
                  return ListView.builder(
                      padding: EdgeInsets.only(bottom: 60),
                      itemCount: controller.discussionList.length,
                      itemBuilder: (context, index) {
                        var discussion = controller.discussionList[index];
                        return DiscussionCardWidget(discussion: discussion, userId: controller.user_id.value,
                          action: (){
                            controller.setSelectedDiscussion(discussion);
                            Get.toNamed(AppRoutes.SHOW_DISCUSSION);
                          },
                          editAction: (){
                            controller.setSelectedDiscussion(discussion);
                            controller.showEditHistoriqueForm();
                          },
                          deleteAction: (){
                            controller.setSelectedDiscussion(discussion);
                            controller.confirmDelete(discussion.id);
                          },
                          commentAction: (){
                            controller.setSelectedDiscussion(discussion);
                            controller.showAddCommentaireForm();
                          },
                        );
                      }
                  );
                }
              }
            }),
          ),
        )
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: (){
          controller.showAddHistoriqueForm();
        },
        icon: Icon(Icons.chat, color: Colors.white, size: 30,),
        label: TextWidget(text: 'Envoyer un sujet', fontSize: 16, fontWeight: FontWeight.bold,),
      ),
    );
  }
}
