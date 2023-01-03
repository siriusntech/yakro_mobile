

class Utilitaire {
  String? libelle;
  String? contenu;

  Utilitaire({this.libelle, this.contenu});

  factory Utilitaire.fromJson(Map<String, dynamic> data){
    return Utilitaire(libelle : data['libelle'], contenu : data['contenu']);
  }

  Map<String, dynamic> toJson() => {
    "libelle": libelle,
    "contenu": contenu,
  };
}

class ParamsServices{


}