class ChargeFixes {
  int id;
  int contratId;
  double montant;
  String description;
  DateTime creeLe;
  DateTime misAJourLe;
  DateTime createdAt;
  DateTime updatedAt;

  ChargeFixes({
    required this.id,
    required this.contratId,
    required this.montant,
    required this.description,
    required this.creeLe,
    required this.misAJourLe,
    required this.createdAt,
    required this.updatedAt,
  });

  ChargeFixes copyWith({
    int? id,
    int? contratId,
    double? montant,
    String? description,
    DateTime? creeLe,
    DateTime? misAJourLe,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) =>
      ChargeFixes(
        id: id ?? this.id,
        contratId: contratId ?? this.contratId,
        montant: montant ?? this.montant,
        description: description ?? this.description,
        creeLe: creeLe ?? this.creeLe,
        misAJourLe: misAJourLe ?? this.misAJourLe,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  factory ChargeFixes.fromJson(Map<String, dynamic> json) => ChargeFixes(
        id: json["id"],
        contratId: json["contrat_id"],
        montant: json["montant"].toDouble(),
        description: json["description"],
        creeLe: DateTime.parse(json["cree_le"]),
        misAJourLe: DateTime.parse(json["mis_a_jour_le"]),
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "contrat_id": contratId,
        "montant": montant,
        "description": description,
        "cree_le": creeLe.toIso8601String(),
        "mis_a_jour_le": misAJourLe.toIso8601String(),
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
