import 'dart:convert';

class ShippingBoutiqueModel {
  final int? id;
  final String? type;
  final String? prix;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  ShippingBoutiqueModel({
    this.id,
    this.type,
    this.prix,
    this.createdAt,
    this.updatedAt,
  });

  factory ShippingBoutiqueModel.fromRawJson(String str) =>
      ShippingBoutiqueModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ShippingBoutiqueModel.fromJson(Map<String, dynamic> json) =>
      ShippingBoutiqueModel(
        id: json["id"],
        type: json["type"],
        prix: json["prix"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "type": type,
        "prix": prix,
        "created_at": createdAt!.toIso8601String(),
        "updated_at": updatedAt!.toIso8601String(),
      };
}
