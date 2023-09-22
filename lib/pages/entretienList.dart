import 'dart:convert';

import 'package:flutter/material.dart';
import '../../api/apiService.dart' as client;
import '../models/entretien.dart';

class EntretienList extends StatefulWidget {
  @override
  _EntretienListState createState() => _EntretienListState();
}

class _EntretienListState extends State<EntretienList> {
  List<Map<String, dynamic>> entretienList = [];
  List<Map<String, dynamic>> displayedEntretiens = [];

  TextEditingController vehiculeIdController = TextEditingController();
  TextEditingController operationController = TextEditingController();
  TextEditingController fraisController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController kmMController = TextEditingController();
  TextEditingController kmPController = TextEditingController();
  TextEditingController montantsController = TextEditingController();
  TextEditingController mavertirAvantController = TextEditingController();
  TextEditingController observationController = TextEditingController();
  TextEditingController searchController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  int? selectedIndex = -1;
  String? bearerToken;

  dynamic _selectedVehicule;
  List<Map<String, dynamic>> _vehicules = [];

  @override
  void initState() {
    super.initState();
    client.ApiService.makeApiRequest(
      'entretiens',
      'GET',
      null,
    ).then((value) {
      dynamic responseMap = value;

      var entretiensData = responseMap["entretiens"];
      List<Entretien> entretiens = [];

      for (var entretienJson in entretiensData) {
        Entretien entretien = Entretien.fromJson(entretienJson);
        entretiens.add(entretien);
        entretienList.add(entretienJson);
      }

      setState(() {
        displayedEntretiens = List.from(entretienList);
      });
    });

    // vehicules liste
    client.ApiService.makeApiRequest(
      'entretiensVehicules',
      'GET',
      null,
    ).then((value) {
      dynamic responseMap = value;

      var vehiculesData = responseMap["vehicules"];

      for (var vehiculeJson in vehiculesData) {
        // Extract the required data
        var vehiculeIdCard = {
          "id": vehiculeJson["id"],
          "carte": vehiculeJson["carte_grise"].toString()
        };

        _vehicules.add(vehiculeIdCard);
        // Now, you can use 'carteGrise' in your application instead of 'vehiculeId'.
        // For example, you can print it:
      }

      _selectedVehicule = _vehicules.first;
    });
  }

