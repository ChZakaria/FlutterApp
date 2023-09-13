import 'dart:convert';

import 'package:flutter/material.dart';
import '../../api/apiService.dart' as client;
import 'models/intermediaire.dart';

class IntermediairesList extends StatefulWidget {
  @override
  _IntermediairesListState createState() => _IntermediairesListState();
}

class _IntermediairesListState extends State<IntermediairesList> {
  List<Map<String, dynamic>> intermediaireList = [];
  List<Map<String, dynamic>> displayedIntermediaires = [];

  TextEditingController nomController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController telephoneController = TextEditingController();
  TextEditingController adresseController = TextEditingController();
  TextEditingController searchController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  int? selectedIndex = -1;
  String? bearerToken;

  @override
  void initState() {
    super.initState();
    client.ApiService.makeApiRequest(
      'intermediaires',
      'GET',
      null,
    ).then((value) {
      dynamic responseMap = value;

      var intermediairesData = responseMap["intermediaires"];
      List<Intermediaire> intermediaires = [];

      for (var intermediaireJson in intermediairesData) {
        Intermediaire intermediaire = Intermediaire.fromJson(intermediaireJson);
        intermediaires.add(intermediaire);
        intermediaireList.add(intermediaireJson);
      }

      setState(() {
        displayedIntermediaires = List.from(intermediaireList);
      });
    });
  }

  void _getIndex(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  void _editIntermediaire(int index) {
    // Implement edit functionality here
    Intermediaire intermediaire =
        Intermediaire.fromJson(displayedIntermediaires[index]);
    
    nomController.text = intermediaire.nom;
    emailController.text = intermediaire.email;
    telephoneController.text = intermediaire.telephone;
    adresseController.text = intermediaire.adresse;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Edit Intermediaire Details'),
          content: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  TextFormField(
                    controller: nomController,
                    decoration: InputDecoration(
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
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
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
                    controller: telephoneController,
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      labelText: 'Telephone',
                    ),
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a telephone';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: adresseController,
                    decoration: InputDecoration(
                      labelText: 'Adresse',
                    ),
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter an adresse';
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
                  Intermediaire intermediaire = Intermediaire(
                    id: displayedIntermediaires[index]['id'],
                    nom: nomController.text,
                    email: emailController.text,
                    telephone: telephoneController.text,
                    adresse: adresseController.text,
                  );

                  client.ApiService.makeApiRequest(
                    'intermediaires/${intermediaire.id}',
                    'PUT',
                    intermediaire.toJson(),
                  ).then((response) {
                    setState(() {
                      displayedIntermediaires[index] = intermediaire.toJson();
                    });

                    print('Intermediaire details updated');

                    Navigator.of(context).pop();
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Details updated'),
                      ),
                    );
                  }).catchError((error) {
                    print('Error updating intermediaire details: $error');
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

  void _deleteIntermediaire(int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirm Delete'),
          content: Text('Are you sure you want to delete this intermediaire?'),
          actions: <Widget>[
            ElevatedButton(
              child: Text('Delete'),
              onPressed: () {
                var intermediaireId = displayedIntermediaires[index]['id'];

                client.ApiService.makeApiRequest(
                  'intermediaires/$intermediaireId',
                  'DELETE',
                  null,
                ).then((value) {
                  dynamic responseMap = value;
                  print(responseMap);
                });

                setState(() {
                  displayedIntermediaires.removeAt(index);
                });
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    backgroundColor: Colors.green,
                    content: Text('Intermediaire supprimé avec succès'),
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

  void _searchIntermediaires(String query) {
    setState(() {
      displayedIntermediaires = intermediaireList
          .where((intermediaire) =>
              intermediaire["nom"].toLowerCase().contains(query.toLowerCase()) ||
              intermediaire["email"].toLowerCase().contains(query.toLowerCase()) ||
              intermediaire["telephone"].toLowerCase().contains(query.toLowerCase()) ||
              intermediaire["adresse"].toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  void _addNewIntermediaire() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Add New Intermediaire'),
          content: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  TextFormField(
                    controller: nomController,
                    decoration: const InputDecoration(
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
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
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
                    controller: telephoneController,
                    keyboardType: TextInputType.phone,
                    decoration: const InputDecoration(
                      labelText: 'Telephone',
                    ),
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a telephone';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: adresseController,
                    decoration: const InputDecoration(
                      labelText: 'Adresse',
                    ),
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter an adresse';
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
                  Intermediaire intermediaire = Intermediaire(
                    id: 0, // Placeholder ID
                    nom: nomController.text,
                    email: emailController.text,
                    telephone: telephoneController.text,
                    adresse: adresseController.text,
                  );

                  client.ApiService.makeApiRequest(
                    'intermediaires',
                    'POST',
                    intermediaire.toJson(),
                  ).then((response) {
                    setState(() {
                      displayedIntermediaires.add(intermediaire.toJson());
                    });

                    print('Intermediaire details added');

                    Navigator.of(context).pop();
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Intermediaire added'),
                      ),
                    );
                  }).catchError((error) {
                    print('Error adding intermediaire details: $error');
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Intermediaire List'),
        actions: [
          Flexible(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: searchController,
                onChanged: _searchIntermediaires,
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
        header: Text('Intermediaire List'),
        showFirstLastButtons: true,
        rowsPerPage: 5,
        arrowHeadColor: Colors.purple,
        showCheckboxColumn: true,
        columns: const [
          DataColumn(label: Text('ID')),
          DataColumn(label: Text('Nom')),
          DataColumn(label: Text('Email')),
          DataColumn(label: Text('Telephone')),
          DataColumn(label: Text('Adresse')),
          DataColumn(label: Text('Actions')),
        ],
        source: MyDataTableSource(
          intermediaires: displayedIntermediaires,
          editIntermediaire: _editIntermediaire,
          deleteIntermediaire: _deleteIntermediaire,
          getIndex: _getIndex,
          selectedIndex: selectedIndex,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addNewIntermediaire,
        child: Icon(Icons.add),
      ),
    );
  }
}

class MyDataTableSource extends DataTableSource {
  final List<Map<String, dynamic>> intermediaires;
  final Function(int) editIntermediaire;
  final Function(int) deleteIntermediaire;
  final Function(int) getIndex;
  final int? selectedIndex;

  MyDataTableSource({
    required this.intermediaires,
    required this.editIntermediaire,
    required this.deleteIntermediaire,
    required this.getIndex,
    required this.selectedIndex,
  });

  @override
  DataRow getRow(int index) {
    final intermediaire = intermediaires[index];
    return DataRow(
      onSelectChanged: (bool? selected) {
        getIndex(index);
      },
      selected: selectedIndex == index ? true : false,
      cells: [
        DataCell(Text(intermediaire['id'].toString())),
        DataCell(Text(intermediaire['nom'])),
        DataCell(Text(intermediaire['email'])),
        DataCell(Text(intermediaire['telephone'])),
        DataCell(Text(intermediaire['adresse'])),
        DataCell(
          Row(
            children: [
              IconButton(
                icon: Icon(Icons.edit, color: Colors.green),
                onPressed: () => editIntermediaire(index),
              ),
              IconButton(
                icon: Icon(
                  Icons.delete,
                  color: Colors.red,
                ),
                onPressed: () => deleteIntermediaire(index),
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
  int get rowCount => intermediaires.length;

  @override
  int get selectedRowCount => 0;
}
