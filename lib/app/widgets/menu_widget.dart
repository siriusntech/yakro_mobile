import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jaime_yakro/app/Utils/app_constantes.dart';
import 'package:jaime_yakro/app/widgets/text_widget.dart';

// MY MENU
class MenuWidget extends StatelessWidget {
  final String? icon;
  final String? title;
  final String? subtitle;
  final double width;
  final double height;
  final bool? enabled;
  final int? itemCount;
  final Color? color;
  final Color? bgColor;
  final VoidCallback? action;

  MenuWidget(
      {this.color,
      this.bgColor,
      this.action,
      this.icon,
      this.title,
      this.subtitle,
      required this.width,
      required this.height,
      this.enabled,
      this.itemCount});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: enabled! ? action : null,
      child: Stack(
        children: [
          Container(
            margin: EdgeInsets.only(left: 5, right: 5, top: 2),
            width: width,
            height: height,
            child: Card(
              elevation: 25,
              color: enabled!
                  ? bgColor != null
                      ? bgColor
                      : Colors.white70
                  : Colors.transparent,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              child: Column(
                children: [
                  Expanded(
                      flex: 2,
                      child: Container(
                        child: enabled!
                            ? Image.asset(icon!)
                            : Icon(
                                Icons.settings,
                                size: 60,
                              ),
                        width: 60,
                        height: 60,
                      )),
                  enabled!
                      ? Expanded(
                          flex: 1,
                          child: Container(
                            child: Center(
                              child: TextWidget(
                                text: title,
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                alignement: TextAlign.center,
                              ),
                            ),
                            width: double.infinity,
                            height: double.infinity,
                            decoration: BoxDecoration(
                                color: color != null ? color : menuColor,
                                borderRadius: BorderRadius.only(
                                    bottomRight: Radius.circular(10),
                                    bottomLeft: Radius.circular(10))),
                          ))
                      : Container()
                ],
              ),
            ),
          ),
          Positioned(
            top: 12,
            left: 0,
            right: -110,
            child: itemCount != null && itemCount! > 0
                ? Badge(
                    // elevation: 2,
                    backgroundColor: Colors.white70,
                    label: SizedBox(
                        width: 30,
                        height: 30, //badge size
                        child: Center(
                          //aligh badge content to center
                          child: TextWidget(
                            text: itemCount.toString(),
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                            color: Colors.red,
                          ),
                        )),
                  )
                : Container(),
          )
        ],
      ),
    );
  }
}
