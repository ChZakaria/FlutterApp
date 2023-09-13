import 'dart:convert';

import 'package:flutter/material.dart';
import '../../api/apiService.dart' as client;
import 'models/fournisseur.dart';

class FournisseurList extends StatefulWidget {
  @override
  _FournisseurListState createState() => _FournisseurListState();
}

class _FournisseurListState extends State<FournisseurList> {
  List<Map<String, dynamic>> fournisseurList = [];
  List<Map<String, dynamic>> displayedFournisseurs = [];

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
      'fournisseurs',
      'GET',
      null,
    ).then((value) {
      dynamic responseMap = value;

      var fournisseursData = responseMap["fournisseurs"];
      List<Fournisseur> fournisseurs = [];

      for (var fournisseurJson in fournisseursData) {
        Fournisseur fournisseur = Fournisseur.fromJson(fournisseurJson);
        fournisseurs.add(fournisseur);
        fournisseurList.add(fournisseurJson);
      }

      setState(() {
        displayedFournisseurs = List.from(fournisseurList);
      });
    });
  }

  void _getIndex(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  void _editFournisseur(int index) {
    Fournisseur fournisseur =
        Fournisseur.fromJson(displayedFournisseurs[index]);

    nomController.text = fournisseur.nom;
    emailController.text = fournisseur.email;
    telephoneController.text = fournisseur.telephone;
    adresseController.text = fournisseur.adresse;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Edit Fournisseur Details'),
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
                  int id = displayedFournisseurs[index]['id'];
                  String nom = nomController.text;
                  String email = emailController.text;
                  String telephone = telephoneController.text;
                  String adresse = adresseController.text;

                  Fournisseur fournisseur = Fournisseur(
                    id: id,
                    nom: nom,
                    email: email,
                    telephone: telephone,
                    adresse: adresse,
                  );

                  client.ApiService.makeApiRequest(
                    'fournisseurs/$id',
                    'PUT',
                    fournisseur.toJson(),
                  ).then((response) {
                    setState(() {
                      displayedFournisseurs[index] = fournisseur.toJson();
                    });

                    print('fournisseur details updated');

                    Navigator.of(context).pop();
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Details updated'),
                      ),
                    );
                  }).catchError((error) {
                    print('Error updating fournisseur details: $error');
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

  void _deleteFournisseur(int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirm Delete'),
          content: Text('Are you sure you want to delete this fournisseur?'),
          actions: <Widget>[
            ElevatedButton(
              child: Text('Delete'),
              onPressed: () {
                var fournisseurId = displayedFournisseurs[index]['id'];
                client.ApiService.makeApiRequest(
                  'fournisseurs/$fournisseurId',
                  'DELETE',
                  null,
                ).then((value) {
                  dynamic responseMap = value;
                  print(responseMap);
                });

                setState(() {
                  displayedFournisseurs.removeAt(index);
                });
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    backgroundColor: Colors.green,
                    content: Text('Fournisseur deleted successfully'),
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

  void _addNewFournisseur() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Add New Fournisseur'),
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
                  Fournisseur fournisseur = Fournisseur(
                    id: fournisseurList.length + 1, // Generate a unique ID
                    nom: nomController.text,
                    email: emailController.text,
                    telephone: telephoneController.text,
                    adresse: adresseController.text,
                  );

                  client.ApiService.makeApiRequest(
                    'fournisseurs',
                    'POST',
                    fournisseur.toJson(),
                  ).then((response) {
                    setState(() {
                      displayedFournisseurs.add(fournisseur.toJson());
                    });

                    print('fournisseur details added');

                    Navigator.of(context).pop();
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Fournisseur added'),
                      ),
                    );
                  }).catchError((error) {
                    print('Error adding fournisseur details: $error');
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

  void _searchFournisseurs(String query) {
    setState(() {
      displayedFournisseurs = fournisseurList
          .where((fournisseur) =>
              fournisseur["nom"].toLowerCase().contains(query.toLowerCase()) ||
              fournisseur["email"]
                  .toLowerCase()
                  .contains(query.toLowerCase()) ||
              fournisseur["telephone"]
                  .toLowerCase()
                  .contains(query.toLowerCase()) ||
              fournisseur["adresse"]
                  .toLowerCase()
                  .contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Fournisseur List'),
        actions: [
          Flexible(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: searchController,
                onChanged: _searchFournisseurs,
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
        header: Text('Fournisseur List'),
        showFirstLastButtons: true,
        rowsPerPage: 5,
        columns: const [
          DataColumn(label: Text('ID')),
          DataColumn(label: Text('Nom')),
          DataColumn(label: Text('Email')),
          DataColumn(label: Text('Telephone')),
          DataColumn(label: Text('Adresse')),
          DataColumn(label: Text('Actions')),
        ],
        source: MyDataTableSource(
          fournisseurs: displayedFournisseurs,
          editFournisseur: _editFournisseur,
          deleteFournisseur: _deleteFournisseur,
          getIndex: _getIndex,
          selectedIndex: selectedIndex
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addNewFournisseur,
        child: Icon(Icons.add),
      ),
    );
  }
}

class MyDataTableSource extends DataTableSource {
  final List<Map<String, dynamic>> fournisseurs;
  final Function(int) editFournisseur;
  final Function(int) deleteFournisseur;
  final Function(int) getIndex;
  final int? selectedIndex;

  MyDataTableSource({
    required this.fournisseurs,
    required this.editFournisseur,
    required this.deleteFournisseur,
    required this.getIndex,
    required this.selectedIndex,
  });

  @override
  DataRow getRow(int index) {
    final fournisseur = fournisseurs[index];
    return DataRow(
      onSelectChanged: (bool? selected) {
        getIndex(index);
      },
      selected: selectedIndex == index ? true : false,
      cells: [
        DataCell(Text(fournisseur['id'].toString())),
        DataCell(Text(fournisseur['nom'])),
        DataCell(Text(fournisseur['email'])),
        DataCell(Text(fournisseur['telephone'])),
        DataCell(Text(fournisseur['adresse'])),
        DataCell(
          Row(
            children: [
              IconButton(
                icon: Icon(Icons.edit, color: Colors.green),
                onPressed: () => editFournisseur(index),
              ),
              IconButton(
                icon: Icon(
                  Icons.delete,
                  color: Colors.red,
                ),
                onPressed: () => deleteFournisseur(index),
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
  int get rowCount => fournisseurs.length;

  @override
  int get selectedRowCount => 0;
}
