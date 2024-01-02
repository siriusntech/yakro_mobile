// To parse this JSON data, do
//
//     final commentaireNote = commentaireNoteFromMap(jsonString);

import 'dart:convert';

List<CommentaireNote> commentaireNoteFromMap(String str) => List<CommentaireNote>.from(json.decode(str).map((x) => CommentaireNote.fromMap(x)));

String commentaireNoteToMap(List<CommentaireNote> data) => json.encode(List<dynamic>.from(data.map((x) => x.toMap())));

class CommentaireNote {
    int? id;
    int? hotelId;
    int? restaurantId;
    int? userId;
    dynamic discussionId;
    String? texte;
    dynamic valeur;
    String? isReponse;
    dynamic mainCommentaireId;
    String? isActif;
    String? liked;
    String? likeCount;
    String? unLikeCount;
    dynamic senderId;
    dynamic senderPseudo;
    dynamic createdAt;
    dynamic updatedAt;
    dynamic deletedAt;
    User? user;
    Hotel? hotel;

    CommentaireNote({
        this.id,
        this.hotelId,
        this.restaurantId,
        this.userId,
        this.discussionId,
        this.texte,
        this.valeur,
         this.isReponse,
         this.mainCommentaireId,
         this.isActif,
         this.liked,
         this.likeCount,
         this.unLikeCount,
         this.senderId,
         this.senderPseudo,
         this.createdAt,
         this.updatedAt,
         this.deletedAt,
         this.user,
         this.hotel,
    });

factory CommentaireNote.fromMap(Map<String, dynamic> json) => CommentaireNote(
  id: json["id"],
  hotelId: json["hotel_id"],
  restaurantId: json["restaurant_id"],
  userId: json["user_id"],
  discussionId: json["discussion_id"],
  texte: json["texte"] ?? "",
  valeur: json["valeur"],
  isReponse: json["is_reponse"] ?? "",
  mainCommentaireId: json["main_commentaire_id"],
  isActif: json["is_actif"] ?? "",
  liked: json["liked"] ?? "",
  likeCount: json["like_count"] ?? "",
  unLikeCount: json["un_like_count"] ?? "",
  senderId: json["sender_id"],
  senderPseudo: json["sender_pseudo"],
  createdAt: json["created_at"],
  updatedAt: json["updated_at"],
  deletedAt: json["deleted_at"],
  user: json["user"] != null ? User.fromMap(json["user"]) : null,
  hotel: json["hotel"] != null ? Hotel.fromMap(json["hotel"]) : null,
);


    Map<String, dynamic> toMap() => {
        "id": id,
        "hotel_id": hotelId,
        "restaurant_id": restaurantId,
        "user_id": userId,
        "discussion_id": discussionId,
        "texte": texte,
        "valeur": valeur,
        "is_reponse": isReponse,
        "main_commentaire_id": mainCommentaireId,
        "is_actif": isActif,
        "liked": liked,
        "like_count": likeCount,
        "un_like_count": unLikeCount,
        "sender_id": senderId,
        "sender_pseudo": senderPseudo,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "deleted_at": deletedAt,
        "user": user?.toMap(),
        "hotel": hotel?.toMap(),
    };
}

class Hotel {
    int id;
    String nomHotel;
    int prix;
    String description;
    dynamic avis;
    String numeroHotel;
    String contact;
    String lienMap;
    String siteInternet;
    String adresseEmail;
    dynamic facebook;
    dynamic linkedIn;
    dynamic youtube;
    dynamic instagram;
    String typeQuartierHotelsId;
    String typeHotelId;
    String userId;
    dynamic deletedAt;
    String createdAt;
    String updatedAt;

    Hotel({
        required this.id,
        required this.nomHotel,
        required this.prix,
        required this.description,
        required this.avis,
        required this.numeroHotel,
        required this.contact,
        required this.lienMap,
        required this.siteInternet,
        required this.adresseEmail,
        required this.facebook,
        required this.linkedIn,
        required this.youtube,
        required this.instagram,
        required this.typeQuartierHotelsId,
        required this.typeHotelId,
        required this.userId,
        required this.deletedAt,
        required this.createdAt,
        required this.updatedAt,
    });

