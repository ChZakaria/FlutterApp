
import 'dart:convert';

ChargeFixes chargeFixesFromJson(String str) => ChargeFixes.fromJson(json.decode(str));

String chargeFixesToJson(ChargeFixes data) => json.encode(data.toJson());

class ChargeFixes {
    int id;
    int vehiculeId;
    String montant;
    String description;
    String fournisseur;
    DateTime dateDebut;
    DateTime dateFin;
    int mavertirAvant;
    DateTime creeLe;
    dynamic misAJourLe;
    dynamic createdAt;
    dynamic updatedAt;

    ChargeFixes({
        required this.id,
        required this.vehiculeId,
        required this.montant,
        required this.description,
        required this.fournisseur,
        required this.dateDebut,
        required this.dateFin,
        required this.mavertirAvant,
        required this.creeLe,
        required this.misAJourLe,
        required this.createdAt,
        required this.updatedAt,
    });

    ChargeFixes copyWith({
        int? id,
        int? vehiculeId,
        String? montant,
        String? description,
        String? fournisseur,
        DateTime? dateDebut,
        DateTime? dateFin,
        int? mavertirAvant,
        DateTime? creeLe,
        dynamic misAJourLe,
        dynamic createdAt,
        dynamic updatedAt,
    }) => 
        ChargeFixes(
            id: id ?? this.id,
            vehiculeId: vehiculeId ?? this.vehiculeId,
            montant: montant ?? this.montant,
            description: description ?? this.description,
            fournisseur: fournisseur ?? this.fournisseur,
            dateDebut: dateDebut ?? this.dateDebut,
            dateFin: dateFin ?? this.dateFin,
            mavertirAvant: mavertirAvant ?? this.mavertirAvant,
            creeLe: creeLe ?? this.creeLe,
            misAJourLe: misAJourLe ?? this.misAJourLe,
            createdAt: createdAt ?? this.createdAt,
            updatedAt: updatedAt ?? this.updatedAt,
        );

    factory ChargeFixes.fromJson(Map<String, dynamic> json) => ChargeFixes(
        id: json["id"],
        vehiculeId: json["vehicule_id"],
        montant: json["montant"],
        description: json["description"],
        fournisseur: json["fournisseur"],
        dateDebut: DateTime.parse(json["date_debut"]),
        dateFin: DateTime.parse(json["date_fin"]),
        mavertirAvant: json["mavertir_avant"],
        creeLe: DateTime.parse(json["cree_le"]),
        misAJourLe: json["mis_a_jour_le"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "vehicule_id": vehiculeId,
        "montant": montant,
        "description": description,
        "fournisseur": fournisseur,
        "date_debut": dateDebut.toIso8601String(),
        "date_fin": dateFin.toIso8601String(),
        "mavertir_avant": mavertirAvant,
        "cree_le": creeLe.toIso8601String(),
        "mis_a_jour_le": misAJourLe,
        "created_at": createdAt,
        "updated_at": updatedAt,
    };
}
