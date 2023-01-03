
import 'dart:convert';

List<AgendaType> agendaTypeFromJson(String str) => List<AgendaType>.from(json.decode(str)['data'].map((x) => AgendaType.fromJson(x)));
// RETOURNE UN OBJET COMMERCE
String agendaTypeToJson(List<AgendaType> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AgendaType {
  int? id;
  String? nom;

  AgendaType({this.id, this.nom});

  AgendaType.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nom = json['nom'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['nom'] = nom;
    return data;
  }
}
