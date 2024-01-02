
// To parse this JSON data, do
//
//     final visiteTouristique = visiteTouristiqueFromJson(jsonString);

import 'dart:convert';

VisiteTouristique visiteTouristiqueFromJson(String str) => VisiteTouristique.fromJson(json.decode(str));

String visiteTouristiqueToJson(VisiteTouristique data) => json.encode(data.toJson());

class VisiteTouristique {
    bool? success;
    List<DataVisiteTouristiqueModel> data;
    dynamic message;

    VisiteTouristique({
        this.success,
        required this.data,
        this.message,
    });

    factory VisiteTouristique.fromJson(Map<String, dynamic> json) => VisiteTouristique(
        success: json["success"],
        data: List<DataVisiteTouristiqueModel>.from(json["data"].map((x) => DataVisiteTouristiqueModel.fromJson(x))),
        message: json["message"],
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "message": message,
    };
}

DataVisiteTouristiqueModel dataVisiteTouristiqueModelFromJson(String str) => DataVisiteTouristiqueModel.fromJson(json.decode(str));

String dataVisiteTouristiqueModelToJson(DataVisiteTouristiqueModel data) => json.encode(data.toJson());

class DataVisiteTouristiqueModel {
    int? id;
    String? nomVt;
    int? prix;
    String? description;
    String? numeroVisitesTouristique;
    dynamic contact;
    String? lienMap;
    String? siteInternet;
    dynamic adresseEmail;
    dynamic facebook;
    dynamic linkedIn;
    dynamic youtube;
    dynamic instagram;
    int? typeQuartierVtId;
    int? typeCategorieVtId;
    int? userId;
    TypeCategorieVt? typeCategorieVt;
    List<VtMedia> vtMedias;

    DataVisiteTouristiqueModel({
         this.id,
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
         this.typeQuartierVtId,
         this.typeCategorieVtId,
         this.userId,
        this.typeCategorieVt,
          required this.vtMedias,
    });

    factory DataVisiteTouristiqueModel.fromJson(Map<String, dynamic> json) => DataVisiteTouristiqueModel(
        id: json["id"],
        nomVt: json["nom_vt"],
        prix: json["prix"],
        description: json["description"],
        numeroVisitesTouristique: json["numero_visitesTouristique"] == null ? null : json["numero_visitesTouristique"],
        contact: json["contact"],
        lienMap: json["lien_map"],
        siteInternet: json["site_internet"],
        adresseEmail: json["adresse_email"],
        facebook: json["facebook"],
        linkedIn: json["linkedIn"],
        youtube: json["youtube"],
        instagram: json["instagram"],
        typeQuartierVtId: json["type_quartier_vt_id"],
        typeCategorieVtId: json["type_categorie_vt_id"],
        userId: json["user_id"],
        typeCategorieVt: json["type_categorie_vt"] == null ? null : TypeCategorieVt.fromJson(json["type_categorie_vt"]),
        vtMedias: json["vt_medias"]== null ? [] : List<VtMedia>.from(json["vt_medias"].map((x) => VtMedia.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "nom_vt": nomVt,
        "prix": prix,
        "description": description,
        "numero_visitesTouristique": numeroVisitesTouristique,
        "contact": contact,
        "lien_map": lienMap,
        "site_internet": siteInternet,
        "adresse_email": adresseEmail,
        "facebook": facebook,
        "linkedIn": linkedIn,
        "youtube": youtube,
        "instagram": instagram,
        "type_quartier_vt_id": typeQuartierVtId,
        "type_categorie_vt_id": typeCategorieVtId,
        "user_id": userId,
        "type_categorie_vt": typeCategorieVt == null ? null : typeCategorieVt!.toJson(),
        "vt_medias": List<dynamic>.from(vtMedias.map((x) => x.toJson())),
    };
}

class TypeCategorieVt {
    int? id;
    String? nomCategorie;
    dynamic description;


    TypeCategorieVt({
         this.id,
         this.nomCategorie,
         this.description
    });

    factory TypeCategorieVt.fromJson(Map<String, dynamic> json) => TypeCategorieVt(
        id: json["id"],
        nomCategorie: json["nom_categorie"],
        description: json["description"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "nom_categorie": nomCategorie,
        "description": description,
    };
}

class VtMedia {
    int? id;
    String? src;
    String? url;
    String? type;
    dynamic messageId;
    dynamic agendaId;
    dynamic actualiteId;
    dynamic commerceId;
    dynamic alerteId;
    dynamic annuaireId;
    dynamic sujetId;
    dynamic informationId;
    dynamic discussionId;
    dynamic commentaireId;
    dynamic hotelId;
    int? visiteTouristiqueId;
    dynamic diffusionId;
    dynamic autreCommerceId;


    VtMedia({
         this.id,
         this.src,
         this.url,
         this.type,
         this.messageId,
         this.agendaId,
         this.actualiteId,
         this.commerceId,
         this.alerteId,
         this.annuaireId,
         this.sujetId,
         this.informationId,
         this.discussionId,
         this.commentaireId,
         this.hotelId,
         this.visiteTouristiqueId,
         this.diffusionId,
         this.autreCommerceId,

    });

    factory VtMedia.fromJson(Map<String, dynamic> json) => VtMedia(
        id: json["id"],
        src: json["src"],
        url: json["url"],
        type: json["type"],
        messageId: json["message_id"],
        agendaId: json["agenda_id"],
        actualiteId: json["actualite_id"],
        commerceId: json["commerce_id"],
        alerteId: json["alerte_id"],
        annuaireId: json["annuaire_id"],
        sujetId: json["sujet_id"],
        informationId: json["information_id"],
        discussionId: json["discussion_id"],
        commentaireId: json["commentaire_id"],
        hotelId: json["hotel_id"],
        visiteTouristiqueId: json["visiteTouristique_id"],
        diffusionId: json["diffusion_id"],
        autreCommerceId: json["autre_commerce_id"],

    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "src": src,
        "url": url,
        "type": type,
        "message_id": messageId,
        "agenda_id": agendaId,
        "actualite_id": actualiteId,
        "commerce_id": commerceId,
        "alerte_id": alerteId,
        "annuaire_id": annuaireId,
        "sujet_id": sujetId,
        "information_id": informationId,
        "discussion_id": discussionId,
        "commentaire_id": commentaireId,
        "hotel_id": hotelId,
        "visiteTouristique_id": visiteTouristiqueId,
        "diffusion_id": diffusionId,
        "autre_commerce_id": autreCommerceId,

    };
}
