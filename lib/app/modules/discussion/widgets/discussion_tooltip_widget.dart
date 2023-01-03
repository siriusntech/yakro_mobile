
import 'package:flutter/material.dart';
import 'package:mon_plateau/app/modules/discussion/controllers/discussion_controller.dart';
import 'package:mon_plateau/app/modules/discussion/discussion_model.dart';
import 'package:get/get.dart';

class DiscussionToolTipWidget extends StatelessWidget {
  final Widget child;
  final String message;
  final String action;
  final Discussion discussionModel;

  DiscussionToolTipWidget({required this.message, required this.child, required this.action, required this.discussionModel});

  final controller = Get.find<DiscussionController>();

  @override
  Widget build(BuildContext context) {
    final key = GlobalKey<State<Tooltip>>();
    return Tooltip(
      key: key,
      message: message,
      textStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.red),
      waitDuration: Duration(seconds: 1),
      showDuration: Duration(seconds: 2),
      padding: EdgeInsets.all(10),
      preferBelow: false,
      triggerMode: TooltipTriggerMode.tap,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15)
      ),
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => _onTap(key),
        child: child,
      ),
    );
  }

  void _onTap(GlobalKey key) {
    final dynamic tooltip = key.currentState;
    tooltip?.ensureTooltipVisible();
    if(action == 'like'){
      if(discussionModel.liked == 2 || discussionModel.liked == 0 || discussionModel.liked == null){
        controller.likeDiscussion(discussionModel.id);
      }
    }
    if(action == 'un_like'){
      if(discussionModel.liked == 1 || discussionModel.liked == 0 || discussionModel.liked == null){
        controller.unLikeDiscussion(discussionModel.id);
      }
    }
  }

}