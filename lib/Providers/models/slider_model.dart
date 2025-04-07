// To parse this JSON data, do
//
//     final sliderModel = sliderModelFromJson(jsonString);

import 'dart:convert';

import 'package:jaime_yakro/Config/app_config.dart';

SliderModel sliderModelFromJson(String str) =>
    SliderModel.fromJson(json.decode(str));

String sliderModelToJson(SliderModel data) => json.encode(data.toJson());

class SliderModel {
  int? id;
  String? titre;
  String? description;
  String? imageUrl;
  String? url;
  dynamic deletedAt;
  DateTime? createdAt;
  DateTime? updatedAt;

  SliderModel({
    this.id,
    this.titre,
    this.description,
    this.imageUrl,
    this.url,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
  });

  factory SliderModel.fromJson(Map<String, dynamic> json) => SliderModel(
        id: int.parse(json["id"].toString()),
        titre: json["titre"],
        description: json["description"],
        imageUrl:  json["image_url"],//'${AppConfig.baseUrl}/' +
        url: json["url"],
        deletedAt: json["deleted_at"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "titre": titre,
        "description": description,
        "image_url": imageUrl,
        "url": url,
        "deleted_at": deletedAt,
        "created_at": createdAt!.toIso8601String(),
        "updated_at": updatedAt!.toIso8601String(),
      };
}
