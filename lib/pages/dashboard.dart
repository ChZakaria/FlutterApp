import 'package:flutter/material.dart';
import 'package:my_web_project/routes/route.dart' as route;

class Dashboard extends StatelessWidget {
  void pushToRoute(BuildContext context, routeName) {
    Navigator.pushNamed(
      context,
      routeName,
    );
  }

  /*        ------- create a list of buttons to seed the GridView
            icon
            Color
            name
            route name
   */

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

  Container _gridButton(icon, color, name, route, context) {
    return Container(
      height: 60,
      width: 80,
      child: ElevatedButton(
        onPressed: () {
          pushToRoute(context, route);
        },
        style: ElevatedButton.styleFrom(
          
          backgroundColor: color,
          padding: const EdgeInsets.all(8.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          elevation: 5,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 15.0,
              color: Colors.white,
            ),
            const SizedBox(height: 4.0),
            Text(
              name,
              style: TextStyle(
                fontSize: 10.0,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      
      child:  Wrap(
        spacing: 4.0,
        runSpacing: 4.0,
        alignment: WrapAlignment.center,
        children: listOfButtons.map((e) => _gridButton(
          e["icon"], e["color"], e["name"], e["route"], context)).toList(),
      ),
    );
  }
}
