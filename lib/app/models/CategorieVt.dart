class CategorieVT {
  int? id;
  String? nomCategorie;
  String? description;
  List<TypeByVT>? typeByVT;

  CategorieVT(
      {this.id,
      this.nomCategorie,
      this.description,

      this.typeByVT});

  CategorieVT.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nomCategorie = json['nom_categorie'];
    description = json['description'];
    if (json['type_by_v_t'] != null) {
      typeByVT = <TypeByVT>[];
      json['type_by_v_t'].forEach((v) {
        typeByVT!.add(new TypeByVT.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['nom_categorie'] = this.nomCategorie;
    data['description'] = this.description;
    if (this.typeByVT != null) {
      data['type_by_v_t'] = this.typeByVT!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class TypeByVT {
  int? id;
  String? nomVt;
  int? prix;
  String? description;
  String? numeroVisitesTouristique;
  String? contact;
  String? lienMap;
  String? siteInternet;
  String? adresseEmail;
  String? facebook;
  String? linkedIn;
  String? youtube;
  String? instagram;
  int? typeCategorieVtId;
  int? typeQuartierVtId;
  int? userId;

  String? createdAt;
  String? updatedAt;

  TypeByVT(
      {this.id,
      this.nomVt,
      this.prix,
      this.description,
      this.numeroVisitesTouristique,
      this.contact,
      this.lienMap,
      this.siteInternet,
      this.adresseEmail,
      this.facebook,
      this.linkedIn,
      this.youtube,
      this.instagram,
      this.typeCategorieVtId,
      this.typeQuartierVtId,
      this.userId,

      this.createdAt,
      this.updatedAt});

  TypeByVT.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nomVt = json['nom_vt'];
    prix = json['prix'];
    description = json['description'];
    numeroVisitesTouristique = json['numero_visitesTouristique'];
    contact = json['contact'];
    lienMap = json['lien_map'];
    siteInternet = json['site_internet'];
    adresseEmail = json['adresse_email'];
    facebook = json['facebook'];
    linkedIn = json['linkedIn'];
    youtube = json['youtube'];
    instagram = json['instagram'];
    typeCategorieVtId = json['type_categorie_vt_id'];
    typeQuartierVtId = json['type_quartier_vt_id'];
    userId = json['user_id'];

    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['nom_vt'] = this.nomVt;
    data['prix'] = this.prix;
    data['description'] = this.description;
    data['numero_visitesTouristique'] = this.numeroVisitesTouristique;
    data['contact'] = this.contact;
    data['lien_map'] = this.lienMap;
    data['site_internet'] = this.siteInternet;
    data['adresse_email'] = this.adresseEmail;
    data['facebook'] = this.facebook;
    data['linkedIn'] = this.linkedIn;
    data['youtube'] = this.youtube;
    data['instagram'] = this.instagram;
    data['type_categorie_vt_id'] = this.typeCategorieVtId;
    data['type_quartier_vt_id'] = this.typeQuartierVtId;
    data['user_id'] = this.userId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}