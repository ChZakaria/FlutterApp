// To parse this JSON data, do
//
//     final locataire = locataireFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

Locataire locataireFromJson(String str) => Locataire.fromJson(json.decode(str));

String locataireToJson(Locataire data) => json.encode(data.toJson());

class Locataire {
  int id;
  String nom;
  String email;
  String telephone;
  String adresse;
  DateTime creeLe;
  DateTime misAJourLe;

  Locataire({
    required this.id,
    required this.nom,
    required this.email,
    required this.telephone,
    required this.adresse,
    required this.creeLe,
    required this.misAJourLe,
  });

  Locataire copyWith({
    int? id,
    String? nom,
    String? email,
    String? telephone,
    String? adresse,
    DateTime? creeLe,
    DateTime? misAJourLe,
  }) =>
      Locataire(
        id: id ?? this.id,
        nom: nom ?? this.nom,
        email: email ?? this.email,
        telephone: telephone ?? this.telephone,
        adresse: adresse ?? this.adresse,
        creeLe: creeLe ?? this.creeLe,
        misAJourLe: misAJourLe ?? this.misAJourLe,
      );

  factory Locataire.fromJson(Map<String, dynamic> json) => Locataire(
        id: json["id"],
        nom: json["nom"],
        email: json["email"],
        telephone: json["telephone"],
        adresse: json["adresse"],
        creeLe: DateTime.parse(json["cree_le"]),
        misAJourLe: DateTime.parse(json["mis_a_jour_le"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nom": nom,
        "email": email,
        "telephone": telephone,
        "adresse": adresse,
        "cree_le": creeLe.toIso8601String(),
        "mis_a_jour_le": misAJourLe.toIso8601String(),
      };
}
