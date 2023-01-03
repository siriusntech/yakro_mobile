import 'package:flutter/material.dart';

import '../../../Utils/app_constantes.dart';
import '../../../data/repository/data/Env.dart';
import '../../../models/annuaire.dart';
import 'package:get/get.dart';

import '../controllers/annuaire_controller.dart';


class AnnuaireCardWidget extends StatelessWidget {
  final Annuaire annuaire;
  final VoidCallback? action;

  AnnuaireCardWidget({required this.annuaire, this.action});

  final controller = Get.find<AnnuaireController>();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
          onTap: (){

          },
          child: Container(
              margin: EdgeInsets.only(bottom: 2.0),
              width: double.infinity,
              height: 120,
              child: Card(
                color: Colors.white,
                child: Row(
                  children: [
                    SizedBox(width: 3,),
                    Flexible(
                      child: Container(
                        height: 50,
                        width: 50,
                        child: CircleAvatar(
                          backgroundColor: Colors.amber,
                          radius: 50,
                          backgroundImage: annuaire.imageUrl.toString().contains('picsum') ?
                          NetworkImage(annuaire.imageUrl.toString()) : NetworkImage(siteUrl+annuaire.imageUrl.toString()
                          ),
                        ),
                      ),
                    ),
                    Flexible(
                      flex: 2,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              children: [
                                Image.asset(ICON_NAME, width: 20, height: 20,),
                                SizedBox(width: 3,),
                                Flexible(
                                    child: Text(annuaire.nom.toString().toUpperCase()+" "+annuaire.prenom.toString().toUpperCase(),
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 12.0,
                                          fontWeight: FontWeight.bold
                                      ),
                                      maxLines: 3,
                                    )
                                )
                              ],
                            ),
                            SizedBox(height: 3.0,),
                            Row(
                              children: [
                                Flexible(
                                    child: Image.asset(ICON_JOB, width: 20, height: 20,),
                                ),
                                SizedBox(width: 3,),
                                Flexible(
                                    child: Text(annuaire.poste!,
                                      style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 14.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    )
                                ),
                              ],
                            ),
                            SizedBox(height: 5.0,),
                            InkWell(
                              onTap: (){
                                controller.showAlerte(annuaire.contact.toString());
                              },
                              child: Row(
                                children: [
                                  Flexible(
                                      child: Image.asset(ICON_TELEPHONE, width: 20, height: 20,),
                                  ),
                                  SizedBox(width: 3,),
                                  Flexible(
                                      child: Text(annuaire.contact.toString(),
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.blue
                                        ),
                                      )
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              )
          ),
        );
  }
}
