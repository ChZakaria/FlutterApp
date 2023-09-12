
import 'package:flutter/material.dart';
import 'api/apiService.dart' as client;
import 'package:shared_preferences/shared_preferences.dart';

import 'models/locataire.dart';

class Dashboard extends StatefulWidget {
  Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  var _response = '';
  List<Locataire> locatairesList = [];

  String? myVar;
  bool loading = false;

  getFromShared() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var myCounter = await prefs.getString('token');
    setState(() {
      myVar = myCounter;
    });
  }

  @override
  void initState() {
    super.initState();
    getFromShared();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () {
                setState(() {
                  loading = true;
                });
                client.ApiService.makeApiRequest(
                  'locataires',
                  'GET',
                  null,
                ).then((value) {
                  final responseMap = value;
                  var locatairesData = responseMap["locataires"];
                  // Create a list of Locataire objects
                  List<Locataire> locataires = [];

                  for (var locataireJson in locatairesData) {
                    Locataire locataire = Locataire.fromJson(locataireJson);
                    locataires.add(locataire);
                  }

                  // Now, you have a list of Locataire objects
                  setState(() {
                    loading = false;
                    locatairesList = locataires; // Update the state
                  });
                  print(locatairesData);
                });
              },
              child: Text('Login'),
            ),
            loading == true ? Text("loading...") : SizedBox(),

            // Display the list of Locataire objects using ListView.builder
            Expanded(
              child: ListView.builder(
                itemCount: locatairesList.length,
                itemBuilder: (context, index) {
                  final locataire = locatairesList[index];
                  return ListTile(
                    title: Text('Name: ${locataire.nom}'),
                    subtitle: Text('Adresse: ${locataire.adresse}'),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
