
import 'dart:convert';

List<MessageType> messageTypeFromJson(String str) => List<MessageType>.from(json.decode(str)['data'].map((x) => MessageType.fromJson(x)));
// RETOURNE UN OBJET ALERTE
String messageTypeToJson(List<MessageType> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class MessageType {
  int? id;
  String? nom;
  String? texte;
  String? description;

  MessageType({this.id, this.nom, this.texte, this.description});

  MessageType.fromJson(Map<String, dynamic> json) {
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
