// To parse this JSON data, do
//
//     final bonPlanModel = bonPlanModelFromJson(jsonString);

import 'dart:convert';

import 'package:jaime_yakro/Providers/path_providers.dart';

BonPlanModel bonPlanModelFromJson(String str) =>
    BonPlanModel.fromJson(json.decode(str));

String bonPlanModelToJson(BonPlanModel data) => json.encode(data.toJson());

class BonPlanModel {
  int? id;
  String? objet;
  String? message;
  String? date;
  String? imageUrl;
  List<MediaModel>? medias;

  BonPlanModel({
    this.id,
    this.objet,
    this.message,
    this.date,
    this.imageUrl,
    this.medias,
  });

  factory BonPlanModel.fromJson(Map<String, dynamic> json) => BonPlanModel(
        id: json["id"],
        objet: json["objet"],
        message: json["message"],
        date: json["date"],
        imageUrl: json["imageUrl"],
        medias: List<MediaModel>.from(
            json["medias"].map((x) => MediaModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "objet": objet,
        "message": message,
        "date": date,
        "imageUrl": imageUrl,
        "medias": List<dynamic>.from(medias!.map((x) => x.toJson())),
      };
}
