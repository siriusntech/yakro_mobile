import 'package:flutter/material.dart';
import 'package:jaime_cocody/app/Utils/app_colors.dart';
import 'package:jaime_cocody/app/models/site_touristique.dart';
import 'package:jaime_cocody/app/modules/sitetouristiques/controllers/sitetouristiques_controller.dart';

import '../../../Utils/app_constantes.dart';
import '../../../data/repository/data/Env.dart';

import 'package:get/get.dart';



class SiteTouristiqueCardWidget extends StatelessWidget {
  final DataVisiteTouristiqueModel visiteTouristique;
  final VoidCallback? action;

  SiteTouristiqueCardWidget({required this.visiteTouristique, this.action});

  final controller = Get.find<SitetouristiquesController>();

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
                          backgroundColor: AppColors.vert_color_fonce,
                          radius: 50,
                          backgroundImage: visiteTouristique.imageUrl.toString().contains('picsum') ?
                          NetworkImage(visiteTouristique.imageUrl.toString()) : NetworkImage(siteUrl+visiteTouristique.imageUrl.toString()
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
                                    child: Text(visiteTouristique.nomVt.toString().toUpperCase()+" "+visiteTouristique.typeQuartierVtLieu.toString().toUpperCase(),
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
                                    child: Text(visiteTouristique.prix!,
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
                                controller.showAlerte(visiteTouristique.numeroVisitesTouristique.toString());
                              },
                              child: Row(
                                children: [
                                  Flexible(
                                      child: Image.asset(ICON_TELEPHONE, width: 20, height: 20,),
                                  ),
                                  SizedBox(width: 3,),
                                  Flexible(
                                      child: Text(visiteTouristique.numeroVisitesTouristique.toString(), //mettre le deuxieme numero
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
