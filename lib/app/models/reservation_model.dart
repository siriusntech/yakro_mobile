import 'dart:convert';

import 'package:jaime_cocody/app/models/trajet_model.dart';

import '../modules/auth/user_model.dart';

// RECUPERE STRING ET CONVERTIR EN JSON ET RENVOYER UNE LISTE D'OBJET RESERVATION
List<ReservationModel> reservationFromJson(String str) => List<ReservationModel>.from(json.decode(str)['data'].map((x) => ReservationModel.fromJson(x)));
// RETOURNE UN OBJET RESERVATION
String reservationToJson(List<ReservationModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ReservationModel{
   int? id;
   int? nombre_place;
   User? user;
   TrajetModel? trajet;
   String? date;

   ReservationModel({this.id, this.user, this.date, this.trajet, this.nombre_place});

   ReservationModel.fromJson(Map<String, dynamic> json) {
       id = json["id"] ?? null;
       nombre_place = json["nombre_place"] ?? null;
       user = json["user"] ?? null;
       trajet = json["trajet"] ?? null;
       date = json["date"] ?? null;
   }

   Map<String, dynamic> toJson() {
     final data = <String, dynamic>{};
     data['id'] = id;
     data['nombre_place'] = nombre_place;
     data['user'] = user;
     data['trajet'] = trajet;
     data['date'] = date;
     return data;
   }
}
