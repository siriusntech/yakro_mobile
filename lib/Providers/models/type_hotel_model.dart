import 'dart:convert';

class TypeHotelModel {
  final int? id;
  final String? libelle;
  final String? description;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  TypeHotelModel({
    this.id,
    this.libelle,
    this.description,
    this.createdAt,
    this.updatedAt,
  });

  factory TypeHotelModel.fromRawJson(String str) =>
      TypeHotelModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory TypeHotelModel.fromJson(Map<String, dynamic> json) => TypeHotelModel(
        id: json["id"],
        libelle: json["libelle"],
        description: json["description"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "libelle": libelle,
        "description": description,
        "created_at": createdAt!.toIso8601String(),
        "updated_at": updatedAt!.toIso8601String(),
      };

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TypeHotelModel &&
          runtimeType == other.runtimeType &&
          id == other.id; // Compare by unique identifier

  @override
  int get hashCode => id.hashCode; // Use id for hash code
}
