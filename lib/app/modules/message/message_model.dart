

import 'dart:convert';
// RECUPERE STRING ET CONVERTIR EN JSON ET RENVOYER UNE LISTE D'OBJET ACTUALITE
List<Message> messageFromJson(String str) => List<Message>.from(json.decode(str)['data'].map((x) => Message.fromJson(x)));
// RETOURNE UN OBJET MESSAGE
String messageToJson(List<Message> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));


class Message {
  int? id;
  int? senderId;
  int? typeId;
  int? likeCount;
  int? unLikeCount;
  int? liked;
  String? type;
  String? senderPseudo;
  String? libelle;
  String? description;
  String? date;
  String? fileUrl;
  String? fileType;
  Reponse? reponse;

  Message(
      {this.id,
      this.senderId,
      this.typeId,
      this.likeCount,
      this.unLikeCount,
      this.liked,
      this.type,
      this.senderPseudo,
      this.libelle,
      this.description,
      this.date,
      this.fileUrl,
      this.fileType,
      this.reponse});

  Message.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    senderId = json['sender_id'];
    typeId = json['type_id'];
    likeCount = json['like_count'];
    unLikeCount = json['un_like_count'];
    liked = json['liked'];
    type = json['type'];
    senderPseudo = json['sender_pseudo'];
    libelle = json['libelle'];
    description = json['description'];
    date = json['date'];
    fileUrl = json['fileUrl'];
    fileType = json['fileType'];
    reponse =
        json['reponse'] != null ? Reponse?.fromJson(json['reponse']) : null;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['sender_id'] = senderId;
    data['type_id'] = typeId;
    data['like_count'] = likeCount;
    data['un_like_count'] = unLikeCount;
    data['liked'] = liked;
    data['type'] = type;
    data['sender_pseudo'] = senderPseudo;
    data['libelle'] = libelle;
    data['description'] = description;
    data['date'] = date;
    data['fileUrl'] = fileUrl;
    data['fileType'] = fileType;
    if (reponse != null) {
      data['reponse'] = reponse?.toJson();
    }
    return data;
  }
}

class Reponse {
  int? id;
  String? date;
  String? contenu;
  String? fileUrl;

  Reponse({this.id, this.date, this.contenu, this.fileUrl});

  Reponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    date = json['date'];
    contenu = json['contenu'];
    fileUrl = json['fileUrl'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['date'] = date;
    data['contenu'] = contenu;
    data['fileUrl'] = fileUrl;
    return data;
  }
}
