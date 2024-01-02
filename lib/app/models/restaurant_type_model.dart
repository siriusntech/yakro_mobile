import 'dart:convert';

List<RestaurantType> restaurantTypeFromJson(String str) => List<RestaurantType>.from(json.decode(str)['data'].map((x) => RestaurantType.fromJson(x)));
// RETOURNE UN OBJET COMMERCE
String restaurantTypeToJson(List<RestaurantType> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class RestaurantType {
  int? id;
  String? nom;

  RestaurantType({this.id, this.nom});

  RestaurantType.fromJson(Map<String, dynamic> json) {
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
