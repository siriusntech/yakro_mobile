import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mon_plateau/app/Utils/app_constantes.dart';
import 'package:mon_plateau/app/widgets/text_widget.dart';

class MenuUnWidget extends StatelessWidget {
  final String page;
  final String icon;
  final String title;
  final String subtitle;

  MenuUnWidget(this.page, this.icon, this.title, this.subtitle);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Get.toNamed(page);
      },
      child: Container(
        margin: EdgeInsets.only(left: 8, right: 8, top: 2),
        width: double.maxFinite,
        height: 80,
        child: Card(
          elevation: 25 ,
          color: Colors.white,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10)
          ),
          child: Row(
            children: [
              SizedBox(width: 5,),
              Container(
                child: Image.asset(icon, width: 40, height: 40,),
              ),
              SizedBox(width: 5,),
              Text("|", style: TextStyle(fontSize: 55.0, color: Colors.black38),),
              SizedBox(width: 10,),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextWidget(text: title, fontSize: 16.0, color: Colors.black87, fontWeight: FontWeight.bold),
                  SizedBox(height: 3,),
                  TextWidget(text: subtitle, fontSize: 13.0, color: Colors.black54, fontWeight: FontWeight.w600),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

// MY MENU
class MenuDeuxWidget extends StatelessWidget {
  final String? page;
  final String? icon;
  final String? title;
  final String? subtitle;
  final double width;
  final double height;
  final bool? enabled;
  final int? itemCount;
  final VoidCallback? action;

  MenuDeuxWidget({this.page, this.action, this.icon, this.title, this.subtitle, required this.width, required this.height, this.enabled, this.itemCount});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: enabled! ? (){
        Get.toNamed(page!);
      } : null,
      child: Stack(
        children: [
          Container(
            margin: EdgeInsets.only(left: 5, right: 5, top: 2),
            width: width,
            height: height,
            child: Card(
              elevation: 25 ,
              color: enabled! ? Colors.white70 : Colors.transparent,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)
              ),
              child: Column(
                children: [
                  Expanded(
                      flex: 2,
                      child: Container(
                        child: enabled! ? Image.asset(icon!) : Icon(Icons.settings, size: 60,),
                        width: 60,
                        height: 60,
                      )
                  ),
                  enabled! ? Expanded(
                      flex: 1,
                      child: Container(
                        child: Center(
                          child: TextWidget(text: title, color: Colors.white, fontSize: 16,
                            fontWeight: FontWeight.bold, alignement: TextAlign.center,),
                        ),
                        width: double.infinity,
                        height: double.infinity,
                        decoration: BoxDecoration(
                            color: menuColor,
                            borderRadius: BorderRadius.only(bottomRight: Radius.circular(10), bottomLeft: Radius.circular(10))
                        ),
                      )
                  ) : Container()
                ],
              ),
            ),
          ),
          Positioned(
              top: 12,
              left: 0,
              right: -110,
              child: itemCount != null && itemCount! > 0 ? Badge(
                elevation: 2,
                badgeColor: Colors.white70,
                badgeContent: SizedBox(
                    width: 30, height: 30, //badge size
                    child: Center(  //aligh badge content to center
                      child:  TextWidget(text: itemCount.toString(),
                        fontWeight: FontWeight.bold, fontSize: 14, color: Colors.red,
                      ),
                    )
                ),
             ) : Container(),
          )
        ],
      ),
    );
  }
}