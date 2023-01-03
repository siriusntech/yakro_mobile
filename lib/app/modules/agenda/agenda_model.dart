
import 'dart:convert';

// RECUPERE STRING ET CONVERTIR EN JSON ET RENVOYER UNE LISTE D'OBJET AGENDA
List<Agenda> agendaFromJson(String str) => List<Agenda>.from(json.decode(str)['data'].map((x) => Agenda.fromJson(x)));
// RETOURNE UN OBJET AGENDA
String agendaToJson(List<Agenda> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Agenda {
  int? id;
  String? titre;
  String? description;
  String? date;
  String? imageUrl;

  Agenda({this.id, this.titre, this.description, this.date, this.imageUrl});

  Agenda.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    titre = json['titre'];
    description = json['description'];
    date = json['date'];
    imageUrl = json['imageUrl'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['titre'] = titre;
    data['description'] = description;
    data['date'] = date;
    data['imageUrl'] = imageUrl;
    return data;
  }
}
