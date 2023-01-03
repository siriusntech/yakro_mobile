import 'dart:convert';

// RECUPERE STRING ET CONVERTIR EN JSON ET RENVOYER UNE LISTE D'OBJET COMMENTAIRE
List<Commentaire> commentaireFromJson(String str) => List<Commentaire>.from(json.decode(str)['data'].map((x) => Commentaire.fromJson(x)));
// RETOURNE UN OBJET COMMENTAIRE
String commentaireToJson(List<Commentaire> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Commentaire {
  int? id;
  String? texte;
  List<Commentaire>? reponses;
  int? senderId;
  int? likeCount;
  int? unLikeCount;
  int? liked;
  int? is_reponse;
  String? senderPseudo;
  String? date;

  Commentaire(
      {this.id,
      this.texte,
      this.reponses,
      this.senderId,
      this.likeCount,
      this.unLikeCount,
      this.liked,
      this.is_reponse,
      this.senderPseudo,
      this.date});

  Commentaire.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    texte = json['texte'];
    if (json['reponses'] != null) {
      reponses = <Commentaire>[];
      json['reponses'].forEach((v) {
        reponses?.add(Commentaire.fromJson(v));
      });
    }
    senderId = json['sender_id'];
    likeCount = json['like_count'];
    unLikeCount = json['un_like_count'];
    liked = json['liked'];
    is_reponse = json['is_reponse'];
    senderPseudo = json['sender_pseudo'];
    date = json['date'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['texte'] = texte;
    if (reponses != null) {
      data['reponses'] = reponses?.map((v) => v.toJson()).toList();
    }
    data['sender_id'] = senderId;
    data['like_count'] = likeCount;
    data['un_like_count'] = unLikeCount;
    data['liked'] = liked;
    data['is_reponse'] = is_reponse;
    data['sender_pseudo'] = senderPseudo;
    data['date'] = date;
    return data;
  }
}

// REPONSE COMMENTAIRE
class CommentaireReponse {
  int? id;
  String? texte;
  List<CommentaireReponse>? reponses;
  int? senderId;
  int? likeCount;
  int? unLikeCount;
  int? liked;
  String? senderPseudo;
  String? date;

  CommentaireReponse(
      {this.id,
        this.texte,
        this.reponses,
        this.senderId,
        this.likeCount,
        this.unLikeCount,
        this.liked,
        this.senderPseudo,
        this.date});

  CommentaireReponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    texte = json['texte'];
    if (json['reponses'] != null) {
      reponses = <CommentaireReponse>[];
      json['reponses'].forEach((v) {
        reponses?.add(CommentaireReponse.fromJson(v));
      });
    }
    senderId = json['sender_id'];
    likeCount = json['like_count'];
    unLikeCount = json['un_like_count'];
    liked = json['liked'];
    senderPseudo = json['sender_pseudo'];
    date = json['date'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['texte'] = texte;
    if (reponses != null) {
      data['reponses'] = reponses?.map((v) => v.toJson()).toList();
    }
    data['sender_id'] = senderId;
    data['like_count'] = likeCount;
    data['un_like_count'] = unLikeCount;
    data['liked'] = liked;
    data['sender_pseudo'] = senderPseudo;
    data['date'] = date;
    return data;
  }
}
