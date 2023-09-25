import 'package:meta/meta.dart';
import 'dart:convert';

Entretien entretienFromJson(String str) => Entretien.fromJson(json.decode(str));

String entretienToJson(Entretien data) => json.encode(data.toJson());

class Entretien {
  int id;
  int vehiculeId;
  String operation;
  double frais;
  int fhuile;
  int fair;
  int fcarburant;
  String date;
  int kmM;
  int kmP;
  double montants;
  int mavertirAvant;
  String observation;

  Entretien({
    required this.id,
    required this.vehiculeId,
    required this.operation,
    required this.frais,
    required this.fhuile,
    required this.fair,
    required this.fcarburant,
    required this.date,
    required this.kmM,
    required this.kmP,
    required this.montants,
    required this.mavertirAvant,
    required this.observation,
  });

  factory Entretien.fromJson(Map<String, dynamic> json) => Entretien(
        id: json["id"],
        vehiculeId: json["vehicule_id"],
        operation: json["operation"],
        frais: double.parse(json["frais"].toString()),
        fhuile: json["fhuile"],
        fair: json["fair"],
        fcarburant: json["fcarburant"],
        date: json["date"],
        kmM: json["km_m"],
        kmP: json["km_p"],
        montants: double.parse(json["montants"].toString()),
        mavertirAvant: json["mavertir_avant"],
        observation: json["observation"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "vehicule_id": vehiculeId,
        "operation": operation,
        "frais": frais,
        "fhuile": fhuile,
        "fair": fair,
        "fcarburant": fcarburant,
        "date": date,
        "km_m": kmM,
        "km_p": kmP,
        "montants": montants,
        "mavertir_avant": mavertirAvant,
        "observation": observation,
      };
}
