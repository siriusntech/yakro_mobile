import 'dart:convert';

// RECUPERE STRING ET CONVERTIR EN JSON ET RENVOYER UNE LISTE D'OBJET ANNUAIRE
// List<Entreprise> entrepriseFromJson(String str) => List<Entreprise>.from(json.decode(str)['data'].map((x) => Entreprise.fromJson(x)));
List<Entreprise> entrepriseFromJson(String str) => List<Entreprise>.from(json.decode(str).map((x) => Entreprise.fromJson(x)));
// RETOURNE UN OBJET ANNUAIRE
String entrepriseToJson(List<Entreprise> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Entreprise{
   int? id;
   String? nom;
   String? adresse;
   String? presentation;
   String? slogan;
   String? logo;
   String? contact;
   String? email;

   Entreprise({this.id, this.nom, this.adresse, this.presentation, this.slogan, this.logo, this.contact, this.email});

   factory Entreprise.fromJson(Map<dynamic, dynamic> json) => Entreprise(
       id: json["id"] ?? null,
       nom: json["nom"] ?? null,
       adresse: json["adresse"] ?? null,
       presentation: json["presentation"] ?? null,
       slogan: json["slogan"] ?? null,
       logo: json["logo"] ?? null,
       contact: json["contact"] ?? null,
       email: json["email"] ?? null,
   );

   Map<String, dynamic> toJson() => {
      "id": id,
      "nom": nom,
      "adresse": adresse,
      "presentation": presentation,
      "slogan": slogan,
      "logo": logo,
      "contact": contact,
      "email": email,
   };
}