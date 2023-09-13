import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:my_web_project/models/locataire.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../api/apiService.dart' as client;

class LocatairesList extends StatefulWidget {
  @override
  _LocatairesListState createState() => _LocatairesListState();
}

class _LocatairesListState extends State<LocatairesList> {
  List<Map<String, dynamic>> LocatairesList = [
    // Add more locataires as needed
  ];

  List<Map<String, dynamic>> displayedLocataires = [];

  TextEditingController searchController = TextEditingController();
  TextEditingController nomController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController telephoneController = TextEditingController();
  TextEditingController adresseController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  int? selectedIndex = -1;
  String? bearerToken;

  @override
  void initState() {
    super.initState();

    client.ApiService.makeApiRequest(
      'locataires',
      'GET',
      null,
    ).then((value) {
      dynamic responseMap = value;
      print(responseMap);
      var locatairesData = responseMap["locataires"];
      // Create a list of Locataire objects
      List<Locataire> locataires = [];
      print(locatairesData);

      for (var locataireJson in locatairesData) {
        Locataire locataire = Locataire.fromJson(locataireJson);
        locataires.add(locataire);
        LocatairesList.add(locataireJson);
      }

      setState(() {
        displayedLocataires = List.from(LocatairesList);
      });
    });
  }

  void _getIndex(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  void _editlocataire(int index) {
    var locataire = displayedLocataires[index]; // Get the locataire details
    nomController.text =
        locataire['nom']; // Populate the form field with the existing nom
    telephoneController.text = locataire[
        'telephone']; // Populate the form field with the existing telephone
    emailController.text =
        locataire['email']; // Populate the form field with the existing email
    adresseController.text = locataire[
        'adresse']; // Populate the form field with the existing adresse

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Edit locataire Details'),
          content: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  TextFormField(
                    controller: nomController,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.person),
                      labelText: 'Nom',
                    ),
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a nom';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: telephoneController,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.phone),
                      labelText: 'Telephone',
                    ),
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a Telephone';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: emailController,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.email),
                      labelText: 'Email',
                    ),
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter an email';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: adresseController,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.location_on),
                      labelText: 'Adress',
                    ),
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter an address';
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
                  // Update the locataire details in the database
                  var updatedLocataire = {
                    'id': locataire['id'],
                    'nom': nomController.text,
                    'telephone': telephoneController.text,
                    'email': emailController.text,
                    'adresse': adresseController.text,
                  };

                  // Make the API request to update the locataire
                  var locataireId = displayedLocataires[index]['id'];
                  client.ApiService.makeApiRequest(
                    'locataires/$locataireId',
                    'PUT',
                    updatedLocataire,
                  ).then((response) {
                    // Handle the response from the API

                    setState(() {
                      displayedLocataires[index] = updatedLocataire;
                    });

                    print('Locataire details updated');

                    Navigator.of(context).pop(); // Close the dialog

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Details updated'),
                      ),
                    );
                  }).catchError((error) {
                    // Handle any errors that occur during the API request
                    print('Error updating locataire details: $error');
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

  void _deletelocataire(int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirm Delete'),
          content: Text('Are you sure you want to delete this locataire?'),
          actions: <Widget>[
            ElevatedButton(
              child: Text('Delete'),
              onPressed: () {
                var locataireId = displayedLocataires[index]['id'];
                // Get the ID of the locataire
                client.ApiService.makeApiRequest(
                  'locataires/$locataireId', // Append the locataire ID to the API endpoint
                  'DELETE',
                  null,
                ).then((value) {
                  dynamic responseMap = value;
                  print(responseMap);
                });

                setState(() {
                  displayedLocataires.removeAt(index);
                });
                Navigator.of(context).pop(); // Close the dialog
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Locataire supprimé avec succès'),
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

  void _updatelocataire(int index) {
    var locataireId =
        displayedLocataires[index]['id']; // Get the ID of the locataire
    // Implement update functionality here using the locataireId
    print('Updating locataire with ID: $locataireId');
  }

  void _searchlocataires(String query) {
    setState(() {
      displayedLocataires = LocatairesList.where((locataire) =>
          locataire["nom"].toLowerCase().contains(query.toLowerCase()) ||
          locataire["email"].toLowerCase().contains(query.toLowerCase()) ||
          locataire["adresse"].toLowerCase().contains(query.toLowerCase()) ||
          locataire["telephone"]
              .toLowerCase()
              .contains(query.toLowerCase())).toList();
    });
  }

  void _addNewlocataire() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Add New Locataire'),
          content: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  TextFormField(
                    controller: nomController,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.person),
                      labelText: 'Nom',
                    ),
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a nom';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: telephoneController,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.phone),
                      labelText: 'Telephone',
                    ),
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a Telephone';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: emailController,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.email),
                      labelText: 'Email',
                    ),
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter an email';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: adresseController,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.location_on),
                      labelText: 'Adress',
                    ),
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter an address';
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
                  // Save the new locataire details
                  var newLocataire = {
                    'nom': nomController.text,
                    'telephone': telephoneController.text,
                    'email': emailController.text,
                    'adresse': adresseController.text,
                  };

                  // Make the API request to create a new locataire
                  client.ApiService.makeApiRequest(
                    'locataires',
                    'POST',
                    newLocataire,
                  ).then((response) {
                    // Handle the response from the API
                    print('New locataire added to the database');

                    // Update the displayedLocataires list with the new locataire details
                    setState(() {
                      displayedLocataires.add(newLocataire);
                    });

                    Navigator.of(context).pop(); // Close the dialog
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Locataire ajouté avec succès'),
                      ),
                    );
                  }).catchError((error) {
                    // Handle any errors that occur during the API request
                    print('Error adding new locataire: $error');
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
                onChanged: _searchlocataires,
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
        header: Text('Locataire List'),
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
          DataColumn(label: Text('Nom')),
          DataColumn(label: Text('Email')),
          DataColumn(label: Text('Telephone')),
          DataColumn(label: Text('Adresse')),
          DataColumn(label: Text('Actions')),
        ],
        source: MyDataTableSource(
          locataires: displayedLocataires,
          editlocataire: _editlocataire,
          deletelocataire: _deletelocataire,
          updatelocataire: _updatelocataire,
          getIndex: _getIndex,
          selectedIndex: selectedIndex,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addNewlocataire,
        child: Icon(Icons.add),
      ),
    );
  }
}

