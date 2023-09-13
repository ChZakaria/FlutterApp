class Reglement {
  int id;
  int contratId;
  double montant;
  double montantRest;
  double montantFacture;
  String modePayment;
  String numCheque;
  String description;
  DateTime creeLe;
  DateTime dateEcheance;
  DateTime createdAt;
  DateTime updatedAt;

  Reglement({
    required this.id,
    required this.contratId,
    required this.montant,
    required this.montantRest,
    required this.montantFacture,
    required this.modePayment,
    required this.numCheque,
    required this.description,
    required this.creeLe,
    required this.dateEcheance,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Reglement.fromJson(Map<String, dynamic> json) {
    return Reglement(
      id: json['id'],
      contratId: json['contrat_id'],
      montant: json['montant'],
      montantRest: json['montant_rest'],
      montantFacture: json['montant_facture'],
      modePayment: json['mode_payment'],
      numCheque: json['num_cheque'],
      description: json['description'],
      creeLe: DateTime.parse(json['cree_le']),
      dateEcheance: DateTime.parse(json['date_echeance']),
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }
}
