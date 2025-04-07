import 'dart:convert';

import 'package:uuid/uuid.dart';
import 'package:jaime_yakro/Providers/path_providers.dart';

var uuid = const Uuid();

class CartBoutiqueModel {
  final String id;
  final ProduitBoutiqueModel produitBoutiqueModel;
  int quantite;
  double totalPrice;
  String? deviceId;
  String? deviceModel;
  String? orderNumber;
  CartBoutiqueModel(
      {required this.produitBoutiqueModel,
      required this.quantite,
      required this.totalPrice,
      required this.deviceId,
      required this.deviceModel,
      required this.orderNumber})
      : id = uuid.v4();

  factory CartBoutiqueModel.fromRawJson(String str) =>
      CartBoutiqueModel.fromJson(json.decode(str));
  String toRawJson() => json.encode(toJson());
  factory CartBoutiqueModel.fromJson(Map<String, dynamic> json) =>
      CartBoutiqueModel(
        produitBoutiqueModel:
            ProduitBoutiqueModel.fromJson(json["produit_boutique"]),
        quantite: json["quantite"],
        totalPrice: json["total_price"].toDouble(),
        deviceId: json["device_id"],
        deviceModel: json["device_model"],
        orderNumber: json["order_number"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "produit_boutique": produitBoutiqueModel.toJson(),
        "quantite": quantite,
        "total_price": totalPrice,
        "device_id": deviceId,
        "device_model": deviceModel,
        "order_number": orderNumber
      };
}
