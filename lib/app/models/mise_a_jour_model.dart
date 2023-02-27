import 'dart:convert';

// RECUPERE STRING ET CONVERTIR EN JSON ET RENVOYER UNE LISTE D'OBJET PHARMACIE
List<MiseAJourModel> MiseAJourModelFromJson(String str) => List<MiseAJourModel>.from(json.decode(str)['data'].map((x) => MiseAJourModel.fromJson(x)));
// RETOURNE UN OBJET PHARMACIE
String MiseAJourModelToJson(List<MiseAJourModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class MiseAJourModel{
   int? id;
   String? titre;
   String? description;
   int? etat;

   MiseAJourModel({this.id, this.titre, this.description, this.etat});

   MiseAJourModel.fromJson(Map<String, dynamic> json) {
       id = json["id"] ?? null;
       titre = json["titre"] ?? null;
       description = json["description"] ?? null;
       etat = json["etat"] ?? null;
   }

   Map<String, dynamic> toJson() {
     final data = <String, dynamic>{};
     data['id'] = id;
     data['titre'] = titre;
     data['description'] = description;
     data['etat'] = etat;
     return data;
   }
}
