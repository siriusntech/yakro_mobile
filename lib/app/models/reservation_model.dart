import 'dart:convert';

import 'package:jaime_cocody/app/models/trajet_model.dart';

import '../modules/auth/user_model.dart';

// RECUPERE STRING ET CONVERTIR EN JSON ET RENVOYER UNE LISTE D'OBJET RESERVATION
List<ReservationModel> reservationFromJson(String str) => List<ReservationModel>.from(json.decode(str)['data'].map((x) => ReservationModel.fromJson(x)));
// RETOURNE UN OBJET RESERVATION
String reservationToJson(List<ReservationModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ReservationModel{
   int? id;
   User? user;
   TrajetModel? trajet;

   ReservationModel({this.id, this.user, this.trajet});

   ReservationModel.fromJson(Map<String, dynamic> json) {
       id = json["id"] ?? null;
       user = json["user"] ?? null;
       trajet = json["trajet"] ?? null;
   }

   Map<String, dynamic> toJson() {
     final data = <String, dynamic>{};
     data['id'] = id;
     data['user'] = user;
     data['trajet'] = trajet;
     return data;
   }
}
