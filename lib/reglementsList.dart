import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../api/apiService.dart' as client;
import 'models/reglements.dart';

class ReglementsList extends StatefulWidget {
  @override
  _ReglementsListState createState() => _ReglementsListState();
}

class _ReglementsListState extends State<ReglementsList> {
  List<Map<String, dynamic>> reglementsList = [
    // Add more reglements as needed
  ];

  List<Map<String, dynamic>> displayedReglements = [];

  TextEditingController searchController = TextEditingController();
  TextEditingController contratIdController = TextEditingController();
  TextEditingController montantController = TextEditingController();
  TextEditingController montantRestController = TextEditingController();
  TextEditingController montantFactureController = TextEditingController();
  TextEditingController modePaymentController = TextEditingController();
  TextEditingController numChequeController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController creeLeController = TextEditingController();
  TextEditingController dateEcheanceController = TextEditingController();
  TextEditingController createdAtController = TextEditingController();
  TextEditingController updatedAtController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  int? selectedIndex = -1;
  String? bearerToken;

  @override
  void initState() {
    super.initState();

    client.ApiService.makeApiRequest(
      'reglements',
      'GET',
      null,
    ).then((value) {
      dynamic responseMap = value;
      print(responseMap);
      var reglementsData = responseMap["reglements"];
      // Create a list of Reglement objects
      List<Reglement> reglements = [];
      print(reglementsData);

      for (var reglementJson in reglementsData) {
        Reglement reglement = Reglement.fromJson(reglementJson);
        reglements.add(reglement);
        reglementsList.add(reglementJson);
      }

      setState(() {
        displayedReglements = List.from(reglementsList);
      });
    });
  }

