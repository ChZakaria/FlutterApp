
import 'package:flutter/material.dart';
import 'package:my_web_project/pages/dashboard.dart';
import '../api/apiService.dart' as client;



class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  

  List<dynamic> reservations = [];
  List<Map<String, dynamic>> expiredContracts = [];
  List< dynamic> maintenences = [];
  List< dynamic> chargeEndDates = [];

  @override
  void initState() {
    super.initState();
    fetchData();
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
          expiredContracts= List.from(data["expiredContracts"]);
          reservations=data["reservations"];
          maintenences=data["maintenances"];
          chargeEndDates=data["chargeEndDates"];
        });

      // setState(() {
      //   data = value;
      // });

      // print(data);
   
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Centralized Data App'),
      ),
      body: Center(
        child: expiredContracts.isEmpty
            ? CircularProgressIndicator()
            : SingleChildScrollView(
              child: Column(
                children: [
                  Dashboard(),
                  ListTile(
                    title: Text('Reservations'),
                    subtitle: reservations.isEmpty
                        ? Text('Empty')
                        : Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              for (var reservation in reservations)
                                Text('ID: ${reservation}'),
                            ],
                          ),
                  ),
                  ListTile(
                    title: Text('Contracts'),
                    subtitle: expiredContracts.isEmpty
                        ? Text('Empty')
                        : Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              for (var contract in expiredContracts)
                                Text('ID: ${contract['id']}'),
                            ],
                          ),
                  ),
                  ListTile(
                    title: Text('Maintenances'),
                    subtitle: maintenences.isEmpty
                        ? Text('Empty')
                        : Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              for (var maintenance in maintenences)
                                Text('ID: ${maintenance}'),
                            ],
                          ),
                  ),
                  ListTile(
                    title: Text('Charges Ended'),
                    subtitle: chargeEndDates.isEmpty
                        ? Text('Empty')
                        : Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              for (var charge in chargeEndDates)
                                Text('ID: ${charge['id']}'),
                            ],
                          ),
                  ),]
              ),
            ),
      ),
    );
  }
}