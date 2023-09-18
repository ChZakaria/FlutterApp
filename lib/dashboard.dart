import 'package:flutter/material.dart';
import 'package:my_web_project/chargeFixesList.dart';
import 'package:my_web_project/contratsList.dart';
import 'package:my_web_project/fournisseursList.dart';
import 'package:my_web_project/intermediairesList.dart';
import 'package:my_web_project/locatairesList.dart';
import 'package:my_web_project/reglementsList.dart';
import 'package:my_web_project/vehiculeList.dart';
import 'package:my_web_project/supplementsList.dart';
import 'package:my_web_project/entretienList.dart';

class Dashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard'),
      ),
      body: Center(
        child: Container(
          width: 1200,
          child: GridView.count(
            crossAxisCount: 5, // Adjust the number of columns as needed
            padding: EdgeInsets.all(16.0),
            mainAxisSpacing: 16.0,
            crossAxisSpacing: 16.0,
            childAspectRatio: 1.0, // Adjust the aspect ratio as needed
            children: [
              ElevatedButton(
                onPressed: () {
                  // Handle reservations button press
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.blue,
                  padding: EdgeInsets.all(8.0), // Smaller padding
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  elevation: 5, // Add elevation
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.calendar_today,
                      size: 32.0,
                      color: Colors.white, // Text and icon color
                    ), // Smaller icon
                    SizedBox(height: 4.0), // Smaller gap
                    Text(
                      'Reservations',
                      style: TextStyle(
                        fontSize: 14.0,
                        color: Colors.white, // Text color
                      ),
                    ), // Smaller text
                  ],
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  // Handle locataires button press
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LocatairesList()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.green,
                  padding: EdgeInsets.all(8.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  elevation: 5,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.person,
                      size: 32.0,
                      color: Colors.white,
                    ),
                    SizedBox(height: 4.0),
                    Text(
                      'Locataires',
                      style: TextStyle(
                        fontSize: 14.0,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  // Handle contrats button press
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ContratList()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.orange,
                  padding: EdgeInsets.all(8.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  elevation: 5,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.description,
                      size: 32.0,
                      color: Colors.white,
                    ),
                    SizedBox(height: 4.0),
                    Text(
                      'Contrats',
                      style: TextStyle(
                        fontSize: 14.0,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  // Handle vehicules button press
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => VehiculeList()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.red,
                  padding: EdgeInsets.all(8.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  elevation: 5,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.directions_car,
                      size: 32.0,
                      color: Colors.white,
                    ),
                    SizedBox(height: 4.0),
                    Text(
                      'Vehicules',
                      style: TextStyle(
                        fontSize: 14.0,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  // Handle reglements button press
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ReglementsList()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.purple,
                  padding: EdgeInsets.all(8.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  elevation: 5,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.payment,
                      size: 32.0,
                      color: Colors.white,
                    ),
                    SizedBox(height: 4.0),
                    Text(
                      'Reglements',
                      style: TextStyle(
                        fontSize: 14.0,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  // Handle charge_fixes button press
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ChargesFixesList()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.yellow,
                  padding: EdgeInsets.all(8.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  elevation: 5,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.attach_money,
                      size: 32.0,
                      color: Colors.white,
                    ),
                    SizedBox(height: 4.0),
                    Text(
                      'Charge Fixes',
                      style: TextStyle(
                        fontSize: 14.0,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  // Handle fournisseurs button press
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => FournisseurList()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.teal,
                  padding: EdgeInsets.all(8.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  elevation: 5,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.business,
                      size: 32.0,
                      color: Colors.white,
                    ),
                    SizedBox(height: 4.0),
                    Text(
                      'Fournisseurs',
                      style: TextStyle(
                        fontSize: 14.0,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  // Handle intermediaires button press
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => IntermediairesList()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.indigo,
                  padding: EdgeInsets.all(8.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  elevation: 5,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.people,
                      size: 32.0,
                      color: Colors.white,
                    ),
                    SizedBox(height: 4.0),
                    Text(
                      'Intermediaires',
                      style: TextStyle(
                        fontSize: 14.0,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  // Handle supplements button press
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SupplementList()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.amber,
                  padding: EdgeInsets.all(8.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  elevation: 5,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.settings,
                      size: 32.0,
                      color: Colors.white,
                    ),
                    SizedBox(height: 4.0),
                    Text(
                      'Supplements',
                      style: TextStyle(
                        fontSize: 14.0,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  // Handle entretien button press
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => EntretienList()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.cyan,
                  padding: EdgeInsets.all(8.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  elevation: 5,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.add,
                      size: 32.0,
                      color: Colors.white,
                    ),
                    SizedBox(height: 4.0),
                    Text(
                      'Entretien',
                      style: TextStyle(
                        fontSize: 14.0,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
