
import 'dart:convert';

List<CommerceType> commerceTypeFromJson(String str) => List<CommerceType>.from(json.decode(str)['data'].map((x) => CommerceType.fromJson(x)));
// RETOURNE UN OBJET COMMERCE
String commerceTypeToJson(List<CommerceType> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CommerceType {
  int? id;
  String? nom_type;

  CommerceType({this.id, this.nom_type});

  CommerceType.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nom_type = json['nom_type'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['nom_type'] = nom_type;
    return data;
  }
}