    factory Hotel.fromMap(Map<String, dynamic> json) => Hotel(
        id: json["id"],
        nomHotel: json["nom_hotel"],
        prix: json["prix"],
        description: json["description"],
        avis: json["avis"],
        numeroHotel: json["numero_hotel"],
        contact: json["contact"],
        lienMap: json["lien_map"],
        siteInternet: json["site_internet"],
        adresseEmail: json["adresse_email"],
        facebook: json["facebook"],
        linkedIn: json["linkedIn"],
        youtube: json["youtube"],
        instagram: json["instagram"],
        typeQuartierHotelsId: json["type_quartier_hotels_id"],
        typeHotelId: json["type_hotel_id"],
        userId: json["user_id"],
        deletedAt: json["deleted_at"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "nom_hotel": nomHotel,
        "prix": prix,
        "description": description,
        "avis": avis,
        "numero_hotel": numeroHotel,
        "contact": contact,
        "lien_map": lienMap,
        "site_internet": siteInternet,
        "adresse_email": adresseEmail,
        "facebook": facebook,
        "linkedIn": linkedIn,
        "youtube": youtube,
        "instagram": instagram,
        "type_quartier_hotels_id": typeQuartierHotelsId,
        "type_hotel_id": typeHotelId,
        "user_id": userId,
        "deleted_at": deletedAt,
        "created_at": createdAt,
        "updated_at": updatedAt,
    };
}

class User {
    int id;
    dynamic equipeId;
    dynamic nom;
    dynamic prenom;
    String pseudo;
    String contact;
    String code;
    String isActif;
    String accountExist;
    String photo;
    dynamic email;
    dynamic emailVerifiedAt;
    dynamic twoFactorSecret;
    dynamic twoFactorRecoveryCodes;
    String source;
    dynamic role;
    String cloudMessagingToken;
    dynamic poste;
    String createdAt;
    String updatedAt;
    dynamic deletedAt;

    User({
        required this.id,
        required this.equipeId,
        required this.nom,
        required this.prenom,
        required this.pseudo,
        required this.contact,
        required this.code,
        required this.isActif,
        required this.accountExist,
        required this.photo,
        required this.email,
        required this.emailVerifiedAt,
        required this.twoFactorSecret,
        required this.twoFactorRecoveryCodes,
        required this.source,
        required this.role,
        required this.cloudMessagingToken,
        required this.poste,
        required this.createdAt,
        required this.updatedAt,
        required this.deletedAt,
    });

    factory User.fromMap(Map<String, dynamic> json) => User(
        id: json["id"],
        equipeId: json["equipe_id"],
        nom: json["nom"],
        prenom: json["prenom"],
        pseudo: json["pseudo"],
        contact: json["contact"],
        code: json["code"],
        isActif: json["is_actif"],
        accountExist: json["account_exist"],
        photo: json["photo"],
        email: json["email"],
        emailVerifiedAt: json["email_verified_at"],
        twoFactorSecret: json["two_factor_secret"],
        twoFactorRecoveryCodes: json["two_factor_recovery_codes"],
        source: json["source"],
        role: json["role"],
        cloudMessagingToken: json["cloud_messaging_token"],
        poste: json["poste"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        deletedAt: json["deleted_at"],
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "equipe_id": equipeId,
        "nom": nom,
        "prenom": prenom,
        "pseudo": pseudo,
        "contact": contact,
        "code": code,
        "is_actif": isActif,
        "account_exist": accountExist,
        "photo": photo,
        "email": email,
        "email_verified_at": emailVerifiedAt,
        "two_factor_secret": twoFactorSecret,
        "two_factor_recovery_codes": twoFactorRecoveryCodes,
        "source": source,
        "role": role,
        "cloud_messaging_token": cloudMessagingToken,
        "poste": poste,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "deleted_at": deletedAt,
    };
}