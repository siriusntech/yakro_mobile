import 'dart:convert';

// RECUPERE STRING ET CONVERTIR EN JSON ET RENVOYER UNE LISTE D'OBJET MEDIA
List<Media> mediaFromJson(String str) => List<Media>.from(json.decode(str)['data'].map((x) => Media.fromJson(x)));
// RETOURNE UN OBJET MEDIA
String mediaToJson(List<Media> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Media{
   int? id;
   String? url;
   String? type;

   Media({this.id, this.url, this.type});

   factory Media.fromJson(Map<dynamic, dynamic> json) => Media(
       id: json["id"] ?? null,
       url: json["url"] ?? null,
       type: json["type"] ?? null,
   );

   Map<String, dynamic> toJson() => {
      "id": id,
      "url": url,
      "type": type,
   };
}