import 'package:jaime_yakro/app/models/media.dart';
import 'package:jaime_yakro/app/modules/historique/information_model.dart';

import 'dart:convert';

// RECUPERE STRING ET CONVERTIR EN JSON ET RENVOYER UNE LISTE D'OBJET HISTORIQUE
List<Historique> historiqueFromJson(String str) => List<Historique>.from(json.decode(str)['data'].map((x) => Historique.fromJson(x)));
// RETOURNE UN OBJET STRING HISTORIQUE
String historiqueToJson(List<Historique> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Historique {
  int? id;
  int? likeCount;
  int? unLikeCount;
  int? liked;
  int? is_read;
  String? titre;
  String? description;
  String? date;
  List<Information>? informations;
  List<Media>? medias;

  Historique(
      {this.id,
      this.likeCount,
      this.unLikeCount,
      this.liked,
      this.is_read,
      this.titre,
      this.description,
      this.date,
      this.informations,
      this.medias});

  Historique.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    likeCount = json['like_count'];
    unLikeCount = json['un_like_count'];
    liked = json['liked'];
    is_read = json['is_read'];
    titre = json['titre'];
    description = json['description'];
    date = json['date'];
    if (json['informations'] != null) {
      informations = <Information>[];
      json['informations'].forEach((v) {
        informations?.add(Information.fromJson(v));
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
    data['like_count'] = likeCount;
    data['un_like_count'] = unLikeCount;
    data['liked'] = liked;
    data['is_read'] = is_read;
    data['titre'] = titre;
    data['description'] = description;
    data['date'] = date;
    if (informations != null) {
      data['informations'] = informations?.map((v) => v.toJson()).toList();
    }
    if (medias != null) {
      data['medias'] = medias?.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
