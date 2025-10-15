class Event {
  int? id;
  String? titre;
  String? prix;
  int? placesDisponibles;

  Event({this.id, this.titre, this.prix, this.placesDisponibles});

  Event.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    titre = json['titre'];
    prix = json['prix'];
    placesDisponibles = json['places_disponibles'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['titre'] = titre;
    data['prix'] = prix;
    data['places_disponibles'] = placesDisponibles;
    return data;
  }
}
