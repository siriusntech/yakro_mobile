import 'package:flutter/material.dart';
import 'package:jaime_cocody/app/Utils/app_constantes.dart';

import '../controllers/main_controller.dart';
import 'package:get/get.dart';


class LoadingWidget extends StatelessWidget {
  final MainController settingsCtrl = Get.find();
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: EdgeInsets.all(20.0),
        child: CircularProgressIndicator(color: settingsCtrl.mainColor, strokeWidth: 12,),
      ),
    );
  }
}