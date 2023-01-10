import 'package:jaime_cocody/app/models/media.dart';
import 'package:jaime_cocody/app/modules/discussion/commentaire_model.dart';

import 'dart:convert';

// RECUPERE STRING ET CONVERTIR EN JSON ET RENVOYER UNE LISTE D'OBJET DISCUSSION
List<Discussion> discussionFromJson(String str) => List<Discussion>.from(json.decode(str)['data'].map((x) => Discussion.fromJson(x)));
// RETOURNE UN OBJET DISCUSSION
String discussionToJson(List<Discussion> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Discussion {
  int? id;
  int? senderId;
  int? likeCount;
  int? unLikeCount;
  int? liked;
  String? senderPseudo;
  String? date;
  String? sujet;
  List<Commentaire>? commentaires;
  List<Media>? medias;

  Discussion(
      {this.id,
      this.senderId,
      this.likeCount,
      this.unLikeCount,
      this.liked,
      this.senderPseudo,
      this.date,
      this.sujet,
      this.commentaires,
      this.medias});

  Discussion.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    senderId = json['sender_id'];
    likeCount = json['like_count'];
    unLikeCount = json['un_like_count'];
    liked = json['liked'];
    senderPseudo = json['sender_pseudo'];
    date = json['date'];
    sujet = json['sujet'];
    if (json['commentaires'] != null) {
      commentaires = <Commentaire>[];
      json['commentaires'].forEach((v) {
        commentaires?.add(Commentaire.fromJson(v));
      });
    }
    if (json['medias'] != null) {
      medias = <Media>[];
      json['medias'].forEach((v) {
        medias?.add(Media.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['sender_id'] = senderId;
    data['like_count'] = likeCount;
    data['un_like_count'] = unLikeCount;
    data['liked'] = liked;
    data['sender_pseudo'] = senderPseudo;
    data['date'] = date;
    data['sujet'] = sujet;
    if (commentaires != null) {
      data['commentaires'] = commentaires?.map((v) => v.toJson()).toList();
    }
    if (medias != null) {
      data['medias'] = medias?.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
