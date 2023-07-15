import 'dart:convert';

// RECUPERE STRING ET CONVERTIR EN JSON ET RENVOYER UNE LISTE D'OBJET ANNUAIRE
List<Annuaire> annuaireFromJson(String str) => List<Annuaire>.from(json.decode(str)['data'].map((x) => Annuaire.fromJson(x)));
// RETOURNE UN OBJET ANNUAIRE
String annuaireToJson(List<Annuaire> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Annuaire{
   int? id;
   String? nom;
   String? prenom;
   String? poste;
   String? contact;
   String? contact2;
   String? imageUrl;

   Annuaire({this.id, this.nom, this.prenom, this.poste, this.contact, this.imageUrl, this.contact2});

   factory Annuaire.fromJson(Map<dynamic, dynamic> json) => Annuaire(
       id: json["id"] ?? null,
       nom: json["nom"] ?? null,
       prenom: json["prenom"] ?? '',
       poste: json["poste"] ?? null,
       contact: json["contact"] ?? null,
       contact2: json["contact2"] ?? null,
       imageUrl: json["imageUrl"] ?? null,
   );

   Map<String, dynamic> toJson() => {
      "id": id,
      "nom": nom,
      "prenom": prenom,
      "poste": poste,
      "contact": contact,
      "contact2": contact2,
      "imageUrl": imageUrl,
   };
}