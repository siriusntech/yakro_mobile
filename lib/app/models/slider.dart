// To parse this JSON data, do
//
//     final sliderModel = sliderModelFromJson(jsonString);

import 'dart:convert';

List<SliderModel> sliderModelFromJson(String str) => List<SliderModel>.from(json.decode(str).map((x) => SliderModel.fromJson(x)));

String sliderModelToJson(List<SliderModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SliderModel {
  int? id;
  String? titre;
  String? description;
  String? imageUrl;
  String? url;


  SliderModel({
    this.id,
    this.titre,
    this.description,
    this.imageUrl,
    this.url,

  });

  factory SliderModel.fromJson(Map<String, dynamic> json) => SliderModel(
    id: json["id"],
    titre: json["titre"],
    description: json["description"],
    imageUrl: json["image_url"],
    url: json["url"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "titre": titre,
    "description": description,
    "image_url": imageUrl,
    "url": url,
  };
}