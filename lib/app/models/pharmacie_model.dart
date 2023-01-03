import 'dart:convert';

// RECUPERE STRING ET CONVERTIR EN JSON ET RENVOYER UNE LISTE D'OBJET PHARMACIE
List<Pharmacie> pharmacieFromJson(String str) => List<Pharmacie>.from(json.decode(str)['data'].map((x) => Pharmacie.fromJson(x)));
// RETOURNE UN OBJET PHARMACIE
String pharmacieToJson(List<Pharmacie> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Pharmacie{
   int? id;
   String? nom;
   String? medecin;
   String? adresse;
   List<Contact>? contacts;
   String? periode;
   String? localisation;
   String? photo;

   Pharmacie({this.id, this.nom, this.medecin, this.adresse, this.contacts, this.localisation, this.periode, this.photo});

   Pharmacie.fromJson(Map<String, dynamic> json) {
       id = json["id"] ?? null;
       nom = json["nom"] ?? null;
       medecin = json["medecin"] ?? null;
       adresse = json["adresse"] ?? null;
       periode = json["periode"] ?? null;
       photo = json["photo"] ?? null;
       localisation = json["localisation"] ?? null;
       if (json['contacts'] != null) {
         contacts = <Contact>[];
         json['contacts'].forEach((v) {
         contacts?.add(Contact.fromJson(v));
         });
       }
   }

   Map<String, dynamic> toJson() {
     final data = <String, dynamic>{};
     data['id'] = id;
     data['nom'] = nom;
     data['medecin'] = medecin;
     data['adresse'] = adresse;
     data['photo'] = photo;
     data['localisation'] = localisation;
     data['periode'] = periode;
     if (contacts != null) {
       data['contacts'] = contacts?.map((v) => v.toJson()).toList();
     }
     return data;
   }
}

class Contact{
  String? numero;

  Contact({this.numero});

  factory Contact.fromJson(Map<String, dynamic> json) => Contact(
    numero: json["numero"] ?? null,
  );

  Map<String, dynamic> toJson() => {
    "numero": numero,
  };
}