import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jaime_cocody/app/Utils/app_constantes.dart';
import 'package:jaime_cocody/app/data/repository/data/Env.dart';
import 'package:jaime_cocody/app/widgets/image_widget.dart';

import '../../../Utils/default_image.dart';
import '../../../models/pharmacie_model.dart';
import '../../../widgets/text_widget.dart';

class PharmacieCardWidget extends StatelessWidget {

  final Pharmacie? pharmacie;
  final VoidCallback? action;

  PharmacieCardWidget({this.pharmacie, this.action});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: action,
      child: Container(
        margin: EdgeInsets.only(bottom: 8),
        padding: EdgeInsets.all(5),
        decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: Colors.grey))
        ),
        child: Row(
          children: [
            Flexible(
                flex: 2,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15)
                  ),
                  child: ImageWidget(isNetWork: true, url:
                  pharmacie!.photo, width: 80, height: 80, default_image: DefaultImage.PHARMACIE,
                  ),
                )
            ),
            Flexible(
                flex: 8,
                child: Padding(
                  padding: EdgeInsets.only(left: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextWidget(text: pharmacie!.nom, color: mainColor, fontSize: 18, fontWeight: FontWeight.bold, overFlow: TextOverflow.ellipsis),
                      TextWidget(text: pharmacie!.medecin, color: Colors.lightBlue, fontSize: 16, fontWeight: FontWeight.w600, overFlow: TextOverflow.ellipsis),
                      Row(
                          children: [
                            for(var ct in pharmacie!.contacts!)
                              Flexible(child: TextWidget(text: pharmacie!.contacts!.length > 1 ? ct.numero.toString()+ ' / ' : ct.numero.toString(), fontSize: 16))
                          ]
                      ),
                      TextWidget(text: pharmacie!.adresse.toString(),
                          color: mainColor, fontSize: 16, overFlow: TextOverflow.ellipsis,
                      )
                    ],
                  ),
                )
            ),
            Flexible(
                flex: 1,
                child: Icon(Icons.arrow_right_outlined, size: 50, color: mainColor,)
            )
          ],
        ),
      ),
    );
  }
}