class MyDataTableSource extends DataTableSource {
  final List<Map<String, dynamic>> locataires;
  final Function(int) editlocataire;
  final Function(int) deletelocataire;
  final Function(int) updatelocataire;
  final Function(int) getIndex;
  final int? selectedIndex;
  MyDataTableSource({
    required this.locataires,
    required this.editlocataire,
    required this.deletelocataire,
    required this.updatelocataire,
    required this.getIndex,
    required this.selectedIndex,
  });

  @override
  DataRow getRow(int index) {
    final locataire = locataires[index];
    return DataRow(
        onSelectChanged: (bool? selected) {
          getIndex(index);
        },
        selected: selectedIndex == index ? true : false,
        cells: [
          DataCell(Text(locataire['nom'])),
          DataCell(Text(locataire['email'])),
          DataCell(Text(locataire['telephone'].toString())),
          DataCell(Text(locataire['adresse'].toString())),
          DataCell(Row(
            children: [
              IconButton(
                icon: Icon(Icons.edit, color: Colors.green),
                onPressed: () => editlocataire(index),
              ),
              IconButton(
                icon: Icon(
                  Icons.delete,
                  color: Colors.red,
                ),
                onPressed: () => deletelocataire(index),
              ),
              IconButton(
                icon: Icon(Icons.update, color: Colors.purple),
                onPressed: () => updatelocataire(index),
              ),
            ],
          )),
        ]);
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => locataires.length;

  @override
  int get selectedRowCount => 0;
}
