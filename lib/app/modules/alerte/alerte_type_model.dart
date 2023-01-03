
import 'dart:convert';

List<AlerteType> alerteTypeFromJson(String str) => List<AlerteType>.from(json.decode(str)['data'].map((x) => AlerteType.fromJson(x)));
// RETOURNE UN OBJET ALERTE
String alerteTypeToJson(List<AlerteType> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AlerteType {
  int? id;
  String? nom;
  String? texte;
  String? description;

  AlerteType({this.id, this.nom, this.texte, this.description});

  AlerteType.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nom = json['nom'];
    texte = json['texte'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['nom'] = nom;
    data['texte'] = texte;
    data['description'] = description;
    return data;
  }
}
