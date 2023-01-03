import '../../models/media.dart';

import 'dart:convert';

// RECUPERE STRING ET CONVERTIR EN JSON ET RENVOYER UNE LISTE D'OBJET INFORMATION
List<Information> informationFromJson(String str) => List<Information>.from(json.decode(str)['data'].map((x) => Information.fromJson(x)));
// RETOURNE UN OBJET INFORMATION
String informationToJson(List<Information> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Information {
  int? id;
  int? likeCount;
  int? unLikeCount;
  int? liked;
  int? is_read;
  String? titre;
  String? description;
  String? date;
  List<Media>? medias;

  Information(
      {this.id,
      this.likeCount,
      this.unLikeCount,
      this.liked,
      this.is_read,
      this.titre,
      this.description,
      this.date,
      this.medias});

  Information.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    likeCount = json['like_count'];
    unLikeCount = json['un_like_count'];
    liked = json['liked'];
    is_read = json['is_read'];
    titre = json['titre'];
    description = json['description'];
    date = json['date'];
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
    if (medias != null) {
      data['medias'] = medias?.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
