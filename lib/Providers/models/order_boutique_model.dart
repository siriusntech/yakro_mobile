import 'dart:convert';

import 'package:jaime_yakro/Providers/path_providers.dart';

class OrderBoutiqueModel {
  final String? id;
  final String? userBoutiqueId;
  final String? subTotal;
  final String? shippingId;
  final String? totalAmount;
  final String? quantity;
  final String? typeLivraison;
  final String? orderNumber;
  final String? deviceId;
  final String? deviceModel;
  final int? nbrJourAvLivraison;
  final String? jourLivraison;
  final DateTime? updatedAt;
  final DateTime? createdAt;
  final List<CartBoutique>? cartBoutiques;
  final ShippingBoutiqueModel? shippingBoutiqueModel;

  OrderBoutiqueModel(
      {this.id,
      this.userBoutiqueId,
      this.subTotal,
      this.shippingId,
      this.totalAmount,
      this.quantity,
      this.typeLivraison,
      this.orderNumber,
      this.deviceId,
      this.deviceModel,
      this.nbrJourAvLivraison,
      this.jourLivraison,
      this.updatedAt,
      this.createdAt,
      this.cartBoutiques,
      this.shippingBoutiqueModel});

  factory OrderBoutiqueModel.fromRawJson(String str) =>
      OrderBoutiqueModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory OrderBoutiqueModel.fromJson(Map<String, dynamic> json) =>
      OrderBoutiqueModel(
        id: json["id"],
        userBoutiqueId: json["user_boutique_id"].toString(),
        subTotal: json["sub_total"],
        shippingId: json["shipping_id"].toString(),
        totalAmount: json["total_amount"].toString(),
        quantity: json["quantity"].toString(),
        typeLivraison: json["type_livraison"],
        orderNumber: json["order_number"],
        deviceId: json["device_id"],
        deviceModel: json["device_model"],
        nbrJourAvLivraison: json['nbr_jour_av_livr'],
        jourLivraison: json['jour_livraison'],
        updatedAt: DateTime.parse(json["updated_at"]),
        createdAt: DateTime.parse(json["created_at"]),
        cartBoutiques: json["cartBoutiques"] == null
            ? null
            : List<CartBoutique>.from(
                json["cartBoutiques"].map((x) => CartBoutique.fromJson(x))),
        shippingBoutiqueModel: json["shippingBoutique"] == null
            ? null
            : ShippingBoutiqueModel.fromJson(json["shippingBoutique"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_boutique_id": userBoutiqueId,
        "sub_total": subTotal,
        "shipping_id": shippingId,
        "total_amount": totalAmount,
        "quantity": quantity,
        "type_livraison": typeLivraison,
        "order_number": orderNumber,
        "device_id": deviceId,
        "device_model": deviceModel,
        "updated_at": updatedAt!.toIso8601String(),
        "created_at": createdAt!.toIso8601String(),
      };
}

class CartBoutique {
  final String? id;
  final int? productBoutiqueId;
  final String? orderBoutiqueNumber;
  final int? price;
  final String? status;
  final int? quantity;
  final int? amount;
  final String? deviceId;
  final String? deviceModel;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final List<ProduitBoutique>? produitBoutiques;

  CartBoutique({
    this.id,
    this.productBoutiqueId,
    this.orderBoutiqueNumber,
    this.price,
    this.status,
    this.quantity,
    this.amount,
    this.deviceId,
    this.deviceModel,
    this.createdAt,
    this.updatedAt,
    this.produitBoutiques,
  });

  factory CartBoutique.fromRawJson(String str) =>
      CartBoutique.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CartBoutique.fromJson(Map<String, dynamic> json) => CartBoutique(
        id: json["id"],
        productBoutiqueId: json["product_boutique_id"],
        orderBoutiqueNumber: json["order_boutique_number"],
        price: json["price"],
        status: json["status"],
        quantity: json["quantity"],
        amount: json["amount"],
        deviceId: json["device_id"],
        deviceModel: json["device_model"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        produitBoutiques: List<ProduitBoutique>.from(
            json["produit_boutiques"].map((x) => ProduitBoutique.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "product_boutique_id": productBoutiqueId,
        "order_boutique_number": orderBoutiqueNumber,
        "price": price,
        "status": status,
        "quantity": quantity,
        "amount": amount,
        "device_id": deviceId,
        "device_model": deviceModel,
        "created_at": createdAt!.toIso8601String(),
        "updated_at": updatedAt!.toIso8601String(),
      };
}

class ProduitBoutique {
  final int? id;
  final int? categorieBoutiqueId;
  final String? libelle;
  final String? description;
  final String? prix;
  final int? quantite;
  final String? slug;
  final String? status;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final List<ProduitMedia>? produitMedias;

  ProduitBoutique({
    this.id,
    this.categorieBoutiqueId,
    this.libelle,
    this.description,
    this.prix,
    this.quantite,
    this.slug,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.produitMedias,
  });

  factory ProduitBoutique.fromRawJson(String str) =>
      ProduitBoutique.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ProduitBoutique.fromJson(Map<String, dynamic> json) =>
      ProduitBoutique(
        id: json["id"],
        categorieBoutiqueId: json["categorie_boutique_id"],
        libelle: json["libelle"],
        description: json["description"],
        prix: json["prix"],
        quantite: json["quantite"],
        slug: json["slug"],
        status: json["status"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        produitMedias: List<ProduitMedia>.from(
            json["produit_medias"].map((x) => ProduitMedia.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "categorie_boutique_id": categorieBoutiqueId,
        "libelle": libelle,
        "description": description,
        "prix": prix,
        "quantite": quantite,
        "slug": slug,
        "status": status,
        "created_at": createdAt!.toIso8601String(),
        "updated_at": updatedAt!.toIso8601String(),
        "produit_medias":
            List<dynamic>.from(produitMedias!.map((x) => x.toJson())),
      };
}

class ProduitMedia {
  final int? id;
  final String? src;
  final String? url;

  ProduitMedia({
    this.id,
    this.src,
    this.url,
  });

  factory ProduitMedia.fromRawJson(String str) =>
      ProduitMedia.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ProduitMedia.fromJson(Map<String, dynamic> json) => ProduitMedia(
        id: json["id"],
        src: json["src"],
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "src": src,
        "url": url,
      };
}
