
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

  Diffusion({this.id, this.objet, this.message, this.date, this.imageUrl});

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
