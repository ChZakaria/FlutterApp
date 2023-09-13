class Supplement {
  final int id;
  final int contratId;
  final String montant;
  final String description;

  Supplement({required this.id, required this.contratId, required this.montant, required this.description});

  factory Supplement.fromJson(Map<String, dynamic> json) {
    return Supplement(
      id: json['id'],
      contratId: json['contrat_id'],
      montant: json['montant'],
      description: json['description'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'contrat_id': contratId,
      'montant': montant,
      'description': description,
    };
  }
}