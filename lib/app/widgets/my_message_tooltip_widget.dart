
import 'package:flutter/material.dart';
import 'package:mon_plateau/app/modules/message/controllers/message_controller.dart';
import 'package:mon_plateau/app/modules/message/message_model.dart';
import 'package:get/get.dart';

class MyMessageToolTipWidget extends StatelessWidget {
  final Widget child;
  final String message;
  final String action;
  final Message messageModel;

  MyMessageToolTipWidget({required this.message, required this.child, required this.action, required this.messageModel});

  final controller = Get.find<MessageController>();

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
      if(messageModel.liked == 2 || messageModel.liked == 0 || messageModel.liked == null){
        controller.likeMessage(messageModel.id);
      }
    }
    if(action == 'un_like'){
      if(messageModel.liked == 1 || messageModel.liked == 0 || messageModel.liked == null){
        controller.unLikeMessage(messageModel.id);
      }
    }
  }

}