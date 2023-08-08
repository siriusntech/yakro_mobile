
import 'package:flutter/material.dart';
import '../../../Utils/default_image.dart';

import '../../../widgets/image_widget _baseUrl.dart';
import '../../../widgets/text_widget.dart';
import '../historique_model.dart';

class HistoriqueCardWidget extends StatelessWidget {

  final Historique historique;
  final VoidCallback action;

  HistoriqueCardWidget({required this.historique, required this.action});

  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: action,
      child: Container(
        decoration: BoxDecoration(
            border: Border(bottom: BorderSide(color: Theme.of(context).dividerColor))
        ),
        margin: EdgeInsets.only(bottom: 15),
        child: Stack(
          children: [
            ListTile(
              minLeadingWidth: 80,
              contentPadding: EdgeInsets.all(0.0),
              leading:
               ImageWidgetBaseUrl(isNetWork: true, url: historique.medias![0].url.toString(), width: 100, height: 80, fit: BoxFit.cover,
                default_image: DefaultImage.BON_A_SAVOIR,
              )
              ,
              title: Container(
                // height: 100,
                padding: EdgeInsets.only(top: 5, bottom: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextWidget(text: historique.titre, fontSize: 16, fontWeight: FontWeight.bold,),
                    SizedBox(height: 6,),
                    TextWidget(
                      text: historique.description!.length > 100 ? historique.description!.substring(0, 100).toString()+' ...' : historique.description.toString()+' ...',
                      fontSize: 15,
                    )
                  ],
                ),
              ),
            ),
            historique.is_read == 0 ? Positioned(
                top: 0.0,
                left: 60,
                child: Badge(
                   label: Icon(Icons.newspaper, color: Colors.red, size: 20,),
                   backgroundColor: Colors.transparent,
                )
            ) : Container()
          ],
        ),
      ),
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
// child: ImageWidget(url: historique.medias![0].url!, isNetWork: true,)
// )
// ),
// Flexible(
// flex: 8,
// child: Container(
// padding: EdgeInsets.only(left: 15 ,top: 5, bottom: 8),
// child: Column(
// crossAxisAlignment: CrossAxisAlignment.start,
// children: [
// SelectableTextWidget(text: historique.titre, fontSize: 16, fontWeight: FontWeight.bold,),
// SizedBox(height: 6,),
// SelectableTextWidget(
// text: historique.description!.length > 125 ? historique.description!.substring(0, 125).toString()+' ...' : historique.description.toString()+' ...',
// fontSize: 16,
// )
// ],
// ),
// ),
// ),
// Flexible(
// flex: 1,
// child: Container(
// alignment: Alignment.centerRight,
// child: Column(
// mainAxisAlignment: MainAxisAlignment.center,
// crossAxisAlignment: CrossAxisAlignment.end,
// children: [
// SizedBox(height: 35,),
// GestureDetector(
// onTap: action,
// child: Icon(Icons.arrow_forward_ios, size: 30, color: Colors.grey,),
// )
// ],
// ),
// )
// )
// ]
// ),