  void _getIndex(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  void _editEntretien(int index) {
    Entretien entretien = Entretien.fromJson(displayedEntretiens[index]);

    vehiculeIdController.text = entretien.vehiculeId.toString();
    operationController.text = entretien.operation.toString();
    fraisController.text = entretien.frais.toString();
    dateController.text = entretien.date.toString();
    kmMController.text = entretien.kmM.toString();
    kmPController.text = entretien.kmP.toString();
    montantsController.text = entretien.montants.toString();
    mavertirAvantController.text = entretien.mavertirAvant.toString();
    observationController.text = entretien.observation.toString();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Edit Entretien Details'),
          content: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  DropdownButtonFormField<Map<String, dynamic>>(
                    value: _selectedVehicule,
                    items: _vehicules.map((vehicule) {
                      return DropdownMenuItem<Map<String, dynamic>>(
                        value: vehicule,
                        child: Text(vehicule["carte"]),
                      );
                    }).toList(),
                    onChanged: (newValue) {
                      setState(() {
                        _selectedVehicule = newValue;
                      });
                    },
                    decoration: InputDecoration(
                      labelText: 'Select a vehicule',
                    ),
                  ),
                  TextFormField(
                    controller: operationController,
                    decoration: InputDecoration(
                      labelText: 'Operation',
                    ),
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter an operation';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: fraisController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: 'Frais',
                    ),
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter the frais';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: dateController,
                    keyboardType: TextInputType.datetime,
                    decoration: InputDecoration(
                      labelText: 'Date',
                    ),
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter the date';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: kmMController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: 'Km_m',
                    ),
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter the Km_m';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: kmPController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: 'Km_p',
                    ),
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter the Km_p';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: montantsController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: 'Montants',
                    ),
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter the montants';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: mavertirAvantController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: 'Mavertir_avant',
                    ),
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter the Mavertir_avant';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: observationController,
                    decoration: InputDecoration(
                      labelText: 'Observation',
                    ),
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter the observation';
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
                  int id = displayedEntretiens[index]['id'];
                  String operation = operationController.text.toString();
                  String? frais = fraisController.text.toString();
                  String date = dateController.text.toString();
                  String kmM = kmMController.text.toString();
                  String kmP = kmPController.text.toString();
                  double montants = double.parse(montantsController.text);
                  String mavertirAvant =
                      mavertirAvantController.text.toString();
                  String observation = observationController.text.toString();

                  Entretien entretien = Entretien(
                    id: id,
                    vehiculeId: _selectedVehicule["id"],
                    operation: operation,
                    frais: double.parse(frais.toString()),
                    date: date,
                    kmM: int.parse(kmM),
                    kmP: int.parse(kmP),
                    montants: double.parse(montants.toString()),
                    mavertirAvant: int.parse(mavertirAvant),
                    observation: observation,
                  );

                  client.ApiService.makeApiRequest(
                    'entretiens/$id',
                    'PUT',
                    entretien.toJson(),
                  ).then((response) {
                    print(displayedEntretiens);
                    print(entretien.toJson());

                    setState(() {
                      displayedEntretiens[index] = entretien.toJson();
                    });

                    print('entretien details updated');

                    Navigator.of(context).pop();
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Details updated'),
                      ),
                    );
                  }).catchError((error) {
                    print('Error updating entretien details: $error');
                  });
                }
              },
            ),
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _deleteEntretien(int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirm Delete'),
          content: Text('Are you sure you want to delete this entretien?'),
          actions: <Widget>[
            ElevatedButton(
              child: Text('Delete'),
              onPressed: () {
                var entretienId = displayedEntretiens[index]['id'];
                client.ApiService.makeApiRequest(
                  'entretiens/$entretienId',
                  'DELETE',
                  null,
                ).then((value) {
                  dynamic responseMap = value;
                  print(responseMap);
                });

                setState(() {
                  displayedEntretiens.removeAt(index);
                });
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    backgroundColor: Colors.green,
                    content: Text('Entretien deleted successfully'),
                  ),
                );
              },
            ),
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _addNewEntretien() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Add New Entretien'),
          content: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  DropdownButtonFormField<Map<String, dynamic>>(
                    value: _selectedVehicule,
                    items: _vehicules.map((vehicule) {
                      return DropdownMenuItem<Map<String, dynamic>>(
                        value: vehicule,
                        child: Text(vehicule["carte"]),
                      );
                    }).toList(),
                    onChanged: (newValue) {
                      setState(() {
                        _selectedVehicule = newValue;
                      });
                    },
                    decoration: InputDecoration(
                      labelText: 'Select a vehicule',
                    ),
                  ),
                  TextFormField(
                    controller: operationController,
                    decoration: InputDecoration(
                      labelText: 'Operation',
                    ),
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter an operation';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: fraisController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: 'Frais',
                    ),
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter the frais';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: dateController,
                    keyboardType: TextInputType.datetime,
                    decoration: InputDecoration(
                      labelText: 'Date',
                    ),
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter the date';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: kmMController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: 'Km_m',
                    ),
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter the Km_m';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: kmPController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: 'Km_p',
                    ),
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter the Km_p';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: montantsController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: 'Montants',
                    ),
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter the montants';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: mavertirAvantController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: 'Mavertir_avant',
                    ),
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter the Mavertir_avant';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: observationController,
                    decoration: InputDecoration(
                      labelText: 'Observation',
                    ),
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter the observation';
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
                  Entretien entretien = Entretien(
                    id: entretienList.length + 1, // Generate a unique ID
                    vehiculeId: _selectedVehicule["id"],
                    operation: operationController.text,
                    frais: double.parse(fraisController.text),
                    date: dateController.text,
                    kmM: int.parse(kmMController.text),
                    kmP: int.parse(kmPController.text),
                    montants: double.parse(montantsController.text),
                    mavertirAvant: int.parse(mavertirAvantController.text),
                    observation: observationController.text,
                  );

                  client.ApiService.makeApiRequest(
                    'entretiens',
                    'POST',
                    entretien.toJson(),
                  ).then((response) {
                    setState(() {
                      displayedEntretiens.add(entretien.toJson());
                    });

                    print(displayedEntretiens);
                    print('entretien details added');

                    Navigator.of(context).pop();
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Entretien added'),
                      ),
                    );
                  }).catchError((error) {
                    print('Error adding entretien details: $error');
                  });
                }
              },
            ),
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _searchEntretiens(String query) {
    setState(() {
      displayedEntretiens = entretienList
          .where((entretien) =>
              entretien["vehicule_id"]
                  .toLowerCase()
                  .contains(query.toLowerCase()) ||
              entretien["operation"]
                  .toLowerCase()
                  .contains(query.toLowerCase()) ||
              entretien["frais"].toLowerCase().contains(query.toLowerCase()) ||
              entretien["date"].toLowerCase().contains(query.toLowerCase()) ||
              entretien["kmM"].toLowerCase().contains(query.toLowerCase()) ||
              entretien["kmP"].toLowerCase().contains(query.toLowerCase()) ||
              entretien["montants"]
                  .toLowerCase()
                  .contains(query.toLowerCase()) ||
              entretien["mavertirAvant"]
                  .toLowerCase()
                  .contains(query.toLowerCase()) ||
              entretien["observation"]
                  .toLowerCase()
                  .contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Entretien List'),
        actions: [
          Flexible(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: searchController,
                onChanged: _searchEntretiens,
                decoration: InputDecoration(
                  hintText: 'Search...',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
          ),
        ],
      ),
      body: PaginatedDataTable(
        header: Text('Entretien List'),
        showFirstLastButtons: true,
        rowsPerPage: 5,
        columns: const [
          DataColumn(label: Text('ID')),
          DataColumn(label: Text('Vehicule')),
          DataColumn(label: Text('Operation')),
          DataColumn(label: Text('Frais')),
          DataColumn(label: Text('Date')),
          DataColumn(label: Text('Km_m')),
          DataColumn(label: Text('Km_p')),
          DataColumn(label: Text('Montants')),
          DataColumn(label: Text('Mavertir_avant')),
          DataColumn(label: Text('Observation')),
          DataColumn(label: Text('Actions')),
        ],
        source: MyDataTableSource(
            entretiens: displayedEntretiens,
            editEntretien: _editEntretien,
            deleteEntretien: _deleteEntretien,
            getIndex: _getIndex,
            selectedIndex: selectedIndex,
            vehicules: []),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addNewEntretien,
        child: Icon(Icons.add),
      ),
    );
  }
}

class MyDataTableSource extends DataTableSource {
  final List<Map<String, dynamic>> entretiens;
  final List<String> vehicules; // Add this line
  final Function(int) editEntretien;
  final Function(int) deleteEntretien;
  final Function(int) getIndex;
  final int? selectedIndex;

  MyDataTableSource({
    required this.entretiens,
    required this.editEntretien,
    required this.deleteEntretien,
    required this.getIndex,
    required this.selectedIndex,
    required this.vehicules,
  });

  @override
  DataRow getRow(int index) {
    final entretien = entretiens[index];
    final vehiculeId = entretien['vehicule_id'].toString();
    final vehiculeCarteGrise = vehicules.firstWhere(
        (_vehicule) => _vehicule.startsWith(vehiculeId),
        orElse: () => '');

    return DataRow(
      onSelectChanged: (bool? selected) {
        getIndex(index);
      },
      selected: selectedIndex == index ? true : false,
      cells: [
        DataCell(Text(entretien['id'].toString())),
        DataCell(Text(entretien['vehicule_id']
            .toString())), // Use the vehicle carte_grise here
        DataCell(Text(entretien['operation'])),
        DataCell(Text(entretien['frais'].toString())),
        DataCell(Text(entretien['date'])),
        DataCell(Text(entretien['km_m'].toString())),
        DataCell(Text(entretien['km_p'].toString())),
        DataCell(Text(entretien['montants'].toString())),
        DataCell(Text(entretien['mavertir_avant'].toString())),
        DataCell(Text(entretien['observation'])),
        DataCell(
          Row(
            children: [
              IconButton(
                icon: Icon(Icons.edit, color: Colors.green),
                onPressed: () => editEntretien(index),
              ),
              IconButton(
                icon: Icon(
                  Icons.delete,
                  color: Colors.red,
                ),
                onPressed: () => deleteEntretien(index),
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => entretiens.length;

  @override
  int get selectedRowCount => selectedIndex != null ? 1 : 0;
}
