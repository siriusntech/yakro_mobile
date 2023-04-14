import 'dart:convert';

import 'package:jaime_cocody/app/models/trajet_model.dart';

import '../modules/auth/user_model.dart';

// RECUPERE STRING ET CONVERTIR EN JSON ET RENVOYER UNE LISTE D'OBJET CONVERSATION
List<ConversationModel> conversationFromJson(String str) => List<ConversationModel>.from(json.decode(str)['data'].map((x) => ConversationModel.fromJson(x)));
// RETOURNE UN OBJET CONVERSATION
String conversationToJson(List<ConversationModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ConversationModel{
   int? id;
   String? message;
   TrajetModel? trajet;
   User? sender;
   User? receiver;
   int? is_read;

   ConversationModel({this.id, this.message, this.trajet, this.sender, this.receiver, this.is_read});

   ConversationModel.fromJson(Map<String, dynamic> json) {
       id = json["id"] ?? null;
       message = json["message"] ?? null;
       trajet = json["trajet"] ?? null;
       sender = json["sender"] ?? null;
       receiver = json["receiver"] ?? null;
       is_read = json["is_read"] ?? null;
   }

   Map<String, dynamic> toJson() {
     final data = <String, dynamic>{};
     data['id'] = id;
     data['message'] = message;
     data['trajet'] = trajet;
     data['sender'] = sender;
     data['receiver'] = receiver;
     data['is_read'] = is_read;
     return data;
   }
}
