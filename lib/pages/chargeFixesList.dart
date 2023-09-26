import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../api/apiService.dart' as client;
import '../models/chargeFixes.dart';

class ChargesFixesList extends StatefulWidget {
  @override
  _ChargesFixesListState createState() => _ChargesFixesListState();
}

class _ChargesFixesListState extends State<ChargesFixesList> {
  List<Map<String, dynamic>> chargesFixesList = [
    // Add more charge_fixes as needed
  ];

  List<Map<String, dynamic>> displayedChargesFixes = [];

  TextEditingController searchController = TextEditingController();
  final TextEditingController idController = TextEditingController();
  final TextEditingController vehiculeIdController = TextEditingController();
  final TextEditingController montantController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController fournisseurController = TextEditingController();
  final TextEditingController dateDebutController = TextEditingController();
  final TextEditingController dateFinController = TextEditingController();
  final TextEditingController mavertirAvantController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  int? selectedIndex = -1;
  String? bearerToken;

  @override
  void initState() {
    super.initState();

    client.ApiService.makeApiRequest(
      'charge-fixes',
      'GET',
      null,
    ).then((value) {
      dynamic responseMap = value;
      print(responseMap);
      var chargesFixesData = responseMap["chargesFixes"];
      // Create a list of ChargeFixe objects

      print("2 print " + chargesFixesData.toString());

      List<ChargeFixes> chargesFixes = [];

      for (var chargeFixeJson in chargesFixesData) {
        ChargeFixes chargeFixe = ChargeFixes.fromJson(chargeFixeJson);
        chargesFixes.add(chargeFixe);

        
        chargesFixesList.add(chargeFixeJson);
      }

      setState(() {
        displayedChargesFixes = List.from(chargesFixesList);
      });
    });
  }

  void _getIndex(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  void _editChargeFixe(int index) {
    var chargeFixe =
        displayedChargesFixes[index]; // Get the charge_fixe details
    vehiculeIdController.text = chargeFixe['vehicule_id'].toString();
    montantController.text = chargeFixe['montant'].toString();
    descriptionController.text = chargeFixe['description'].toString();
    fournisseurController.text = chargeFixe['fournisseur'].toString();
    dateDebutController.text = chargeFixe['date_debut'].toString();
    dateFinController.text = chargeFixe['date_fin'].toString();
    mavertirAvantController.text = chargeFixe['mavertir_avant'].toString();

   
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Edit Charge Fixe Details'),
          content: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  TextFormField(
                    controller: vehiculeIdController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.car_crash_outlined),
                      labelText: 'Vehicle ID',
                    ),
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a Vehicle ID';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: montantController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.monetization_on),
                      labelText: 'Montant',
                    ),
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a montant';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: descriptionController,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.description),
                      labelText: 'Description',
                    ),
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a description';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: fournisseurController,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.business),
                      labelText: 'Fournisseur',
                    ),
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a fournisseur';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: dateDebutController,
                    keyboardType: TextInputType.datetime,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.calendar_today),
                      labelText: 'Date Debut',
                    ),
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a date';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: dateFinController,
                    keyboardType: TextInputType.datetime,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.calendar_today),
                      labelText: 'Date Fin',
                    ),
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a date';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: mavertirAvantController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.notification_important),
                      labelText: 'Mavertir Avant',
                    ),
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter mavertir avant';
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
                  // Update the charge_fixe details in the database
                  String vehiculeId = vehiculeIdController.text;
                  String montant = montantController.text;
                  String description = descriptionController.text;
                  String fournisseur = fournisseurController.text;
                  String dateDebut = dateDebutController.text;
                  String dateFin = dateFinController.text;
                  String mavertirAvant = mavertirAvantController.text;

                  var updatedChargeFixe = {
                    'vehicule_id': int.parse(vehiculeId),
                    'montant': double.parse(montant),
                    'description': description,
                    'fournisseur': fournisseur,
                    'date_debut': dateDebut,
                    'date_fin': dateFin,
                    'mavertir_avant': int.parse(mavertirAvant),
                  };

                  // Make the API request to update the charge_fixe
                  var chargeFixeId = displayedChargesFixes[index]['id'];
                  client.ApiService.makeApiRequest(
                    'charge-fixes/$chargeFixeId',
                    'PUT',
                    updatedChargeFixe,
                  ).then((response) {
                    // Handle the response from the API

                    setState(() {
                      displayedChargesFixes[index] = updatedChargeFixe;
                    });

                    print('Charge Fixe details updated');

                    Navigator.of(context).pop(); // Close the dialog

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Details updated'),
                      ),
                    );
                  }).catchError((error) {
                    // Handle any errors that occur during the API request
                    print('Error updating charge_fixe details: $error');
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

  void _deleteChargeFixe(int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirm Delete'),
          content: Text('Are you sure you want to delete this charge fixe?'),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Delete'),
              onPressed: () {
                var chargeFixeId = displayedChargesFixes[index]['id'];
                client.ApiService.makeApiRequest(
                  'charge-fixes/$chargeFixeId',
                  'DELETE',
                  null,
                ).then((value) {
                  dynamic responseMap = value;
                  // Handle the response from the API

                  setState(() {
                    displayedChargesFixes.removeAt(index);
                  });

                  print('Charge Fixe deleted');

                  Navigator.of(context).pop();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Charge Fixe deleted'),
                    ),
                  );
                });
              },
            ),
          ],
        );
      },
    );
  }

  void _updateChargeFixe(int index) {
    var chargeFixeId =
        displayedChargesFixes[index]['id']; // Get the ID of the charge_fixe
    // Implement update functionality here using the chargeFixeId
    print('Updating charge_fixe with ID: $chargeFixeId');
  }

  void _searchChargesFixes(String query) {
    setState(() {
      displayedChargesFixes = chargesFixesList
          .where((chargeFixe) =>
              chargeFixe["montant"]
                  .toString()
                  .toLowerCase()
                  .contains(query.toLowerCase()) ||
              chargeFixe["description"]
                  .toLowerCase()
                  .contains(query.toLowerCase()))
          .toList();
    });
  }

  void _addNewChargeFixe() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Add New Charge Fixe'),
          content: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  TextFormField(
                    controller: vehiculeIdController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.car_crash_outlined),
                      labelText: 'Vehicle ID',
                    ),
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a Vehicle ID';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: montantController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.monetization_on),
                      labelText: 'Montant',
                    ),
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a montant';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: descriptionController,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.description),
                      labelText: 'Description',
                    ),
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a description';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: fournisseurController,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.business),
                      labelText: 'Fournisseur',
                    ),
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a fournisseur';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: dateDebutController,
                    keyboardType: TextInputType.datetime,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.calendar_today),
                      labelText: 'Date Debut',
                    ),
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a date';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: dateFinController,
                    keyboardType: TextInputType.datetime,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.calendar_today),
                      labelText: 'Date Fin',
                    ),
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a date';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: mavertirAvantController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.notification_important),
                      labelText: 'Mavertir Avant',
                    ),
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter mavertir avant';
                      }
                      return null;
                    },
                  ),
                ],
              ),
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Save'),
              onPressed: () {
                // Form is valid, process the data

                String vehiculeId = vehiculeIdController.text;
                String montant = montantController.text;
                String description = descriptionController.text;
                String fournisseur = fournisseurController.text;
                String dateDebut = dateDebutController.text;
                String dateFin = dateFinController.text;
                String mavertirAvant = mavertirAvantController.text;

                var newChargeFixe = {
                  'vehicule_id': int.parse(vehiculeId),
                  'montant': double.parse(montant),
                  'description': description,
                  'fournisseur': fournisseur,
                  'date_debut': dateDebut,
                  'date_fin': dateFin,
                  'mavertir_avant': int.parse(mavertirAvant),
                };

                client.ApiService.makeApiRequest(
                  'charge-fixes',
                  'POST',
                  newChargeFixe,
                ).then((response) {
                  print(response);
                  setState(() {
                    displayedChargesFixes.add(newChargeFixe);
                  });

                  print('New charge fixe added to the database');

                  Navigator.of(context).pop();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Charge Fixe added successfully'),
                    ),
                  );
                }).catchError((error) {
                  print('Error adding new charge fixe: $error');
                });
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
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          Flexible(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: searchController,
                onChanged: _searchChargesFixes,
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
        header: Text('Charges Fixes List'),
        showFirstLastButtons: true,
        rowsPerPage: 5,
        arrowHeadColor: Colors.purple,
        showCheckboxColumn: true,
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
        columns: const [
          DataColumn(label: Text('id')),
          DataColumn(label: Text('Vehicule Id')),
          DataColumn(label: Text('Montant')),
          DataColumn(label: Text('Description')),
          DataColumn(label: Text('Fournisseur')),
          DataColumn(label: Text('Date debut')),
          DataColumn(label: Text('Date fin')),
          DataColumn(label: Text("m.avant")),
          DataColumn(label: Text("Cree le")),
          DataColumn(label: Text('Actions')),
        ],
        source: MyDataTableSource(
          chargesFixes: displayedChargesFixes,
          editChargeFixe: _editChargeFixe,
          deleteChargeFixe: _deleteChargeFixe,
          updateChargeFixe: _updateChargeFixe,
          getIndex: _getIndex,
          selectedIndex: selectedIndex,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addNewChargeFixe,
        child: Icon(Icons.add),
      ),
    );
  }
}

