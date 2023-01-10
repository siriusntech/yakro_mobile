import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jaime_cocody/app/data/repository/data/Env.dart';
import 'package:jaime_cocody/app/widgets/image_widget.dart';

import '../../../Utils/default_image.dart';
import '../../../widgets/text_widget.dart';
import '../information_model.dart';

class InfoCardWidget extends StatelessWidget {

  final Information information;
  final VoidCallback action;

  InfoCardWidget({required this.information, required this.action});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: Theme.of(context).dividerColor))
      ),
      margin: EdgeInsets.only(bottom: 15),
      child: Stack(
        children: [
          ListTile(
            minLeadingWidth: 80,
            contentPadding: EdgeInsets.all(0.0),
            leading: ImageWidget(isNetWork: true, url:
            information.medias![0].url, default_image: DefaultImage.BON_A_SAVOIR,
            ),
            trailing: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: action,
                  child: Icon(Icons.arrow_forward_ios, size: 30, color: Colors.grey,),
                )
              ],
            ),
            title: Container(
              // height: 100,
              padding: EdgeInsets.only(top: 5, bottom: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SelectableTextWidget(text: information.titre, fontSize: 16, fontWeight: FontWeight.bold,),
                  SizedBox(height: 6,),
                  SelectableTextWidget(
                    text: information.description!.length > 125 ? information.description!.substring(0, 125).toString()+' ...' : information.description.toString()+' ...',
                    fontSize: 16,
                  )
                ],
              ),
            ),
          ),
          information.is_read == 0 ? Positioned(
              top: 0.0,
              left: 45,
              child: Badge(
                shape: BadgeShape.square,
                badgeContent: Icon(Icons.newspaper, color: Colors.red, size: 20,),
                badgeColor: Colors.transparent,
                elevation: 0.0,
              )
          ) : Container()
        ],
      )
    );
  }
}

// Row(
// crossAxisAlignment: CrossAxisAlignment.start,
// children: [
// Flexible(
// flex: 2,
// child: Container(
// width: 80,
// height: 100,
// child: Image.network(siteUrl+information.medias![0].url!)
// )
// ),
// Flexible(
// flex: 8,
// child: Container(
// // height: 100,
// padding: EdgeInsets.only(left: 15 ,top: 5, bottom: 8),
// child: Column(
// crossAxisAlignment: CrossAxisAlignment.start,
// children: [
// SelectableTextWidget(text: information.titre, fontSize: 16, fontWeight: FontWeight.bold,),
// SizedBox(height: 6,),
// SelectableTextWidget(
// text: information.description!.length > 125 ? information.description!.substring(0, 125).toString()+' ...' : information.description.toString()+' ...',
// fontSize: 16,
// )
// ],
// ),
// ),
// ),
// Flexible(
// flex: 1,
// child: Center(
// child: Column(
// mainAxisAlignment: MainAxisAlignment.center,
// children: [
// SizedBox(height: 40,),
// Icon(Icons.arrow_forward_ios, size: 30, color: Colors.grey,)
// ],
// ),
// )
// )
// ]
// )