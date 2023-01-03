
import 'dart:convert';

List<ActualiteType> actualiteTypeFromJson(String str) => List<ActualiteType>.from(json.decode(str)['data'].map((x) => ActualiteType.fromJson(x)));
// RETOURNE UN OBJET COMMERCE
String actualiteTypeToJson(List<ActualiteType> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ActualiteType {
  int? id;
  String? nom;

  ActualiteType({this.id, this.nom});

  ActualiteType.fromJson(Map<String, dynamic> json) {
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
