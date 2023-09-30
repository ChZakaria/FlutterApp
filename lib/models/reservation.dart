// To parse this JSON data, do
//
//     final reservation = reservationFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

Reservation reservationFromJson(String str) => Reservation.fromJson(json.decode(str));

String reservationToJson(Reservation data) => json.encode(data.toJson());

class Reservation {
    int id;
    int locataireId;
    int vehiculeId;
    DateTime dateDebut;
    DateTime dateFin;
    String statut;

    Reservation({
        required this.id,
        required this.locataireId,
        required this.vehiculeId,
        required this.dateDebut,
        required this.dateFin,
        required this.statut,
    });

    Reservation copyWith({
        int? id,
        int? locataireId,
        int? vehiculeId,
        DateTime? dateDebut,
        DateTime? dateFin,
        String? statut,
    }) => 
        Reservation(
            id: id ?? this.id,
            locataireId: locataireId ?? this.locataireId,
            vehiculeId: vehiculeId ?? this.vehiculeId,
            dateDebut: dateDebut ?? this.dateDebut,
            dateFin: dateFin ?? this.dateFin,
            statut: statut ?? this.statut,
        );

    factory Reservation.fromJson(Map<String, dynamic> json) => Reservation(
        id: json["id"],
        locataireId: json["locataire_id"],
        vehiculeId: json["vehicule_id"],
        dateDebut: DateTime.parse(json["date_debut"]),
        dateFin: DateTime.parse(json["date_fin"]),
        statut: json["statut"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "locataire_id": locataireId,
        "vehicule_id": vehiculeId,
        "date_debut": "${dateDebut.year.toString().padLeft(4, '0')}-${dateDebut.month.toString().padLeft(2, '0')}-${dateDebut.day.toString().padLeft(2, '0')}",
        "date_fin": "${dateFin.year.toString().padLeft(4, '0')}-${dateFin.month.toString().padLeft(2, '0')}-${dateFin.day.toString().padLeft(2, '0')}",
        "statut": statut,
    };
}
