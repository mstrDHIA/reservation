class Reservation {
  int? id;
  int? eventId;
  int? quantite;
  Client? client;

  Reservation({this.eventId, this.quantite, this.client});

  Reservation.fromJson(Map<String, dynamic> json) {
    eventId = json['event_id'];
    quantite = json['quantite'];
    client =
        json['client'] != null ? Client.fromJson(json['client']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['event_id'] = eventId;
    data['quantite'] = quantite;
    if (client != null) {
      data['client'] = client!.toJson();
    }
    return data;
  }
}

class Client {
  String? nom;
  String? email;

  Client({this.nom, this.email});

  Client.fromJson(Map<String, dynamic> json) {
    nom = json['nom'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['nom'] = nom;
    data['email'] = email;
    return data;
  }
}
