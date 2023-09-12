// To parse this JSON data, do
//
//     final vehicule = vehiculeFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

Vehicule vehiculeFromJson(String str) => Vehicule.fromJson(json.decode(str));

String vehiculeToJson(Vehicule data) => json.encode(data.toJson());

class Vehicule {
    int id;
    int idFournisseur;
    String marque;
    String modele;
    int annee;
    int kilometrage;
    String statut;
    String numChassis;
    String carteGrise;
    int puissance;
    int nombreCylindre;
    String typeCarburant;
    String gamme;
    String categorie;
    String vin;

    Vehicule({
        required this.id,
        required this.idFournisseur,
        required this.marque,
        required this.modele,
        required this.annee,
        required this.kilometrage,
        required this.statut,
        required this.numChassis,
        required this.carteGrise,
        required this.puissance,
        required this.nombreCylindre,
        required this.typeCarburant,
        required this.gamme,
        required this.categorie,
        required this.vin,
    });

    Vehicule copyWith({
        int? id,
        int? idFournisseur,
        String? marque,
        String? modele,
        int? annee,
        int? kilometrage,
        String? statut,
        String? numChassis,
        String? carteGrise,
        int? puissance,
        int? nombreCylindre,
        String? typeCarburant,
        String? gamme,
        String? categorie,
        String? vin,
    }) => 
        Vehicule(
            id: id ?? this.id,
            idFournisseur: idFournisseur ?? this.idFournisseur,
            marque: marque ?? this.marque,
            modele: modele ?? this.modele,
            annee: annee ?? this.annee,
            kilometrage: kilometrage ?? this.kilometrage,
            statut: statut ?? this.statut,
            numChassis: numChassis ?? this.numChassis,
            carteGrise: carteGrise ?? this.carteGrise,
            puissance: puissance ?? this.puissance,
            nombreCylindre: nombreCylindre ?? this.nombreCylindre,
            typeCarburant: typeCarburant ?? this.typeCarburant,
            gamme: gamme ?? this.gamme,
            categorie: categorie ?? this.categorie,
            vin: vin ?? this.vin,
        );

    factory Vehicule.fromJson(Map<String, dynamic> json) => Vehicule(
        id: json["id"],
        idFournisseur: json["id_fournisseur"],
        marque: json["marque"],
        modele: json["modele"],
        annee: json["annee"],
        kilometrage: json["kilometrage"],
        statut: json["statut"],
        numChassis: json["num_chassis"],
        carteGrise: json["carte_grise"],
        puissance: json["puissance"],
        nombreCylindre: json["nombre_cylindre"],
        typeCarburant: json["type_carburant"],
        gamme: json["gamme"],
        categorie: json["categorie"],
        vin: json["VIN"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "id_fournisseur": idFournisseur,
        "marque": marque,
        "modele": modele,
        "annee": annee,
        "kilometrage": kilometrage,
        "statut": statut,
        "num_chassis": numChassis,
        "carte_grise": carteGrise,
        "puissance": puissance,
        "nombre_cylindre": nombreCylindre,
        "type_carburant": typeCarburant,
        "gamme": gamme,
        "categorie": categorie,
        "VIN": vin,
    };
}