  void _getIndex(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  void _editReglement(int index) {
    var reglement = displayedReglements[index]; // Get the reglement details
    contratIdController.text = reglement['contrat_id']
        .toString(); // Populate the form field with the existing contrat_id
    montantController.text = reglement['montant']
        .toString(); // Populate the form field with the existing montant
    montantRestController.text = reglement['montant_rest']
        .toString(); // Populate the form field with the existing montant_rest
    montantFactureController.text = reglement['montant_facture']
        .toString(); // Populate the form field with the existing montant_facture
    modePaymentController.text = reglement[
        'mode_payment']; // Populate the form field with the existing mode_payment
    numChequeController.text = reglement[
        'num_cheque']; // Populate the form field with the existing num_cheque
    descriptionController.text = reglement[
        'description']; // Populate the form field with the existing description
    creeLeController.text = reglement['cree_le']
        .toString(); // Populate the form field with the existing cree_le
    dateEcheanceController.text = reglement['date_echeance']
        .toString(); // Populate the form field with the existing date_echeance
    createdAtController.text = reglement['created_at']
        .toString(); // Populate the form field with the existing created_at
    updatedAtController.text = reglement['updated_at']
        .toString(); // Populate the form field with the existing updated_at

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Edit Reglement Details'),
          content: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  TextFormField(
                    controller: contratIdController,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.person),
                      labelText: 'Contrat ID',
                    ),
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a contrat ID';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: montantController,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.phone),
                      labelText: 'Montant',
                    ),
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a Montant';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: montantRestController,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.email),
                      labelText: 'Montant Rest',
                    ),
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a Montant Rest';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: montantFactureController,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.location_on),
                      labelText: 'Montant Facture',
                    ),
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a Montant Facture';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: modePaymentController,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.location_on),
                      labelText: 'Mode Payment',
                    ),
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a Mode Payment';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: numChequeController,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.location_on),
                      labelText: 'Num Cheque',
                    ),
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a Num Cheque';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: descriptionController,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.location_on),
                      labelText: 'Description',
                    ),
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a Description';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: creeLeController,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.location_on),
                      labelText: 'Cree Le',
                    ),
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a Cree Le';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: dateEcheanceController,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.location_on),
                      labelText: 'Date Echeance',
                    ),
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a Date Echeance';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: createdAtController,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.location_on),
                      labelText: 'Created At',
                    ),
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a Created At';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: updatedAtController,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.location_on),
                      labelText: 'Updated At',
                    ),
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a Updated At';
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
                  // Update the reglement details in the database
                  var updatedReglement = {
                    'id': reglement['id'],
                    'contrat_id': int.parse(contratIdController.text),
                    'montant': double.parse(montantController.text),
                    'montant_rest': double.parse(montantRestController.text),
                    'montant_facture':
                        double.parse(montantFactureController.text),
                    'mode_payment': modePaymentController.text,
                    'num_cheque': numChequeController.text,
                    'description': descriptionController.text,
                    'cree_le': DateTime.parse(creeLeController.text),
                    'date_echeance':
                        DateTime.parse(dateEcheanceController.text),
                    'created_at': DateTime.parse(createdAtController.text),
                    'updated_at': DateTime.parse(updatedAtController.text),
                  };

                  // Make the API request to update the reglement
                  var reglementId = displayedReglements[index]['id'];
                  client.ApiService.makeApiRequest(
                    'reglements/$reglementId',
                    'PUT',
                    updatedReglement,
                  ).then((response) {
                    // Handle the response from the API

                    setState(() {
                      displayedReglements[index] = updatedReglement;
                    });

                    print('Reglement details updated');

                    Navigator.of(context).pop(); // Close the dialog

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Details updated'),
                      ),
                    );
                  }).catchError((error) {
                    // Handle any errors that occur during the API request
                    print('Error updating reglement details: $error');
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

  void _deleteReglement(int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirm Delete'),
          content: Text('Are you sure you want to delete this reglement?'),
          actions: <Widget>[
            ElevatedButton(
              child: Text('Delete'),
              onPressed: () {
                var reglementId = displayedReglements[index]['id'];
                // Get the ID of the reglement
                client.ApiService.makeApiRequest(
                  'reglements/$reglementId', // Append the reglement ID to the API endpoint
                  'DELETE',
                  null,
                ).then((value) {
                  dynamic responseMap = value;
                  print(responseMap);
                });

                setState(() {
                  displayedReglements.removeAt(index);
                });
                Navigator.of(context).pop(); // Close the dialog
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Reglement supprimé avec succès'),
                  ),
                );
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

  void _updateReglement(int index) {
    var reglementId =
        displayedReglements[index]['id']; // Get the ID of the reglement
    // Implement update functionality here using the reglementId
    print('Updating reglement with ID: $reglementId');
  }

  void _searchReglements(String query) {
    setState(() {
      displayedReglements = reglementsList
          .where((reglement) =>
              reglement["contrat_id"].toString().contains(query) ||
              reglement["montant"].toString().contains(query) ||
              reglement["montant_rest"].toString().contains(query) ||
              reglement["montant_facture"].toString().contains(query) ||
              reglement["mode_payment"]
                  .toLowerCase()
                  .contains(query.toLowerCase()) ||
              reglement["num_cheque"]
                  .toLowerCase()
                  .contains(query.toLowerCase()) ||
              reglement["description"]
                  .toLowerCase()
                  .contains(query.toLowerCase()) ||
              reglement["cree_le"].toString().contains(query) ||
              reglement["date_echeance"].toString().contains(query) ||
              reglement["created_at"].toString().contains(query) ||
              reglement["updated_at"].toString().contains(query))
          .toList();
    });
  }

  void _addNewReglement() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Add New Reglement'),
          content: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  TextFormField(
                    controller: contratIdController,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.person),
                      labelText: 'Contrat ID',
                    ),
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a contrat ID';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: montantController,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.phone),
                      labelText: 'Montant',
                    ),
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a Montant';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: montantRestController,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.email),
                      labelText: 'Montant Rest',
                    ),
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a Montant Rest';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: montantFactureController,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.location_on),
                      labelText: 'Montant Facture',
                    ),
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a Montant Facture';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: modePaymentController,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.location_on),
                      labelText: 'Mode Payment',
                    ),
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a Mode Payment';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: numChequeController,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.location_on),
                      labelText: 'Num Cheque',
                    ),
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a Num Cheque';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: descriptionController,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.location_on),
                      labelText: 'Description',
                    ),
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a Description';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: creeLeController,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.location_on),
                      labelText: 'Cree Le',
                    ),
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a Cree Le';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: dateEcheanceController,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.location_on),
                      labelText: 'Date Echeance',
                    ),
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a Date Echeance';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: createdAtController,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.location_on),
                      labelText: 'Created At',
                    ),
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a Created At';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: updatedAtController,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.location_on),
                      labelText: 'Updated At',
                    ),
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a Updated At';
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
                  // Save the new reglement details
                  var newReglement = {
                    'contrat_id': int.parse(contratIdController.text),
                    'montant': double.parse(montantController.text),
                    'montant_rest': double.parse(montantRestController.text),
                    'montant_facture':
                        double.parse(montantFactureController.text),
                    'mode_payment': modePaymentController.text,
                    'num_cheque': numChequeController.text,
                    'description': descriptionController.text,
                    'cree_le': DateTime.parse(creeLeController.text),
                    'date_echeance':
                        DateTime.parse(dateEcheanceController.text),
                    'created_at': DateTime.parse(createdAtController.text),
                    'updated_at': DateTime.parse(updatedAtController.text),
                  };

                  // Make the API request to create a new reglement
                  client.ApiService.makeApiRequest(
                    'reglements',
                    'POST',
                    newReglement,
                  ).then((response) {
                    // Handle the response from the API
                    print('New reglement added to the database');

                    // Update the displayedReglements list with the new reglement details
                    setState(() {
                      displayedReglements.add(newReglement);
                    });

                    Navigator.of(context).pop(); // Close the dialog
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Reglement ajouté avec succès'),
                      ),
                    );
                  }).catchError((error) {
                    // Handle any errors that occur during the API request
                    print('Error adding new reglement: $error');
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
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          Flexible(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: searchController,
                onChanged: _searchReglements,
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
        header: Text('Reglement List'),
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
          DataColumn(label: Text('Contrat ID')),
          DataColumn(label: Text('Montant')),
          DataColumn(label: Text('Montant Rest')),
          DataColumn(label: Text('Montant Facture')),
          DataColumn(label: Text('Mode Payment')),
          DataColumn(label: Text('Num Cheque')),
          DataColumn(label: Text('Description')),
          DataColumn(label: Text('Cree Le')),
          DataColumn(label: Text('Date Echeance')),
          DataColumn(label: Text('Created At')),
          DataColumn(label: Text('Updated At')),
          DataColumn(label: Text('Actions')),
        ],
        source: MyDataTableSource(
          reglements: displayedReglements,
          editReglement: _editReglement,
          deleteReglement: _deleteReglement,
          updateReglement: _updateReglement,
          getIndex: _getIndex,
          selectedIndex: selectedIndex,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addNewReglement,
        child: Icon(Icons.add),
      ),
    );
  }
}

