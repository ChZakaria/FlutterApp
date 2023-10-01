// To parse this JSON data, do
//
//     final contrat = contratFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

Contrat contratFromJson(String str) => Contrat.fromJson(json.decode(str));

String contratToJson(Contrat data) => json.encode(data.toJson());

class Contrat {
  int id;
  int locataireId;
  int vhiculeId;
  DateTime dateLocation;
  DateTime dateRetour;
  double prixU;
  double montantRest;
  double montantAvance;
  double montantTotal;
  String statut;
  String crLe;
  String misJourLe;
  int intermdiaireId;
  String lieuDepart;
  String lieuRetour;
  int kmDepart;
  int kmRetour;
  String observation;

  Contrat({
    required this.id,
    required this.locataireId,
    required this.vhiculeId,
    required this.dateLocation,
    required this.dateRetour,
    required this.prixU,
    required this.montantRest,
    required this.montantAvance,
    required this.montantTotal,
    required this.statut,
    required this.crLe,
    required this.misJourLe,
    required this.intermdiaireId,
    required this.lieuDepart,
    required this.lieuRetour,
    required this.kmDepart,
    required this.kmRetour,
    required this.observation,
  });

  Contrat copyWith({
    int? id,
    int? locataireId,
    int? vhiculeId,
    DateTime? dateLocation,
    DateTime? dateRetour,
    double? prixU,
    double? montantRest,
    double? montantAvance,
    double? montantTotal,
    String? statut,
    String? crLe,
    String? misJourLe,
    String? intermdiaire,
    String? lieuDepart,
    String? lieuRetour,
    int? kmDepart,
    int? kmRetour,
    String? observation,
  }) =>
      Contrat(
        id: id ?? this.id,
        locataireId: locataireId ?? this.locataireId,
        vhiculeId: vhiculeId ?? this.vhiculeId,
        dateLocation: dateLocation ?? this.dateLocation,
        dateRetour: dateRetour ?? this.dateRetour,
        prixU: prixU ?? this.prixU,
        montantRest: montantRest ?? this.montantRest,
        montantAvance: montantAvance ?? this.montantAvance,
        montantTotal: montantTotal ?? this.montantTotal,
        statut: statut ?? this.statut,
        crLe: crLe ?? this.crLe,
        misJourLe: misJourLe ?? this.misJourLe,
        intermdiaireId: intermdiaireId ?? this.intermdiaireId,
        lieuDepart: lieuDepart ?? this.lieuDepart,
        lieuRetour: lieuRetour ?? this.lieuRetour,
        kmDepart: kmDepart ?? this.kmDepart,
        kmRetour: kmRetour ?? this.kmRetour,
        observation: observation ?? this.observation,
      );

  factory Contrat.fromJson(Map<String, dynamic> json) => Contrat(
        id: json["id"],
        locataireId: json["locataire_id"],
        vhiculeId: json["vehicule_id"],
        dateLocation: DateTime.parse(json["date_location"]),
        dateRetour: DateTime.parse(json["date_retour"]),
        prixU: double.parse(json["prix_u"].toString()),
        montantRest: double.parse(json["montant_rest"].toString()),
        montantAvance: double.parse(json["montant_avance"].toString()),
        montantTotal: double.parse(json["montant_total"].toString()),
        statut: json["statut"],
        crLe: json["cree_le"],
        misJourLe: json["mis_a_jour_le"].toString(),
        intermdiaireId: json["intermediaire"],
        lieuDepart: json["lieu_depart"],
        lieuRetour: json["lieu_retour"],
        kmDepart: json["km_depart"],
        kmRetour: json["km_retour"],
        observation: json["observation"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "locataire_id": locataireId,
        "vehicule_id": vhiculeId,
        "date_location":
            "${dateLocation.year.toString().padLeft(4, '0')}-${dateLocation.month.toString().padLeft(2, '0')}-${dateLocation.day.toString().padLeft(2, '0')}",
        "date_retour":
            "${dateRetour.year.toString().padLeft(4, '0')}-${dateRetour.month.toString().padLeft(2, '0')}-${dateRetour.day.toString().padLeft(2, '0')}",
        "prix_u": prixU,
        "montant_rest": montantRest,
        "montant_avance": montantAvance,
        "montant_total": montantTotal,
        "statut": statut,
        "cree_le": crLe,
        "mis_a_jour_le": misJourLe,
        "intermediaire": intermdiaireId,
        "lieu_depart": lieuDepart,
        "lieu_retour": lieuRetour,
        "km_depart": kmDepart,
        "km_retour": kmRetour,
        "observation": observation,
      };
}
