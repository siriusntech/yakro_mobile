// To parse this JSON data, do
//
//     final moduleModel = moduleModelFromJson(jsonString);

import 'dart:convert';

List<ModuleModel> moduleModelFromJson(String str) => List<ModuleModel>.from(
    json.decode(str).map((x) => ModuleModel.fromJson(x)));

String moduleModelToJson(List<ModuleModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ModuleModel {
  int? id;
  int? hotel;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? tourisme;
  int? conciergerie;
  int? restaurantBar;
  int? bonPlans;
  int? pharmacie;
  int? boutique;
  int? hotelReduction;

  ModuleModel(
      {this.id,
      this.hotel,
      this.createdAt,
      this.updatedAt,
      this.tourisme,
      this.conciergerie,
      this.restaurantBar,
      this.bonPlans,
      this.pharmacie,
      this.boutique,
      this.hotelReduction});

  factory ModuleModel.fromJson(Map<String, dynamic> json) => ModuleModel(
        id: json["id"],
        hotel: json["Hotel"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        tourisme: json["Tourisme"],
        conciergerie: json["Conciergerie"],
        restaurantBar: json["Restaurant/Bar"],
        bonPlans: json["Bon Plans"],
        pharmacie: json["Pharmacie"],
        boutique: json["Boutique"],
        hotelReduction: json["Hotel_Reduction"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "Hotel": hotel,
        "created_at": createdAt!.toIso8601String(),
        "updated_at": updatedAt!.toIso8601String(),
        "Tourisme": tourisme,
        "Conciergerie": conciergerie,
        "Restaurant/Bar": restaurantBar,
        "Bon Plans": bonPlans,
        "Pharmacie": pharmacie,
        "Boutique": boutique,
        "Hotel_Reduction": hotelReduction
      };
}
