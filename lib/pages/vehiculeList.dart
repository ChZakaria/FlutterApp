import 'dart:convert';

import 'package:flutter/material.dart';
import '../../api/apiService.dart' as client;
import 'package:my_web_project/models/vehicule.dart';

class VehiculeList extends StatefulWidget {
  @override
  _VehiculeListState createState() => _VehiculeListState();
}

class _VehiculeListState extends State<VehiculeList> {
  List<Map<String, dynamic>> carList = [
    // ... your car data ...
  ];

  List<Map<String, dynamic>> displayedCars = [];

  TextEditingController searchController = TextEditingController();
  TextEditingController marqueController = TextEditingController();
  TextEditingController modeleController = TextEditingController();
  TextEditingController anneeController = TextEditingController();
  TextEditingController kilometrageController = TextEditingController();
  TextEditingController statutController = TextEditingController();
  TextEditingController numChassisController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _formKey2 = GlobalKey<FormState>();

  int? selectedIndex = -1;
  String? bearerToken;

  @override
  void initState() {
    super.initState();
    client.ApiService.makeApiRequest(
      'vehicules',
      'GET',
      null,
    ).then((value) {
      dynamic responseMap = value;

      var carsData = responseMap["vehicules"];
      // Create a list of cars objects
      List<Vehicule> cars = [];

      for (var carJson in carsData) {
        Vehicule car = Vehicule.fromJson(carJson);
        cars.add(car);
        carList.add(carJson);
      }

      setState(() {
        displayedCars = List.from(carList);
      });
    });
  }

