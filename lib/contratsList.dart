import 'dart:convert';

import 'package:flutter/material.dart';
import '../../api/apiService.dart' as client;
import 'models/contrat.dart';

class ContratList extends StatefulWidget {
  @override
  _ContratListState createState() => _ContratListState();
}

class _ContratListState extends State<ContratList> {
  List<Map<String, dynamic>> contratList = [];
  List<Map<String, dynamic>> displayedContrats = [];

  TextEditingController locataireIdController = TextEditingController();
  TextEditingController vehiculeIdController = TextEditingController();
  TextEditingController dateLocationController = TextEditingController();
  TextEditingController dateRetourController = TextEditingController();
  TextEditingController prixUController = TextEditingController();
  TextEditingController montantRestController = TextEditingController();
  TextEditingController montantAvanceController = TextEditingController();
  TextEditingController montantTotalController = TextEditingController();
  TextEditingController statutController = TextEditingController();
  TextEditingController intermediaireController = TextEditingController();
  TextEditingController lieuDepartController = TextEditingController();
  TextEditingController lieuRetourController = TextEditingController();
  TextEditingController kmDepartController = TextEditingController();
  TextEditingController kmRetourController = TextEditingController();
  TextEditingController observationController = TextEditingController();
  TextEditingController searchController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  int? selectedIndex = -1;
  String? bearerToken;

  @override
  void initState() {
    super.initState();
    client.ApiService.makeApiRequest(
      'contrats',
      'GET',
      null,
    ).then((value) {
      dynamic responseMap = value;

      var contratsData = responseMap["contrats"];
      List<Contrat> contrats = [];

      for (var contratJson in contratsData) {
        Contrat contrat = Contrat.fromJson(contratJson);
        contrats.add(contrat);
        contratList.add(contratJson);
      }

      setState(() {
        displayedContrats = List.from(contratList);
      });
    });
  }

