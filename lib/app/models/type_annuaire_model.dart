import 'dart:convert';

// RECUPERE STRING ET CONVERTIR EN JSON ET RENVOYER UNE LISTE D'OBJET Type Annuaire
List<TypeAnnuaireModel> typeAnnuaireFromJson(String str) => List<TypeAnnuaireModel>.from(json.decode(str)['data'].map((x) => TypeAnnuaireModel.fromJson(x)));
// RETOURNE UN OBJET Type Annuaire
String typeAnnuaireToJson(List<TypeAnnuaireModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class TypeAnnuaireModel{
   int? id;
   String? nom;

   TypeAnnuaireModel({this.id, this.nom});

   TypeAnnuaireModel.fromJson(Map<String, dynamic> json) {
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