  void _getIndex(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  void _editCar(int index) {
    // Implement edit functionality here
    Vehicule vehicule =
        Vehicule.fromJson(displayedCars[index]); // Get the locataire details
    // Assuming vehicule is an instance of your vehicule object
    marqueController.text = vehicule.marque;
    modeleController.text = vehicule.modele;
    anneeController.text = vehicule.annee.toString();
    kilometrageController.text = vehicule.kilometrage.toString();
    statutController.text = vehicule.statut;
    numChassisController.text = vehicule.numChassis;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Edit Car Details'),
          content: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  TextFormField(
                    controller: marqueController,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.directions_car),
                      labelText: 'Marque',
                    ),
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a marque';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: modeleController,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.category),
                      labelText: 'Modele',
                    ),
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a modele';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: anneeController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.calendar_today),
                      labelText: 'Annee',
                    ),
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a year';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: kilometrageController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.speed),
                      labelText: 'Kilometrage',
                    ),
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a kilometrage';
                      }
                      if (int.tryParse(value) == null) {
                        return 'Please enter a valid number';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: statutController,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.check),
                      labelText: 'Statut',
                    ),
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a statut';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: numChassisController,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.confirmation_number),
                      labelText: 'Num Chassis',
                    ),
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a num chassis';
                      }
                      return null;
                    },
                  ),
                ],
              ),
            ),
          ),
          actions: <Widget>[
            ElevatedButton(
              child: Text('Save'),
              onPressed: () {
                if (_formKey.currentState?.validate() ?? false) {
                  // Save the edited car details
                  // Step 1: Retrieve values from controllers
                  int idFournisseur = displayedCars[index]['id_fournisseur'];
                  String marque = marqueController.text;
                  String modele = modeleController.text;
                  int annee = int.parse(anneeController.text);
                  int kilometrage = int.parse(kilometrageController.text);
                  String statut = statutController.text;
                  String numChassis = numChassisController.text;

                  // Step 2: Create request payload
                  int? carId = displayedCars[index]['id'];

                  Vehicule car = Vehicule(
                      id: carId!,
                      idFournisseur: idFournisseur,
                      marque: marque,
                      modele: modele,
                      annee: annee,
                      kilometrage: kilometrage,
                      statut: statut,
                      numChassis: numChassis,
                      carteGrise: "83838383",
                      puissance: 0,
                      nombreCylindre: 0,
                      typeCarburant: "typeCarburant",
                      gamme: "gamme",
                      categorie: "categorie",
                      vin: "vin");

                  print(car.toJson().toString());

                  // Make the API request to update the car
                  client.ApiService.makeApiRequest(
                    'vehicules/$carId',
                    'PUT',
                    car.toJson(),
                  ).then((response) {
                    // Handle the response from the API

                    setState(() {
                      displayedCars[index] = car.toJson();
                    });

                    print('car details updated');

                    Navigator.of(context).pop(); // Close the dialog

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Details updated'),
                      ),
                    );
                  }).catchError((error) {
                    // Handle any errors that occur during the API request
                    print('Error updating vehicule details: $error');
                  });
                }
              },
            ),
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
            ),
          ],
        );
      },
    );
  }

  void _deleteCar(int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirm Delete'),
          content: Text('Are you sure you want to delete this car?'),
          actions: <Widget>[
            ElevatedButton(
              child: Text('Delete'),
              onPressed: () {
                var carId = displayedCars[index]['id'];
                // Get the ID of the locataire
                client.ApiService.makeApiRequest(
                  'vehicules/$carId', // Append the locataire ID to the API endpoint
                  'DELETE',
                  null,
                ).then((value) {
                  dynamic responseMap = value;
                  print(responseMap);
                });

                setState(() {
                  displayedCars.removeAt(index);
                });
                Navigator.of(context).pop(); // Close the dialog
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    backgroundColor: Colors.green,
                    content: Text('Vehicule supprimé avec succès'),
                  ),
                );
              },
            ),
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
            ),
          ],
        );
      },
    );
  }

  void _updateCar(int index) {
    // Implement update functionality here
    //print('Updating car at index $index');
  }

  void _searchCars(String query) {
    setState(() {
      displayedCars = carList
          .where((car) =>
              car["marque"].toLowerCase().contains(query.toLowerCase()) ||
              car["VIN"].toLowerCase().contains(query.toLowerCase()) ||
              car["statut"].toLowerCase().contains(query.toLowerCase()) ||
              car["num_chassis"].toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  void _addNewCar() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Add New Car'),
          content: SingleChildScrollView(
            child: Form(
              key: _formKey2,
              child: Column(
                children: <Widget>[
                  TextFormField(
                    controller: marqueController,
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.directions_car),
                      labelText: 'Marque',
                    ),
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a marque';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: modeleController,
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.category),
                      labelText: 'Modele',
                    ),
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a modele';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: anneeController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.calendar_today),
                      labelText: 'Annee',
                    ),
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a year';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: kilometrageController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.speed),
                      labelText: 'Kilometrage',
                    ),
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a kilometrage';
                      }
                      if (int.tryParse(value) == null) {
                        return 'Please enter a valid number';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: statutController,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.check),
                      labelText: 'Statut',
                    ),
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a statut';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: numChassisController,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.confirmation_number),
                      labelText: 'Num Chassis',
                    ),
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a num chassis';
                      }
                      return null;
                    },
                  ),
                ],
              ),
            ),
          ),
          actions: <Widget>[
            ElevatedButton(
              child: Text('Save'),
              onPressed: () {
                if (_formKey2.currentState!.validate()) {
                  Vehicule car = Vehicule(
                      id: 0,
                      idFournisseur: 1,
                      marque: marqueController.text,
                      modele: modeleController.text,
                      annee: int.parse(anneeController.text),
                      kilometrage: int.parse(kilometrageController.text),
                      statut: statutController.text,
                      numChassis: numChassisController.text,
                      carteGrise: "83838383",
                      puissance: 0,
                      nombreCylindre: 0,
                      typeCarburant: "typeCarburant",
                      gamme: "gamme",
                      categorie: "categorie",
                      vin: "vin");

                  print(car.toJson().toString());

                  // Make the API request to update the car
                  client.ApiService.makeApiRequest(
                    'vehicules',
                    'POST',
                    car.toJson(),
                  ).then((response) {
                    // Handle the response from the API

                    setState(() {
                      displayedCars.add(car.toJson());
                    });

                    print('car details added');

                    Navigator.of(context).pop(); // Close the dialog

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('car added'),
                      ),
                    );
                  }).catchError((error) {
                    // Handle any errors that occur during the API request
                    print('Error en ajoutant vehicule details: $error');
                  });
                }
              },
            ),
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //------------------------
      //------------------------
      //------------------------
      appBar: AppBar(
        title: Text('Vehicule List'),
        actions: [
          Flexible(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: searchController,
                onChanged: _searchCars,
                decoration: InputDecoration(
                  hintText: 'Search...',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
          ),
        ],
      ),

      //------------------------
      //------------------------
      //------------------------
      //------------------------
      //------------------------
      body: PaginatedDataTable(
        header: Text('Vehicule List'),

        showFirstLastButtons: true,
        rowsPerPage: 5,
        arrowHeadColor: Colors.purple,
        showCheckboxColumn: true,
        //------------------------
        actions: [
          IconButton(
            icon: Icon(Icons.edit, color: Colors.green),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(
              Icons.delete,
              color: Colors.red,
            ),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.update, color: Colors.purple),
            onPressed: () {},
          ),
        ],
        //------------------------
        columns: const [
          DataColumn(label: Text('Marque')),
          DataColumn(label: Text('Modele')),
          DataColumn(label: Text('Annee')),
          DataColumn(label: Text('Klometrage')),
          DataColumn(label: Text('Carte_grise')),
          DataColumn(label: Text('Nombre_cylindre')),
          DataColumn(label: Text('Ctegorie')),
          DataColumn(label: Text('VIN')),
          DataColumn(label: Text('Status')),
          DataColumn(label: Text('Num Chassis')),
          DataColumn(label: Text('Actions')),
        ],
        source: MyDataTableSource(
          cars: displayedCars,
          editCar: _editCar,
          deleteCar: _deleteCar,
          updateCar: _updateCar,
          getIndex: _getIndex,
          selectedIndex: selectedIndex,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addNewCar,
        child: Icon(Icons.add),
      ),
    );
  }
}

