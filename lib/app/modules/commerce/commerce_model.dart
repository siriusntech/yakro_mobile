

// RECUPERE STRING ET CONVERTIR EN JSON ET RENVOYER UNE LISTE D'OBJET COMMERCE
import 'dart:convert';

List<Commerce> commerceFromJson(String str) => List<Commerce>.from(json.decode(str)['data'].map((x) => Commerce.fromJson(x)));
// RETOURNE UN OBJET COMMERCE
String commerceToJson(List<Commerce> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Commerce {
  int? id;
  String? type;
  String? nom;
  String? responsable;
  String? description;
  String? contact;
  String? imageUrl;
  String? lien;

  Commerce(
      {this.id,
      this.type,
      this.nom,
      this.responsable,
      this.description,
      this.contact,
      this.imageUrl,
      this.lien});

  Commerce.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
    nom = json['nom'];
    responsable = json['responsable'];
    description = json['description'];
    contact = json['contact'];
    imageUrl = json['imageUrl'];
    lien = json['lien'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['type'] = type;
    data['nom'] = nom;
    data['responsable'] = responsable;
    data['description'] = description;
    data['contact'] = contact;
    data['imageUrl'] = imageUrl;
    data['lien'] = lien;
    return data;
  }
}
