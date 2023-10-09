import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:my_web_project/models/reservation.dart';
import 'package:my_web_project/pages/dashboard.dart';
import 'package:my_web_project/widgets/reservation_ticket.dart';
import 'package:table_calendar/table_calendar.dart';
import '../api/apiService.dart' as client;
import 'package:easy_sidemenu/easy_sidemenu.dart';
import 'package:my_web_project/routes/route.dart' as route;
import '../api/reservationsClient.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<dynamic> reservations = [];
  List<Map<String, dynamic>> expiredContracts = [];
  List<dynamic> maintenences = [];
  List<dynamic> chargeEndDates = [];

  List<dynamic> vehiclesInPark = [];
  List<dynamic> vehiclesOutOfPark = [];

  SideMenuController sideMenu = SideMenuController();
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  var listOfButtons = [
    {
      "icon": Icons.calendar_month_outlined,
      "color": Colors.purpleAccent,
      "name": "Reservations",
      "route": route.reservationsListPage
    },
    {
      "icon": Icons.person,
      "color": Colors.red,
      "name": "Locataires",
      "route": route.locatairesListPage
    },
    {
      "icon": Icons.description_outlined,
      "color": Colors.lightGreen,
      "name": "Contrats",
      "route": route.contratsListPage
    },
    {
      "icon": Icons.car_repair_outlined,
      "color": Colors.pink,
      "name": "Entretiens",
      "route": route.entretiensListPage
    },
    {
      "icon": Icons.factory_outlined,
      "color": Colors.limeAccent,
      "name": "Fournisseurs",
      "route": route.fournisseursListPage
    },
    {
      "icon": Icons.support_agent,
      "color": Colors.indigo,
      "name": "Intermidiaires",
      "route": route.intermidiairesListPage
    },
    {
      "icon": Icons.receipt,
      "color": Colors.lightBlue,
      "name": "Regelements",
      "route": route.regelementsListPage
    },
    {
      "icon": Icons.receipt_long_outlined,
      "color": Colors.deepPurpleAccent,
      "name": "Supplements",
      "route": route.supplementsListPage
    },
    {
      "icon": Icons.directions_car_filled_outlined,
      "color": Colors.orange,
      "name": "Vehicules",
      "route": route.vehiculeListPage
    },
    {
      "icon": Icons.receipt_outlined,
      "color": Colors.purple,
      "name": "Charges Fixes",
      "route": route.chargeFixesListPage
    },
  ];

  void pushToRoute(BuildContext context, routeName) {
    Navigator.pushNamed(
      context,
      routeName,
    );
  }

  late List<SideMenuItem> items;

  _generateListOfNotif() {
    listOfNotificationsType = [
      {
        "color": Color(0xfffeca57),
        "title": "chargeEndDates",
        "count": chargeEndDates.length,
        "onPressed": () {
          showCustomDialog(
              context, _buildCard('chargeEndDates', chargeEndDates));
        }
      },
      {
        "color": Color(0xffff6b6b),
        "title": "expiredContracts",
        "count": expiredContracts.length,
        "onPressed": () {
          showCustomDialog(
              context, _buildCard('Expired Contracts', expiredContracts));
        }
      },
      {
        "color": Color(0xff1dd1a1),
        "title": "maintenences",
        "count": maintenences.length,
        "onPressed": () {
          showCustomDialog(context, _buildCard('Maintenences', maintenences));
        }
      },
      {
        "color": Color(0xff00d2d3),
        "title": "Facteurs",
        "count": reservations.length,
        "onPressed": () {
          showCustomDialog(context, _buildCard('Charge Fixes', reservations));
        }
      },
    ];
  }

  _generateSideMenu() {
    items = listOfButtons.map((e) {
      return SideMenuItem(
        title: e["name"].toString(),
        onTap: (index, _) {
          pushToRoute(context, e["route"]);
        },
        icon: Icon(e["icon"] as IconData),
      );
    }).toList();
  }

  late final ValueNotifier<List<Reservation>> _selectedEvents;

  @override
  void initState() {
    super.initState();
    fetchData();

    fetchParkData();

    _generateSideMenu();
    //_generateListOfNotif();
    _selectedDay = _focusedDay;
    _selectedEvents = ValueNotifier(_getEventsForDay(_selectedDay!));
  }

  @override
  void dispose() {
    _selectedEvents.dispose();
    super.dispose();
  }

  List<Reservation> _getEventsForDay(DateTime day) {
    // Implementation example
    return kEvents[day] ?? [];
  }

  List<Reservation> _getEventsForRange(DateTime start, DateTime end) {
    // Implementation example
    final days = daysInRange(start, end);

    return [
      for (final d in days) ..._getEventsForDay(d),
    ];
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    if (!isSameDay(_selectedDay, selectedDay)) {
      setState(() {
        _selectedDay = selectedDay;
        _focusedDay = focusedDay;
      });

      _selectedEvents.value = _getEventsForDay(selectedDay);
    }
  }

  Future<void> fetchData() async {
    client.ApiService.makeApiRequest(
      'centralized-data',
      'GET',
      null,
    ).then((value) {
      var data = value["notifications"];

      print(data);

      setState(() {
        expiredContracts = List.from(data["expiredContracts"]);
        reservations = data["reservations"];
        maintenences = data["maintenances"];
        chargeEndDates = data["chargeEndDates"];
      });
    });
  }

  Future<void> fetchParkData() async {
    client.ApiService.makeApiRequest(
      'getParkStatus',
      'GET',
      null,
    ).then((value) {
      setState(() {
        vehiclesInPark = value['vehicles_in_park'];
        vehiclesOutOfPark = value['vehicles_out_of_park'];
      });
    });
  }

  Widget _buildCard(String title, data) {
    var message = title == "Charge Fixes"
        ? "Charge doit etre regle "
        : (title == "Maintenences"
            ? "cette voiture a besoin de reparation"
            : (title == "chargeEndDates"
                ? "y'a des charges qui seront expirees"
                : "Cette Contrat est epuise"));
    //var _data = data.take(5);// to change
    var _data = data;
    return Container(
      decoration:
          BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(10))),
      width: MediaQuery.sizeOf(context).width >= 1000
          ? MediaQuery.sizeOf(context).width * .3
          : MediaQuery.sizeOf(context).width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              title,
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: _data.isEmpty
                ? Text('Empty', style: TextStyle(color: Colors.black45))
                : Wrap(
                    alignment: WrapAlignment.center,
                    children: [
                      for (var item in _data)
                        Container(
                          margin: const EdgeInsets.symmetric(
                            horizontal: 4,
                            vertical: 4.0,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.amber[100],
                            // border: Border.all(),
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          child: ListTile(
                            onTap: () =>
                                print('${item is Map ? item['id'] : item}'),
                            leading: Icon(
                              Icons.pending_actions,
                              color: const Color.fromARGB(255, 64, 0, 255),
                            ),
                            title: Text(
                                '$message ${item is Map ? item['id'] : item} ',
                                style: TextStyle(fontSize: 10)),
                          ),
                        )
                    ],
                  ),
          ),
        ],
      ),
    );
  }

  Widget _notificationCard(String title, data) {
    return Card(
      color: Colors.white, // Change the color as needed
      elevation: 5,
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(10))),
        width: MediaQuery.sizeOf(context).width >= 1000
            ? MediaQuery.sizeOf(context).width * .5
            : MediaQuery.sizeOf(context).width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
            Divider(color: Colors.grey[50]), // This creates a horizontal line

            /*---------------- */

           // Park notification
            /*---------------- */

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Card(
                      color: Color(0xff1dd1a1),
                      child: Container(
                        height: 100,
                        width: 100,
                        child: Center(
                          child: Text(
                            ' ${vehiclesInPark.length}',
                            style: TextStyle(color: Colors.white, fontSize: 40),
                          ),
                        ),
                      ),
                    ),
                    Text("Vehicules disponible")
                  ],
                ),
                SizedBox(width: 30,),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Card(
                      color: Color(0xffff6b6b),
                      child: Container(
                        height: 100,
                        width: 100,
                        child: Center(
                          child: Text(
                            '${vehiclesOutOfPark.length}',
                            style: TextStyle(color: Colors.white, fontSize: 40),
                          ),
                        ),
                      ),
                    ),
                    Text("Vehicules louee")
                  ],
                ),
              ],
            ),

              /*---------------- */

           // Park notification
            /*---------------- */
            Padding(
                padding: EdgeInsets.all(8.0),
                child: Wrap(
                  alignment: WrapAlignment.center,
                  children: listOfNotificationsType
                      .map((e) => Container(
                            margin: EdgeInsets.all(2),
                            padding: EdgeInsets.all(5),
                            height: 70,
                            width: 300,
                            decoration: BoxDecoration(
                                color: e["color"] as Color,
                                borderRadius: BorderRadius.circular(4)),
                            child: InkWell(
                              onTap: e["onPressed"],
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    e["count"].toString(),
                                    style: TextStyle(
                                        fontSize: 30,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                  Text(
                                    e["title"].toString(),
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  Icon(
                                    Icons.arrow_forward_outlined,
                                    color: Colors.white,
                                  )
                                ],
                              ),
                            ),
                          ))
                      .toList(),
                )),
          ],
        ),
      ),
    );
  }

  showCustomDialog(BuildContext context, widget) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Container(
            width: MediaQuery.sizeOf(context).width *
                0.6, // Set the width of the container
            height: MediaQuery.sizeOf(context).height *
                0.7, // Set the height of the container
            // Set the color of the container
            child: Center(
              child: SingleChildScrollView(
                child: widget,
              ),
            ),
          ),
          actions: <Widget>[
            ElevatedButton(
              child: Text('Fermer'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  var listOfNotificationsType = [];

  _rightSideContainer() {
    return Container(
      width: MediaQuery.sizeOf(context).width >= 1000
          ? MediaQuery.sizeOf(context).width * .3
          : MediaQuery.sizeOf(context).width,
      decoration: BoxDecoration(color: Colors.blue[100]),
      child: Column(
        children: [
          TableCalendar<Reservation>(
            firstDay: kFirstDay,
            lastDay: kLastDay,
            focusedDay: _focusedDay,
            selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
            eventLoader: _getEventsForDay,
            startingDayOfWeek: StartingDayOfWeek.monday,
            calendarBuilders: CalendarBuilders(
              markerBuilder: (
                context,
                date,
                events,
              ) {
                // Check the reservation state and return markers accordingly
                List<Widget> markers = [];

                for (var event in events) {
                  if (event.statut == "done") {
                    markers.add(
                      Icon(
                        Icons.check_circle,
                        size: 10.0,
                        color: Colors.green,
                      ),
                    );
                  } else if (event.statut == "pending") {
                    markers.add(
                      Icon(
                        Icons.pending,
                        size: 10.0,
                        color: Colors.orange,
                      ),
                    );
                  }
                }

                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: markers,
                );
              },
            ),
            calendarStyle: const CalendarStyle(
              // Use `CalendarStyle` to customize the UI
              outsideDaysVisible: false,
              markerDecoration: BoxDecoration(
                color: Color.fromARGB(255, 89, 8, 152),
                shape: BoxShape.circle,
              ),
            ),
            onDaySelected: _onDaySelected,
            onPageChanged: (focusedDay) {
              _focusedDay = focusedDay;
            },
          ),
          Container(
            height: MediaQuery.sizeOf(context).height,
            width: MediaQuery.sizeOf(context).width >= 1000
                ? MediaQuery.sizeOf(context).width * .3
                : MediaQuery.sizeOf(context).width,
            child: ValueListenableBuilder<List<Reservation>>(
              valueListenable: _selectedEvents,
              builder: (context, value, _) {
                return Column(
                    children: value.map(
                  (e) {
                    return ReservationTicket(
                      color: e.statut == "done"
                          ? Colors.green[200]
                          : Colors.amber[100],
                      child: Container(
                        margin: const EdgeInsets.symmetric(
                          horizontal: 12.0,
                          vertical: 4.0,
                        ),
                        decoration: BoxDecoration(
                          // border: Border.all(),
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        child: GestureDetector(
                          onTap: () => print('${e.id}'),
                          child: Stack(
                            children: [
                              e.statut == "pending"
                                  ? Align(
                                      alignment: Alignment.center,
                                      child: Icon(
                                        Icons.pending_actions,
                                        color: Colors.orange,
                                      ),
                                    )
                                  : Align(
                                      alignment: Alignment.center,
                                      child: Icon(
                                        Icons.done_all,
                                        color: Colors.green,
                                      ),
                                    ),
                              Align(
                                alignment: Alignment.topCenter,
                                child: Text(
                                    ' ${e.dateDebut.month}/${e.dateDebut.day} •••••• ${e.dateFin.month}/${e.dateFin.day}'),
                              ),
                              Align(
                                alignment: Alignment.bottomCenter,
                                child: Text(
                                    'Locataire: ${e.locataireId} Pour ${e.vehiculeId}'),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ).toList());
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    _generateListOfNotif();

    return Scaffold(
      backgroundColor: Colors.purple[50],
      body: Row(children: [
        SideMenu(
          // Page controller to manage a PageView
          controller: sideMenu,
          // Will shows on top of all items, it can be a logo or a Title text
          title: Padding(
              padding: EdgeInsets.all(10),
              child: Center(child: Text("CarRental"))),
          // Will show on bottom of SideMenu when displayMode was SideMenuDisplayMode.open
          footer: Text('Made By'),
          // Notify when display mode changed
          onDisplayModeChanged: (mode) {
            print(mode);
          },
          // List of SideMenuItem to show them on SideMenu
          items: items,

          style: SideMenuStyle(
              displayMode: SideMenuDisplayMode.open,
              decoration: BoxDecoration(),
              openSideMenuWidth: 200,
              compactSideMenuWidth: 80,
              hoverColor: Colors.purple[100],
              selectedColor: Colors.purple[100],
              selectedIconColor: Colors.black,
              unselectedIconColor: Colors.white,
              backgroundColor: Colors.deepPurple,
              selectedTitleTextStyle: TextStyle(color: Colors.black),
              unselectedTitleTextStyle: TextStyle(color: Colors.white),
              iconSize: 20,
              itemBorderRadius: const BorderRadius.all(
                Radius.circular(5.0),
              ),
              showTooltip: true,
              itemHeight: 50.0,
              itemInnerSpacing: 8.0,
              itemOuterPadding: const EdgeInsets.symmetric(horizontal: 5.0),
              toggleColor: Colors.black54),
        ),
        Expanded(
          child: expiredContracts.isEmpty
              ? CircularProgressIndicator()
              : ScrollConfiguration(
                  behavior: ScrollConfiguration.of(context)
                      .copyWith(scrollbars: false),
                  child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Wrap(
                        direction: Axis.horizontal,
                        alignment: WrapAlignment.spaceBetween,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Dashboard(),
                              _notificationCard("Notifications", reservations),
                              Container(
                                width: MediaQuery.sizeOf(context).width * 0.5,
                                child: Wrap(
                                  alignment: WrapAlignment.start,
                                  spacing: 4.0,
                                  runSpacing: 4.0,
                                  children: [
                                    //_buildCard('Reservations', reservations),
                                    _buildCard('Contracts', expiredContracts),
                                    // _buildCard('Maintenances', maintenences),
                                    // _buildCard('Charges Ended', chargeEndDates),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          _rightSideContainer(),
                        ],
                      )),
                ),
        )
      ]),
    );
  }
}
