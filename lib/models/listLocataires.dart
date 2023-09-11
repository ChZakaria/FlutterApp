// To parse this JSON data, do
//
//     final listLocataires = listLocatairesFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';
import 'locataire.dart';

ListLocataires listLocatairesFromJson(String str) =>
    ListLocataires.fromJson(json.decode(str));

String listLocatairesToJson(ListLocataires data) => json.encode(data.toJson());

class ListLocataires {
  List<Locataire> locataires;

  ListLocataires({
    required this.locataires,
  });

  ListLocataires copyWith({
    List<Locataire>? locataires,
  }) =>
      ListLocataires(
        locataires: locataires ?? this.locataires,
      );

  factory ListLocataires.fromJson(Map<String, dynamic> json) => ListLocataires(
        locataires: List<Locataire>.from(
            json["locataires"].map((x) => Locataire.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "locataires": List<dynamic>.from(locataires.map((x) => x.toJson())),
      };
}
