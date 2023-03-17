

// RECUPERE STRING ET CONVERTIR EN JSON ET RENVOYER UNE LISTE D'OBJET JOB
import 'dart:convert';

List<JobModel> jobModelFromJson(String str) => List<JobModel>.from(json.decode(str)['data'].map((x) => JobModel.fromJson(x)));
// RETOURNE UN OBJET JOB
String jobModelToJson(List<JobModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class JobModel {
  int? id;
  String? entreprise;
  String? intitule;
  String? date_publication;
  String? description;
  String? date_limite;
  String? image;
  String? lien;

  JobModel(
      {this.id,
      this.entreprise,
      this.intitule,
      this.date_publication,
      this.description,
      this.date_limite,
      this.image,
      this.lien});

  JobModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    entreprise = json['entreprise'];
    intitule = json['intitule'];
    date_publication = json['date_publication'];
    description = json['description'];
    date_limite = json['date_limite'];
    image = json['image'];
    lien = json['lien'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['entreprise'] = entreprise;
    data['intitule'] = intitule;
    data['date_publication'] = date_publication;
    data['description'] = description;
    data['date_limite'] = date_limite;
    data['image'] = image;
    data['lien'] = lien;
    return data;
  }
}
