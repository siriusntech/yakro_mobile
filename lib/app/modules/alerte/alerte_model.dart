
import 'dart:convert';

// RECUPERE STRING ET CONVERTIR EN JSON ET RENVOYER UNE LISTE D'OBJET ALERTE
List<Alerte> alerteFromJson(String str) => List<Alerte>.from(json.decode(str)['data'].map((x) => Alerte.fromJson(x)));
// RETOURNE UN OBJET ALERTE
String alerteToJson(List<Alerte> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Alerte {
  int? id;
  int? senderId;
  int? typeId;
  int? likeCount;
  int? unLikeCount;
  int? liked;
  String? type;
  String? senderPseudo;
  String? localisation;
  String? description;
  String? date;
  String? dateIncident;
  String? fileUrl;
  String? fileType;
  Reponse? reponse;

  Alerte(
      {this.id,
      this.senderId,
      this.typeId,
      this.likeCount,
      this.unLikeCount,
      this.liked,
      this.type,
      this.senderPseudo,
      this.localisation,
      this.description,
      this.date,
      this.dateIncident,
      this.fileUrl,
      this.fileType,
      this.reponse});

  Alerte.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    senderId = json['sender_id'];
    typeId = json['type_id'];
    likeCount = json['like_count'];
    unLikeCount = json['un_like_count'];
    liked = json['liked'];
    type = json['type'];
    senderPseudo = json['sender_pseudo'];
    localisation = json['localisation'];
    description = json['description'];
    date = json['date'];
    dateIncident = json['date_incident'];
    fileUrl = json['fileUrl'];
    fileType = json['fileType'];
    reponse = json['reponse'] != null ? Reponse?.fromJson(json['reponse']) : null;
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
    data['localisation'] = localisation;
    data['description'] = description;
    data['date'] = date;
    data['date_incident'] = dateIncident;
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
  int like = 0;
  int un_like = 0;
  int liked = 0;
  String? date;
  String? contenu;
  String? fileUrl;
  String? sender_name;
  String? sender_poste;

  Reponse({this.id, this.date, this.contenu, this.fileUrl, this.sender_name, this.sender_poste, required this.like, required this.un_like, required this.liked});

  Reponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    date = json['date'];
    contenu = json['contenu'];
    fileUrl = json['fileUrl'];
    sender_name = json['sender_name'];
    sender_poste = json['sender_poste'];
    like = json['like'];
    un_like = json['un_like'];
    liked = json['liked'];
  }


  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['date'] = date;
    data['contenu'] = contenu;
    data['fileUrl'] = fileUrl;
    data['sender_name'] = sender_name;
    data['sender_poste'] = sender_poste;
    data['like'] = like;
    data['un_like'] = un_like;
    data['liked'] = liked;
    return data;
  }
}