class MyDataTableSource extends DataTableSource {
  final List<Map<String, dynamic>> reglements;
  final Function(int) editReglement;
  final Function(int) deleteReglement;
  final Function(int) updateReglement;
  final Function(int) getIndex;
  final int? selectedIndex;
  MyDataTableSource({
    required this.reglements,
    required this.editReglement,
    required this.deleteReglement,
    required this.updateReglement,
    required this.getIndex,
    required this.selectedIndex,
  });

  @override
  DataRow getRow(int index) {
    final reglement = reglements[index];
    return DataRow(
        onSelectChanged: (bool? selected) {
          getIndex(index);
        },
        selected: selectedIndex == index ? true : false,
        cells: [
          DataCell(Text(reglement['contrat_id'].toString())),
          DataCell(Text(reglement['montant'].toString())),
          DataCell(Text(reglement['montant_rest'].toString())),
          DataCell(Text(reglement['montant_facture'].toString())),
          DataCell(Text(reglement['mode_payment'].toString())),
          DataCell(Text(reglement['num_cheque'].toString())),
          DataCell(Text(reglement['description'].toString())),
          DataCell(Text(reglement['cree_le'].toString())),
          DataCell(Text(reglement['date_echeance'].toString())),
          DataCell(Text(reglement['created_at'].toString())),
          DataCell(Text(reglement['updated_at'].toString())),
          DataCell(Row(
            children: [
              IconButton(
                icon: Icon(Icons.edit, color: Colors.green),
                onPressed: () => editReglement(index),
              ),
              IconButton(
                icon: Icon(
                  Icons.delete,
                  color: Colors.red,
                ),
                onPressed: () => deleteReglement(index),
              ),
              IconButton(
                icon: Icon(Icons.update, color: Colors.purple),
                onPressed: () => updateReglement(index),
              ),
            ],
          )),
        ]);
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => reglements.length;

  @override
  int get selectedRowCount => 0;
}
