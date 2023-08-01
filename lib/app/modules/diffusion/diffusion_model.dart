
// RECUPERE STRING ET CONVERTIR EN JSON ET RENVOYER UNE LISTE D'OBJET DIFFUSION
import 'dart:convert';

List<Diffusion> diffusionFromJson(String str) => List<Diffusion>.from(json.decode(str)['data'].map((x) => Diffusion.fromJson(x)));
// RETOURNE UN OBJET DIFFUSION
String diffusionToJson(List<Diffusion> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Diffusion {
  int? id;
  String? objet;
  String? message;
  String? date;
  String? imageUrl;
 late List<BonPlan>? dataT;
  Diffusion({this.id, this.objet, this.message, this.date, this.imageUrl, this.dataT});

  Diffusion.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    objet = json['objet'];
    message = json['message'];
    date = json['date'];
    imageUrl = json['imageUrl'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['objet'] = objet;
    data['message'] = message;
    data['date'] = date;
    data['imageUrl'] = imageUrl;
    return data;
  }
  
}


class BonPlan {
    String? imageUrl;
    List<Media> medias;

    BonPlan({
        this.imageUrl,
        required this.medias,
    });

    factory BonPlan.fromJson(Map<String, dynamic> json) => BonPlan(
        imageUrl: json["imageUrl"],
        medias: List<Media>.from(json["medias"].map((x) => Media.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "imageUrl": imageUrl,
        "medias": List<dynamic>.from(medias.map((x) => x.toJson())),
    };
}

class Media {
    int? id;
    String? url;
    String? type;

    Media({
        this.id,
        this.url,
        this.type,
    });

    factory Media.fromJson(Map<String, dynamic> json) => Media(
        id: json["id"],
        url: json["url"],
        type: json["type"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "url": url,
        "type": type,
    };
}
