import 'package:flutter/material.dart';

import 'package:my_web_project/routes/route.dart' as route;

class Dashboard extends StatelessWidget {
  //
  //

  // use this to push to name route defined in route file
  pushToRoute(BuildContext context, routeName) {
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
      "route": route.chargeFixesListPage
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

  // method returns Elevated button to avoid repetitive code

  ElevatedButton _gridButton(icon, color, name, route, context) {
    return ElevatedButton(
      onPressed: () {
        // Handle  button press
        pushToRoute(context, route);
      },
      style: ElevatedButton.styleFrom(
        
        backgroundColor: color,
        padding: const EdgeInsets.all(8.0), // Smaller padding
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        elevation: 5, // Add elevation
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 15.0,
            color: Colors.white, // Text and icon color
          ), // Smaller icon
          const SizedBox(height: 4.0), // Smaller gap
          Text(
            name,
            style: TextStyle(
              fontSize: 10.0,
              color: Colors.white, // Text color
            ),
          ), // Smaller text
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
          width: double.infinity,
          child: GridView.count(
            shrinkWrap: true,
            crossAxisCount: 5, // Adjust the number of columns as needed
            padding: EdgeInsets.all(5.0),
            mainAxisSpacing: 4.0,
            crossAxisSpacing: 4.0,
            childAspectRatio: 3, // Adjust the aspect ratio as needed
            children: [
              ...listOfButtons.map((e) => _gridButton(
                  e["icon"], e["color"], e["name"], e["route"], context))
            ],
          ),);
        
      
  }
}
