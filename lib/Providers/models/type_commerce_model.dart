import 'dart:convert';

class TypeCommerceModel {
  final int? id;
  final String? nomType;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  TypeCommerceModel({
    this.id,
    this.nomType,
    this.createdAt,
    this.updatedAt,
  });

  factory TypeCommerceModel.fromRawJson(String str) =>
      TypeCommerceModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory TypeCommerceModel.fromJson(Map<String, dynamic> json) {
    return TypeCommerceModel(
      id: json['id'],
      nomType: json['nom_type'],
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : null,
      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'])
          : null,
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "nom_type": nomType,
        "created_at": createdAt!.toIso8601String(),
        "updated_at": updatedAt!.toIso8601String(),
      };
}

List<TypeCommerceModel> typeCommerceModelFromJson(String str) =>
    List<TypeCommerceModel>.from(
        json.decode(str).map((x) => TypeCommerceModel.fromJson(x)));