  void _getIndex(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  void _editContrat(int index) {
    Contrat contrat = Contrat.fromJson(displayedContrats[index]);

    locataireIdController.text = contrat.locataireId.toString();
    vehiculeIdController.text = contrat.vehiculeId.toString();
    dateLocationController.text = contrat.dateLocation.toString();
    dateRetourController.text = contrat.dateRetour.toString();
    prixUController.text = contrat.prixU.toString();
    montantRestController.text = contrat.montantRest.toString();
    montantAvanceController.text = contrat.montantAvance.toString();
    montantTotalController.text = contrat.montantTotal.toString();
    statutController.text = contrat.statut;
    intermediaireController.text = contrat.intermediaire;
    lieuDepartController.text = contrat.lieuDepart;
    lieuRetourController.text = contrat.lieuRetour;
    kmDepartController.text = contrat.kmDepart.toString();
    kmRetourController.text = contrat.kmRetour.toString();
    observationController.text = contrat.observation;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Edit Contrat Details'),
          content: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  TextFormField(
                    controller: locataireIdController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: 'Locataire ID',
                    ),
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a locataire ID';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: vehiculeIdController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: 'Vehicule ID',
                    ),
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a vehicule ID';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: dateLocationController,
                    decoration: InputDecoration(
                      labelText: 'Date Location',
                    ),
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a date location';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: dateRetourController,
                    decoration: InputDecoration(
                      labelText: 'Date Retour',
                    ),
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a date retour';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: prixUController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: 'Prix U',
                    ),
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a prix U';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: montantRestController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: 'Montant Rest',
                    ),
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a montant rest';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: montantAvanceController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: 'Montant Avance',
                    ),
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a montant avance';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: montantTotalController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: 'Montant Total',
                    ),
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a montant total';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: statutController,
                    decoration: InputDecoration(
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
                    controller: intermediaireController,
                    decoration: InputDecoration(
                      labelText: 'Intermediaire',
                    ),
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter an intermediaire';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: lieuDepartController,
                    decoration: InputDecoration(
                      labelText: 'Lieu Depart',
                    ),
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a lieu depart';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: lieuRetourController,
                    decoration: InputDecoration(
                      labelText: 'Lieu Retour',
                    ),
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a lieu retour';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: kmDepartController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: 'Km Depart',
                    ),
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a km depart';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: kmRetourController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: 'Km Retour',
                    ),
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a km retour';
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
                        return 'Please enter an observation';
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
                  int id = displayedContrats[index]['id'];
                  int locataireId = int.parse(locataireIdController.text);
                  int vehiculeId = int.parse(vehiculeIdController.text);
                  String dateLocation = dateLocationController.text;
                  String dateRetour = dateRetourController.text;
                  double prixU = double.parse(prixUController.text);
                  double montantRest = double.parse(montantRestController.text);
                  double montantAvance =
                      double.parse(montantAvanceController.text);
                  double montantTotal =
                      double.parse(montantTotalController.text);
                  String statut = statutController.text;
                  String intermediaire = intermediaireController.text;
                  String lieuDepart = lieuDepartController.text;
                  String lieuRetour = lieuRetourController.text;
                  int kmDepart = int.parse(kmDepartController.text);
                  int kmRetour = int.parse(kmRetourController.text);
                  String observation = observationController.text;

                  Contrat contrat = Contrat(
                      id: id,
                      locataireId: locataireId,
                      vehiculeId: vehiculeId,
                      dateLocation: DateTime.parse(dateLocation),
                      dateRetour: DateTime.parse(dateRetour),
                      prixU: prixU,
                      montantRest: montantRest,
                      montantAvance: montantAvance,
                      montantTotal: montantTotal,
                      statut: statut,
                      intermediaire: intermediaire,
                      lieuDepart: lieuDepart,
                      lieuRetour: lieuRetour,
                      kmDepart: kmDepart,
                      kmRetour: kmRetour,
                      observation: observation,
                      creeLe: DateTime.now(),
                      misAJourLe: DateTime.now());

                  client.ApiService.makeApiRequest(
                    'contrats/$id',
                    'PUT',
                    contrat.toJson(),
                  ).then((response) {
                    setState(() {
                      displayedContrats[index] = contrat.toJson();
                    });

                    print('contrat details updated');

                    Navigator.of(context).pop();
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Details updated'),
                      ),
                    );
                  }).catchError((error) {
                    print('Error updating contrat details: $error');
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

  void _deleteContrat(int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirm Delete'),
          content: Text('Are you sure you want to delete this contrat?'),
          actions: <Widget>[
            ElevatedButton(
              child: Text('Delete'),
              onPressed: () {
                var contratId = displayedContrats[index]['id'];
                client.ApiService.makeApiRequest(
                  'contrats/$contratId',
                  'DELETE',
                  null,
                ).then((value) {
                  dynamic responseMap = value;
                  print(responseMap);
                });

                setState(() {
                  displayedContrats.removeAt(index);
                });
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    backgroundColor: Colors.green,
                    content: Text('Contrat deleted successfully'),
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

  void _addNewContrat() {
    locataireIdController.text = "";
    vehiculeIdController.text = "";
    dateLocationController.text = "";
    dateRetourController.text = "";
    prixUController.text = "";
    montantRestController.text = "";
    montantAvanceController.text = "";
    montantTotalController.text = "";
    statutController.text = "";
    intermediaireController.text = "";
    lieuDepartController.text = "";
    lieuRetourController.text = "";
    kmDepartController.text = "";
    kmRetourController.text = "";
    observationController.text = "";
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Add New Contrat'),
          content: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  TextFormField(
                    controller: locataireIdController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: 'Locataire ID',
                    ),
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a locataire ID';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: vehiculeIdController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: 'Vehicule ID',
                    ),
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a vehicule ID';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: dateLocationController,
                    decoration: InputDecoration(
                      labelText: 'Date Location',
                    ),
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a date location';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: dateRetourController,
                    decoration: InputDecoration(
                      labelText: 'Date Retour',
                    ),
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a date retour';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: prixUController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: 'Prix U',
                    ),
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a prix U';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: montantRestController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: 'Montant Rest',
                    ),
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a montant rest';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: montantAvanceController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: 'Montant Avance',
                    ),
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a montant avance';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: montantTotalController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: 'Montant Total',
                    ),
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a montant total';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: statutController,
                    decoration: InputDecoration(
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
                    controller: intermediaireController,
                    decoration: InputDecoration(
                      labelText: 'Intermediaire',
                    ),
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter an intermediaire';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: lieuDepartController,
                    decoration: InputDecoration(
                      labelText: 'Lieu Depart',
                    ),
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a lieu depart';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: lieuRetourController,
                    decoration: InputDecoration(
                      labelText: 'Lieu Retour',
                    ),
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a lieu retour';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: kmDepartController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: 'Km Depart',
                    ),
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a km depart';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: kmRetourController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: 'Km Retour',
                    ),
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a km retour';
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
                        return 'Please enter an observation';
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
                  Contrat contrat = Contrat(
                      id: contratList.last["id"] + 1, // Generate a unique ID
                      locataireId: int.parse(locataireIdController.text),
                      vehiculeId: int.parse(vehiculeIdController.text),
                      dateLocation: DateTime.parse(dateLocationController.text),
                      dateRetour: DateTime.parse(dateRetourController.text),
                      prixU: double.parse(prixUController.text),
                      montantRest: double.parse(montantRestController.text),
                      montantAvance: double.parse(montantAvanceController.text),
                      montantTotal: double.parse(montantTotalController.text),
                      statut: statutController.text,
                      intermediaire: intermediaireController.text,
                      lieuDepart: lieuDepartController.text,
                      lieuRetour: lieuRetourController.text,
                      kmDepart: int.parse(kmDepartController.text),
                      kmRetour: int.parse(kmRetourController.text),
                      observation: observationController.text,
                      creeLe: DateTime.now(),
                      misAJourLe: DateTime.now());

                  client.ApiService.makeApiRequest(
                    'contrats',
                    'POST',
                    contrat.toJson(),
                  ).then((response) {
                    setState(() {
                      displayedContrats.add(contrat.toJson());
                    });

                    print('contrat details added');

                    Navigator.of(context).pop();
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Contrat added'),
                      ),
                    );
                  }).catchError((error) {
                    print('Error adding contrat details: $error');
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

  void _searchContrats(String query) {
    setState(() {
      displayedContrats = contratList
          .where((contrat) =>
              contrat["locataire_id"].toString().contains(query) ||
              contrat["vehicule_id"].toString().contains(query) ||
              contrat["date_location"]
                  .toLowerCase()
                  .contains(query.toLowerCase()) ||
              contrat["date_retour"]
                  .toLowerCase()
                  .contains(query.toLowerCase()) ||
              contrat["statut"].toLowerCase().contains(query.toLowerCase()) ||
              contrat["intermediaire"]
                  .toLowerCase()
                  .contains(query.toLowerCase()) ||
              contrat["lieu_depart"]
                  .toLowerCase()
                  .contains(query.toLowerCase()) ||
              contrat["lieu_retour"]
                  .toLowerCase()
                  .contains(query.toLowerCase()) ||
              contrat["observation"]
                  .toLowerCase()
                  .contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contrat List'),
        actions: [
          Flexible(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: searchController,
                onChanged: _searchContrats,
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
        header: Text('Contrat List'),
        showFirstLastButtons: true,
        rowsPerPage: 5,
        columns: const [
          DataColumn(label: Text('ID')),
          DataColumn(label: Text('Locataire ID')),
          DataColumn(label: Text('Vehicule ID')),
          DataColumn(label: Text('Date Location')),
          DataColumn(label: Text('Date Retour')),
          DataColumn(label: Text('Statut')),
          DataColumn(label: Text('Actions')),
        ],
        source: MyDataTableSource(
          contrats: displayedContrats,
          editContrat: _editContrat,
          deleteContrat: _deleteContrat,
          getIndex: _getIndex,
          selectedIndex: selectedIndex,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addNewContrat,
        child: Icon(Icons.add),
      ),
    );
  }
}

class MyDataTableSource extends DataTableSource {
  final List<Map<String, dynamic>> contrats;
  final Function(int) editContrat;
  final Function(int) deleteContrat;
  final Function(int) getIndex;
  final int? selectedIndex;

  MyDataTableSource({
    required this.contrats,
    required this.editContrat,
    required this.deleteContrat,
    required this.getIndex,
    required this.selectedIndex,
  });

  @override
  DataRow getRow(int index) {
    final contrat = contrats[index];
    return DataRow(
      onSelectChanged: (bool? selected) {
        getIndex(index);
      },
      selected: selectedIndex == index ? true : false,
      cells: [
        DataCell(Text(contrat['id'].toString())),
        DataCell(Text(contrat['locataire_id'].toString())),
        DataCell(Text(contrat['vehicule_id'].toString())),
        DataCell(Text(contrat['date_location'])),
        DataCell(Text(contrat['date_retour'])),
        DataCell(Text(contrat['statut'])),
        DataCell(
          Row(
            children: [
              IconButton(
                icon: Icon(Icons.edit, color: Colors.green),
                onPressed: () => editContrat(index),
              ),
              IconButton(
                icon: Icon(
                  Icons.delete,
                  color: Colors.red,
                ),
                onPressed: () => deleteContrat(index),
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
  int get rowCount => contrats.length;

  @override
  int get selectedRowCount => 0;
}
