
import 'package:flutter/material.dart';
import 'package:jaime_yakro/app/Utils/app_colors.dart';
import 'package:jaime_yakro/app/widgets/text_widget.dart';


class NotificationWidget extends StatelessWidget {
  final int? count;
  final VoidCallback? action;
  final IconData icon;
  final Color? color;

  NotificationWidget({this.count, this.action, this.color, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        IconButton(
            onPressed: action,
            icon: Icon(icon, color: color != null ? color : AppColors.vert_color_fonce, size: 30,)
        ),
        count != null ? Positioned(
          left: 5,
          top: -3,
          child: Badge(
   
            backgroundColor:  AppColors.rouge_doux_leger,
            label: TextWidget(text: count.toString(), alignement: TextAlign.center,
              fontWeight: FontWeight.bold,color: Colors.white,fontSize: 12,
            ),
          ),
        ) : Container()
      ],
    );
  }
}


