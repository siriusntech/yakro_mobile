import 'dart:convert';

import 'package:jaime_yakro/Providers/path_providers.dart';

class CommentaireModel {
  final int? id;
  final HotelModel? hotel;
  final String? userId;
  final dynamic commentaire;
  final int? isActive;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  CommentaireModel({
    this.id,
    this.hotel,
    this.userId,
    this.commentaire,
    this.isActive,
    this.createdAt,
    this.updatedAt,
  });

  factory CommentaireModel.fromRawJson(String str) =>
      CommentaireModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CommentaireModel.fromJson(Map<String, dynamic> json) =>
      CommentaireModel(
        id: json["id"],
        // hotel:
        //     json["hotel"] == null ? null : HotelModel.fromJson(json["hotel"]),
        userId: json["user_id"].toString(),
        commentaire: json["commentaire"],
        isActive: json["is_active"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "hotel": hotel!.toJson(),
        "user_id": userId,
        "commentaire": commentaire,
        "is_active": isActive,
        "created_at": createdAt!.toIso8601String(),
        "updated_at": updatedAt!.toIso8601String(),
      };
}
