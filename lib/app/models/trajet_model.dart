import 'dart:convert';

import 'package:jaime_yakro/app/models/conversation_model.dart';
import 'package:jaime_yakro/app/models/reservation_model.dart';

import '../modules/auth/user_model.dart';

// RECUPERE STRING ET CONVERTIR EN JSON ET RENVOYER UNE LISTE D'OBJET TRAJET
List<TrajetModel> trajetFromJson(String str) => List<TrajetModel>.from(json.decode(str)['data'].map((x) => TrajetModel.fromJson(x)));
// RETOURNE UN OBJET TRAJET
String trajetToJson(List<TrajetModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class TrajetModel{
   int? id;
   String? depart;
   String? destination;
   String? date_depart;
   String? heure_depart;
   String? point_rassemblement;
   String? date;
   int? nombre_place;
   int? place_reserver;
   int? prix_place;
   int? statut;
   int? is_reserved;
   User? user;
   List<ConversationModel>? conversations;
   List<ReservationModel>? reservations;

   TrajetModel({
     this.id,
     this.depart,
     this.destination,
     this.date_depart,
     this.heure_depart,
     this.point_rassemblement,
     this.nombre_place,
     this.place_reserver,
     this.prix_place,
     this.statut,
     this.is_reserved,
     this.user,
     this.reservations,
     this.conversations,
     this.date,
   });

   TrajetModel.fromJson(Map<String, dynamic> json) {
       id = json["id"] ?? null;
       depart = json["depart"] ?? null;
       destination = json["destination"] ?? null;
       date_depart = json["date_depart"] ?? null;
       heure_depart = json["heure_depart"] ?? null;
       point_rassemblement = json["point_rassemblement"] ?? null;
       nombre_place = json["nombre_place"] ?? null;
       place_reserver = json["place_reserver"] ?? null;
       prix_place = json["prix_place"] ?? null;
       statut = json["statut"] ?? null;
       is_reserved = json["is_reserved"] ?? null;
       user = json["user"] ?? null;
       date = json["date"] ?? null;
       if (json['reservations'] != null) {
         reservations = <ReservationModel>[];
         json['reservations'].forEach((v) {
           reservations?.add(ReservationModel.fromJson(v));
         });
       }
       if (json['conversations'] != null) {
         conversations = <ConversationModel>[];
         json['conversations'].forEach((v) {
           conversations?.add(ConversationModel.fromJson(v));
         });
       }
   }

   Map<String, dynamic> toJson() {
     final data = <String, dynamic>{};
     data['id'] = id;
     data['depart'] = depart;
     data['destination'] = destination;
     data['date_depart'] = date_depart;
     data['heure_depart'] = heure_depart;
     data['point_rassemblement'] = point_rassemblement;
     data['nombre_place'] = nombre_place;
     data['place_reserver'] = place_reserver;
     data['prix_place'] = prix_place;
     data['statut'] = statut;
     data['user'] = user;
     data['is_reserved'] = is_reserved;
     data['date'] = date;
     if (reservations != null) {
       data['reservations'] = reservations?.map((v) => v.toJson()).toList();
     }
     if (conversations != null) {
       data['conversations'] = conversations?.map((v) => v.toJson()).toList();
     }
     return data;
   }
}
