
import 'package:jaime_cocody/app/widgets/text_widget.dart';

import '../../../Utils/app_icons.dart';
import '../../../models/trajet_model.dart';
import '../controllers/trajet_controller.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TrajetCardWidget extends StatelessWidget {
  final TrajetModel trajet;
  final VoidCallback? action;

  TrajetCardWidget({required this.trajet, this.action});

  final controller = Get.find<TrajetController>();

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: action,
      child: Card(
        elevation: 0,
        child: Padding(
          padding: EdgeInsets.all(5),
          child: Column(
            children: [
              Row(
                children: [
                  Image.asset(AppIcons.depart,
                    width: 20,
                    height: 20,
                  ),
                  TextWidget(text: trajet.depart, fontWeight: FontWeight.bold, color: Colors.grey[700],)
                ],
              ),
              SizedBox(height: 2,),
              Row(
                children: [
                  Image.asset(AppIcons.arriver,
                    width: 20,
                    height: 20,
                  ),
                  TextWidget(text: trajet.destination, fontWeight: FontWeight.bold, color: Colors.grey[700],)
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}