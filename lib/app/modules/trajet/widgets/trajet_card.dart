
import 'package:jaime_cocody/app/widgets/text_widget.dart';

import '../../../Utils/app_icons.dart';
import '../../../models/trajet_model.dart';
import '../controllers/trajet_controller.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TrajetCardWidget extends StatelessWidget {
  final TrajetModel trajet;
  final VoidCallback? actionReservation;
  final VoidCallback? actionDetail;

  TrajetCardWidget({required this.trajet, this.actionReservation, this.actionDetail});

  final controller = Get.find<TrajetController>();

  String returnStatut(int? statut){
    if(statut != null && statut == 1){
      return 'Fermé';
    }
    else if(statut != null && statut==2){
      return 'Annulé';
    }else{
      return 'Ouvert';
    }
  }
  Color returnStatutColor(int? statut){
    if(statut != null && statut == 1){
      return Colors.blue;
    }
    else if(statut != null && statut==2){
      return Colors.red;
    }else{
      return Colors.green;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      child: Padding(
        padding: EdgeInsets.all(5),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextWidget(
                  text: returnStatut(trajet.statut),
                  fontWeight: FontWeight.bold,
                  color: returnStatutColor(trajet.statut),
                )
              ],
            ),
            SizedBox(height: 8,),
            Row(
              children: [
                // Image.asset(AppIcons.depart,
                //   width: 20,
                //   height: 20,
                // ),
                SizedBox(width: 3,),
                TextWidget(text: "Date de publication: ", fontWeight: FontWeight.bold, color: Colors.grey[800],),
                TextWidget(text: trajet.date, fontWeight: FontWeight.bold, color: Colors.grey[800],)
              ],
            ),
            SizedBox(height: 5,),
            Row(
              children: [
                Image.asset(AppIcons.depart,
                  width: 20,
                  height: 20,
                ),
                TextWidget(text: trajet.depart, fontWeight: FontWeight.bold, color: Colors.grey[700],)
              ],
            ),
            SizedBox(height: 5,),
            Row(
              children: [
                Image.asset(AppIcons.arriver,
                  width: 20,
                  height: 20,
                ),
                TextWidget(text: trajet.destination, fontWeight: FontWeight.bold, color: Colors.grey[700],)
              ],
            ),
            SizedBox(height: 5,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Image.asset(AppIcons.arriver,
                //   width: 20,
                //   height: 20,
                // ),
                Row(
                  children: [
                    Icon(Icons.date_range_rounded),
                    TextWidget(text: trajet.date_depart, fontWeight: FontWeight.bold, color: Colors.grey[700],)
                  ],
                ),
                Row(
                  children: [
                    Icon(Icons.time_to_leave_outlined),
                    TextWidget(text: trajet.heure_depart, fontWeight: FontWeight.bold, color: Colors.grey[700],)
                  ],
                )
              ],
            ),
            SizedBox(height: 5,),
            Row(
              children: [
                // Image.asset(AppIcons.arriver,
                //   width: 20,
                //   height: 20,
                // ),
                SizedBox(width: 3,),
                TextWidget(text: "Nombre de places: ".toUpperCase(), fontWeight: FontWeight.bold, color: Colors.grey[700],),
                TextWidget(text: trajet.nombre_place.toString(), fontWeight: FontWeight.bold, color: Colors.red)
              ],
            ),
            SizedBox(height: 5,),
            Row(
              children: [
                // Image.asset(AppIcons.arriver,
                //   width: 20,
                //   height: 20,
                // ),
                SizedBox(width: 3,),
                TextWidget(text: "Places disponibles: ".toUpperCase(), fontWeight: FontWeight.bold, color: Colors.grey[700],),
                TextWidget(text: controller.setPlaceDisponible(trajet).toString(), fontWeight: FontWeight.bold, color: Colors.red)
              ],
            ),
            SizedBox(height: 5,),
            Row(
              children: [
                // Image.asset(AppIcons.arriver,
                //   width: 20,
                //   height: 20,
                // ),
                SizedBox(width: 3,),
                TextWidget(text: "Coût du transport : ".toUpperCase(), fontWeight: FontWeight.bold, color: Colors.grey[700],),
                TextWidget(text: trajet.prix_place.toString()+' FCFA', fontWeight: FontWeight.bold, color: Colors.red)
              ],
            ),
            Row(
              children: [
                // Image.asset(AppIcons.arriver,
                //   width: 20,
                //   height: 20,
                // ),
                SizedBox(width: 3,),
                OutlinedButton(
                  onPressed: (){},
                  child: TextWidget(text: "Faire une reservation", fontSize: 15, fontWeight: FontWeight.bold, color: Colors.green),
                  style: ButtonStyle(
                      side: MaterialStateProperty.all(BorderSide(width: 2, color: Colors.green))
                  ),
                ),
                SizedBox(width: 18,),
                OutlinedButton(
                  onPressed: (){},
                  child: TextWidget(text: "Plus de détails", fontSize: 15, fontWeight: FontWeight.bold, color: Colors.red),
                  style: ButtonStyle(
                      side: MaterialStateProperty.all(BorderSide(width: 2, color: Colors.red))
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}