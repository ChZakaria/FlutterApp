class Contrat {
  int id;
  int locataireId;
  int vehiculeId;
  DateTime dateLocation;
  DateTime dateRetour;
  double prixU;
  double montantRest;
  double montantAvance;
  double montantTotal;
  String statut;
  DateTime creeLe;
  DateTime misAJourLe;
  String intermediaire;
  String lieuDepart;
  String lieuRetour;
  int kmDepart;
  int kmRetour;
  String observation;

  Contrat({
    required this.id,
    required this.locataireId,
    required this.vehiculeId,
    required this.dateLocation,
    required this.dateRetour,
    required this.prixU,
    required this.montantRest,
    required this.montantAvance,
    required this.montantTotal,
    required this.statut,
    required this.creeLe,
    required this.misAJourLe,
    required this.intermediaire,
    required this.lieuDepart,
    required this.lieuRetour,
    required this.kmDepart,
    required this.kmRetour,
    required this.observation,
  });

  factory Contrat.fromJson(Map<String, dynamic> json) {
    return Contrat(
      id: json["id"],
      locataireId: json["locataire_id"],
      vehiculeId: json["vehicule_id"],
      dateLocation: DateTime.parse(json["date_location"]),
      dateRetour: DateTime.parse(json["date_retour"]),
      prixU: double.parse(json["prix_u"]),
      montantRest: double.parse(json["montant_rest"]),
      montantAvance: double.parse(json["montant_avance"]),
      montantTotal: double.parse(json["montant_total"]),
      statut: json["statut"],
      creeLe: DateTime.parse(json["cree_le"]),
      misAJourLe: DateTime.parse(json["mis_a_jour_le"]),
      intermediaire: json["intermediaire"],
      lieuDepart: json["lieu_depart"],
      lieuRetour: json["lieu_retour"],
      kmDepart: json["km_depart"],
      kmRetour: json["km_retour"],
      observation: json["observation"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "locataire_id": locataireId,
      "vehicule_id": vehiculeId,
      "date_location": dateLocation.toIso8601String(),
      "date_retour": dateRetour.toIso8601String(),
      "prix_u": prixU,
      "montant_rest": montantRest,
      "montant_avance": montantAvance,
      "montant_total": montantTotal,
      "statut": statut,
      "cree_le": creeLe.toIso8601String(),
      "mis_a_jour_le": misAJourLe.toIso8601String(),
      "intermediaire": intermediaire,
      "lieu_depart": lieuDepart,
      "lieu_retour": lieuRetour,
      "km_depart": kmDepart,
      "km_retour": kmRetour,
      "observation": observation,
    };
  }
}
