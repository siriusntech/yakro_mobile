import 'dart:convert';

class SpecialiteCommerceModel {
  final int? id;
  final String? libelle;
  final String? slug;
  final DateTime createdAt;
  final DateTime? updatedAt;

  SpecialiteCommerceModel({
    this.id,
    this.libelle,
    this.slug,
    required this.createdAt,
    this.updatedAt,
  });

  factory SpecialiteCommerceModel.fromRawJson(String str) =>
      SpecialiteCommerceModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SpecialiteCommerceModel.fromJson(Map<String, dynamic> json) =>
      SpecialiteCommerceModel(
        id: json["id"],
        libelle: json["libelle"],
        slug: json["slug"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "libelle": libelle,
        "slug": slug,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
