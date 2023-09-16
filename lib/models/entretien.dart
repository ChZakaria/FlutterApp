class Entretien {
  final int id;
  final int vehiculeId;
  final String operation;
  final String frais;
  final DateTime date;
  final int kmM;
  final int kmP;
  final double montants;
  final int mavertirAvant;
  final String observation;

  Entretien({
    required this.id,
    required this.vehiculeId,
    required this.operation,
    required this.frais,
    required this.date,
    required this.kmM,
    required this.kmP,
    required this.montants,
    required this.mavertirAvant,
    required this.observation,
  });

  factory Entretien.fromJson(Map<String, dynamic> json) {
    return Entretien(
      id: json['id'],
      vehiculeId: json['vehicule_id'],
      operation: json['operation'],
      frais: json['frais'],
      date: DateTime.parse(json['date']),
      kmM: json['km_m'],
      kmP: json['km_p'],
      montants: json['montants'],
      mavertirAvant: json['mavertir_avant'],
      observation: json['observation'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'vehicule_id': vehiculeId,
      'operation': operation,
      'frais': frais,
      'date': date.toIso8601String(),
      'km_m': kmM,
      'km_p': kmP,
      'montants': montants,
      'mavertir_avant': mavertirAvant,
      'observation': observation,
    };
  }
}
