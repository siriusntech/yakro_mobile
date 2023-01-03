
import 'package:flutter/material.dart';
import 'package:mon_plateau/app/modules/alerte/controllers/alerte_controller.dart';
import 'package:mon_plateau/app/modules/alerte/alerte_model.dart';
import 'package:get/get.dart';

import '../modules/alerte/alerte_model.dart';

class MyAlerteToolTipWidget extends StatelessWidget {
  final Widget child;
  final String message;
  final String action;
  final Alerte alerteModel;

  MyAlerteToolTipWidget({required this.message, required this.child, required this.action, required this.alerteModel});

  final controller = Get.find<AlerteController>();

  @override
  Widget build(BuildContext context) {

    final key_alerte = GlobalKey<State<Tooltip>>();

    return Tooltip(
      key: key_alerte,
      message: message,
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
        onTap: () => _onTap(key_alerte),
        child: child,
      ),
    );
  }

  void _onTap(GlobalKey key) {
    final dynamic tooltip = key.currentState;
    tooltip?.ensureTooltipVisible();
    if(action == 'like'){
      if(alerteModel.liked == 2 || alerteModel.liked == 0 || alerteModel.liked == null){
        controller.likeAlerte(alerteModel.id);
      }
    }
    if(action == 'un_like'){
      if(alerteModel.liked == 1 || alerteModel.liked == 0 || alerteModel.liked == null){
        controller.unLikeAlerte(alerteModel.id);
      }
    }
  }
}