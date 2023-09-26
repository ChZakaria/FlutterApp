import 'package:cr_calendar/cr_calendar.dart';
import 'package:flutter/material.dart';
import 'package:my_web_project/widgets/day_item_widget.dart';
import 'package:my_web_project/widgets/event_widget.dart';
import 'package:my_web_project/widgets/week_days_widget.dart';
import '../../api/apiService.dart' as client;


class ReservationsList extends StatefulWidget {
  const ReservationsList({super.key});

  @override
  State<ReservationsList> createState() => _ReservationsListState();
}

class _ReservationsListState extends State<ReservationsList> {

   final eventColors = [
  Color(0xff82D964),
  Color(0xffE665FD),
  Color(0xffF7980B),
  Color(0xfff2d232),
  Color(0xffFC6054),
  Color(0xffBEBEBE),
];

   List<Map<String, dynamic>> reservationsList = [];
  List<Map<String, dynamic>> displayedReservations = [];

  late CrCalendarController _calendarController;
  final _currentDate = DateTime.now();

  @override
  void initState() {
    // TODO: implement initState
        _createExampleEvents();

    super.initState();


    // client.ApiService.makeApiRequest(
    //   'contrats',
    //   'GET',
    //   null,
    // ).then((value) {
    //   dynamic responseMap = value;

    //   var reservationsData = responseMap["contrats"];
      

    //   for (var reservationJson in reservationsData) {
        
        
    //     reservationsList.add(reservationJson);
    //   }
    //   setState(() {
    //     displayedReservations = List.from(reservationsList);
    //   });
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CrCalendar(
       firstDayOfWeek: WeekDay.monday,
              eventsTopPadding: 32,
              initialDate: _currentDate,
              maxEventLines: 3,
              controller: _calendarController,
              forceSixWeek: true,
              dayItemBuilder: (builderArgument) =>
                  DayItemWidget(properties: builderArgument),
              weekDaysBuilder: (day) => WeekDaysWidget(day: day),
              eventBuilder: (drawer) => EventWidget(drawer: drawer),
             
              minDate: DateTime.now().subtract(const Duration(days: 1000)),
              maxDate: DateTime.now().add(const Duration(days: 180)),
      ),
    );
  }

  


  void _createExampleEvents() {
    final now = _currentDate;
    _calendarController = CrCalendarController(
      
      events: [
        CalendarEventModel(
          name: '1 event',
          begin: DateTime(now.year, now.month - 1, (now.day - 2).clamp(1, 28)),
          end: DateTime(now.year, now.month, (now.day).clamp(1, 28)),
          eventColor: eventColors[0],
        ),
        CalendarEventModel(
          name: '2 event',
          begin: DateTime(now.year, now.month - 1, (now.day - 2).clamp(1, 28)),
          end: DateTime(now.year, now.month, (now.day + 2).clamp(1, 28)),
          eventColor: eventColors[1],
        ),
        CalendarEventModel(
          name: '3 event',
          begin: DateTime(now.year, now.month, (now.day - 3).clamp(1, 28)),
          end: DateTime(now.year, now.month + 1, (now.day + 4).clamp(1, 28)),
          eventColor: eventColors[2],
        ),
        CalendarEventModel(
          name: '4 event',
          begin: DateTime(now.year, now.month - 1, (now.day).clamp(1, 28)),
          end: DateTime(now.year, now.month + 1, (now.day + 5).clamp(1, 28)),
          eventColor: eventColors[3],
        ),
        CalendarEventModel(
          name: '5 event',
          begin: DateTime(now.year, now.month + 1, (now.day + 1).clamp(1, 28)),
          end: DateTime(now.year, now.month + 2, (now.day + 7).clamp(1, 28)),
          eventColor: eventColors[4],
        ),
      ],
    );
  }
}
