// To parse this JSON data, do
//
//     final typeHotelByHotels = typeHotelByHotelsFromJson(jsonString);

import 'dart:convert';

TypeHotelByHotels typeHotelByHotelsFromJson(String str) => TypeHotelByHotels.fromJson(json.decode(str));

String typeHotelByHotelsToJson(TypeHotelByHotels data) => json.encode(data.toJson());

class TypeHotelByHotels {
    int? id;
    String? lieu;
    dynamic description;
    dynamic deletedAt;
    DateTime? createdAt;
    DateTime? updatedAt;

    TypeHotelByHotels({
        this.id,
        this.lieu,
        this.description,
        this.deletedAt,
        this.createdAt,
        this.updatedAt,
    });

    factory TypeHotelByHotels.fromJson(Map<String, dynamic> json) => TypeHotelByHotels(
        id: json["id"],
        lieu: json["lieu"],
        description: json["description"],
        deletedAt: json["deleted_at"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "lieu": lieu,
        "description": description,
        "deleted_at": deletedAt,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
    };
}
