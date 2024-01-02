class AffichageNoteCommenatire {
  String? pseudo;
  String? commentaireHotel;
  String? noteValeur;

  AffichageNoteCommenatire(
      {this.pseudo, this.commentaireHotel, this.noteValeur});

  AffichageNoteCommenatire.fromJson(Map<String, dynamic> json) {
    pseudo = json['pseudo'];
    commentaireHotel = json['commentaireHotel'];
    noteValeur = json['noteValeur'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['pseudo'] = this.pseudo;
    data['commentaireHotel'] = this.commentaireHotel;
    data['noteValeur'] = this.noteValeur;
    return data;
  }
}
