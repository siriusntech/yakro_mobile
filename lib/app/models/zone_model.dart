import 'dart:convert';

// RECUPERE STRING ET CONVERTIR EN JSON ET RENVOYER UNE LISTE D'OBJET ZONE
List<ZoneModel> zoneFromJson(String str) => List<ZoneModel>.from(json.decode(str)['data'].map((x) => ZoneModel.fromJson(x)));
// RETOURNE UN OBJET ZONE
String zoneToJson(List<ZoneModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ZoneModel{
   int? id;
   String? nom;

   ZoneModel({this.id, this.nom});

   ZoneModel.fromJson(Map<String, dynamic> json) {
       id = json["id"] ?? null;
       nom = json["nom"] ?? null;
   }

   Map<String, dynamic> toJson() {
     final data = <String, dynamic>{};
     data['id'] = id;
     data['nom'] = nom;
     return data;
   }
}
