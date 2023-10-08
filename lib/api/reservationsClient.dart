
import 'dart:collection';

import 'package:my_web_project/models/reservation.dart';
import 'package:table_calendar/table_calendar.dart';

/// Example events.
///
/// Using a [LinkedHashMap] is highly recommended if you decide to use a map.
final kEvents = LinkedHashMap<DateTime, List<Reservation>>(
  equals: isSameDay,
  hashCode: getHashCode,
)..addAll(_kEventSource);

final _kEventSource = Map.fromIterable(List.generate(50, (index) => index),
    key: (item) => DateTime.utc(kFirstDay.year, kFirstDay.month, item * 5),
    value: (item) => List.generate(
          item % 4 + 1,
          (index) => Reservation(
              id: index,
              vehiculeId: 2,
              locataireId: 1,
              dateDebut: DateTime.now().add(Duration(days: 0)),
              dateFin: DateTime.now().add(Duration(days: index)),
              statut: index.isEven ? "pending" : "done"),
        ))
  ..addAll({
    kToday: [
      Reservation(
          id: 1,
          vehiculeId: 2,
          locataireId: 1,
          dateDebut: DateTime.now().add(Duration(days: 0)),
          dateFin: DateTime.now().add(Duration(days: 7)),
          statut: "pending"),
      Reservation(
          id: 1,
          vehiculeId: 2,
          locataireId: 1,
          dateDebut: DateTime.now().add(Duration(days: 0)),
          dateFin: DateTime.now().add(Duration(days: 7)),
          statut: "pending"),
    ],
  });
// final _kEventSource=[
// Reservation(id: 1, vehiculeId: 2, locataireId: 1,dateDebut: DateTime.now().add(Duration(days: 0)),dateFin: DateTime.now().add(Duration(days: 7)),statut: "pending"),
// Reservation(id: 2, vehiculeId: 1, locataireId: 5,dateDebut: DateTime.now().add(Duration(days: 0)),dateFin: DateTime.now().add(Duration(days: 7)),statut: "pending"),
// Reservation(id: 3, vehiculeId: 1, locataireId: 6,dateDebut: DateTime.now().add(Duration(days: 3)),dateFin: DateTime.now().add(Duration(days: 9)),statut: "pending"),
// Reservation(id: 4, vehiculeId: 3, locataireId: 1,dateDebut: DateTime.now().add(Duration(days: 0)),dateFin: DateTime.now().add(Duration(days: 10)),statut: "done"),
// Reservation(id: 5, vehiculeId: 1, locataireId: 7,dateDebut: DateTime.now().add(Duration(days: 0)),dateFin: DateTime.now().add(Duration(days: 11)),statut: "pending"),
// Reservation(id: 6, vehiculeId: 1, locataireId: 1,dateDebut: DateTime.now().add(Duration(days: 3)),dateFin: DateTime.now().add(Duration(days: 30)),statut: "pending"),
// Reservation(id: 7, vehiculeId: 4, locataireId: 8,dateDebut: DateTime.now().add(Duration(days: 4)),dateFin: DateTime.now().add(Duration(days: 31)),statut: "done"),
// Reservation(id: 8, vehiculeId: 1, locataireId: 1,dateDebut: DateTime.now().add(Duration(days: 4)),dateFin: DateTime.now().add(Duration(days: 12)),statut: "pending"),
// Reservation(id: 9, vehiculeId: 1, locataireId: 8,dateDebut: DateTime.now().add(Duration(days: 4)),dateFin: DateTime.now().add(Duration(days: 14)),statut: "canceled"),
// Reservation(id: 10, vehiculeId: 1, locataireId: 1,dateDebut: DateTime.now().add(Duration(days: 6)),dateFin: DateTime.now().add(Duration(days: 16)),statut: "pending"),

// ];

int getHashCode(DateTime key) {
  return key.day * 1000000 + key.month * 10000 + key.year;
}

/// Returns a list of [DateTime] objects from [first] to [last], inclusive.
List<DateTime> daysInRange(DateTime first, DateTime last) {
  final dayCount = last.difference(first).inDays + 1;
  return List.generate(
    dayCount,
    (index) => DateTime.utc(first.year, first.month, first.day + index),
  );
}

final kToday = DateTime.now();
final kFirstDay = DateTime(kToday.year, kToday.month - 3, kToday.day);
final kLastDay = DateTime(kToday.year, kToday.month + 3, kToday.day);