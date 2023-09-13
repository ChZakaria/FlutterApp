
class Fournisseur {
  final int id;
  final String nom;
  final String email;
  final String telephone;
  final String adresse;

  Fournisseur({required this.id, required this.nom, required this.email, required this.telephone, required this.adresse});

  factory Fournisseur.fromJson(Map<String, dynamic> json) {
    return Fournisseur(
      id: json['id'],
      nom: json['nom'],
      email: json['email'],
      telephone: json['telephone'],
      adresse: json['adresse'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nom': nom,
      'email': email,
      'telephone': telephone,
      'adresse': adresse,
    };
  }
}