class MyDataTableSource extends DataTableSource {
  final List<Map<String, dynamic>> cars;
  final Function(int) editCar;
  final Function(int) deleteCar;
  final Function(int) updateCar;
  final Function(int) getIndex;
  final int? selectedIndex;
  MyDataTableSource({
    required this.cars,
    required this.editCar,
    required this.deleteCar,
    required this.updateCar,
    required this.getIndex,
    required this.selectedIndex,
  });

  @override
  DataRow getRow(int index) {
    final car = cars[index];
    return DataRow(
        onSelectChanged: (bool? selected) {
          getIndex(index);
        },
        selected: selectedIndex == index ? true : false,
        cells: [
          DataCell(Text(car['marque'])),
          DataCell(Text(car['modele'])),
          DataCell(Text(car['annee'].toString())),
          DataCell(Text(car['kilometrage'].toString())),
          DataCell(Text(car['carte_grise'].toString())),
          DataCell(Text(car['nombre_cylindre'].toString())),
          DataCell(Text(car['categorie'])),
          DataCell(Text(car['VIN'])),
          DataCell(
            car['statut'] == 'active'
                ? CircleAvatar(
                    backgroundColor: Colors.green,
                    radius: 8,
                  )
                : CircleAvatar(
                    backgroundColor: Colors.red,
                    radius: 8,
                  ),
          ),
          DataCell(Text(car['num_chassis'])),
          DataCell(Row(
            children: [
              IconButton(
                icon: Icon(Icons.edit, color: Colors.green),
                onPressed: () => editCar(index),
              ),
              IconButton(
                icon: Icon(
                  Icons.delete,
                  color: Colors.red,
                ),
                onPressed: () => deleteCar(index),
              ),
              IconButton(
                icon: Icon(Icons.update, color: Colors.purple),
                onPressed: () => updateCar(index),
              ),
            ],
          )),
        ]);
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => cars.length;

  @override
  int get selectedRowCount => 0;
}