class MyDataTableSource extends DataTableSource {
  final List<Map<String, dynamic>> chargesFixes;
  final Function(int) editChargeFixe;
  final Function(int) deleteChargeFixe;
  final Function(int) updateChargeFixe;
  final Function(int) getIndex;
  final int? selectedIndex;
  MyDataTableSource({
    required this.chargesFixes,
    required this.editChargeFixe,
    required this.deleteChargeFixe,
    required this.updateChargeFixe,
    required this.getIndex,
    required this.selectedIndex,
  });

  @override
  DataRow getRow(int index) {
    final chargeFixe = chargesFixes[index];
    return DataRow(
      onSelectChanged: (bool? selected) {
        getIndex(index);
      },
      selected: selectedIndex == index ? true : false,
      cells: [
        DataCell(Text(chargeFixe['id'].toString())),
        DataCell(Text(chargeFixe['vehicule_id'].toString())),
        DataCell(Text(chargeFixe['montant'].toString())),
        DataCell(Text(chargeFixe['description'])),
        DataCell(Text(chargeFixe['fournisseur'])),
        DataCell(Text(chargeFixe['date_debut'].toString())),
        DataCell(Text(chargeFixe['date_fin'].toString())),
        DataCell(Text(chargeFixe['mavertir_avant'].toString())),
        DataCell(Text(chargeFixe['cree_le'].toString())),
        DataCell(Row(
          children: [
            IconButton(
              icon: Icon(Icons.edit, color: Colors.green),
              onPressed: () => editChargeFixe(index),
            ),
            IconButton(
              icon: Icon(
                Icons.delete,
                color: Colors.red,
              ),
              onPressed: () => deleteChargeFixe(index),
            ),
            IconButton(
              icon: Icon(Icons.update, color: Colors.purple),
              onPressed: () => updateChargeFixe(index),
            ),
          ],
        )),
      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => chargesFixes.length;

  @override
  int get selectedRowCount => 0;
}
