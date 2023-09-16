import 'dart:convert';

import 'package:flutter/material.dart';
import '../../api/apiService.dart' as client;
import 'models/supplement.dart';

class SupplementList extends StatefulWidget {
  @override
  _SupplementListState createState() => _SupplementListState();
}

class _SupplementListState extends State<SupplementList> {
  List<Map<String, dynamic>> supplementList = [];
  List<Map<String, dynamic>> displayedSupplements = [];

  TextEditingController montantController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController searchController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  int? selectedIndex = -1;
  String? bearerToken;
  String? _selectedOption;

  List<String> _options = [];

  @override
  void initState() {
    super.initState();
    client.ApiService.makeApiRequest(
      'supplements',
      'GET',
      null,
    ).then((value) {
      dynamic responseMap = value;

      var supplementsData = responseMap["supplements"];
      List<Supplement> supplements = [];

      for (var supplementJson in supplementsData) {
        Supplement supplement = Supplement.fromJson(supplementJson);
        supplements.add(supplement);
        supplementList.add(supplementJson);
      }

      setState(() {
        displayedSupplements = List.from(supplementList);
      });
    });
    client.ApiService.makeApiRequest(
      'contratsIds',
      'GET',
      null,
    ).then((value) {
      dynamic responseMap = value;

      var optionsData = responseMap["ids"];

      for (var optionJson in optionsData) {
        _options.add(optionJson.toString());
      }
    });
  }

  void _getIndex(int index) {
    // Implement your logic here
    setState(() {
      selectedIndex = index;
    });
  }

  void _searchSupplements(String query) {
    setState(() {
      displayedSupplements = supplementList
          .where((supplement) =>
              supplement["id"].toLowerCase().contains(query.toLowerCase()) ||
              supplement["contrat_id"]
                  .toLowerCase()
                  .contains(query.toLowerCase()) ||
              supplement["montant"]
                  .toLowerCase()
                  .contains(query.toLowerCase()) ||
              supplement["discription"]
                  .toLowerCase()
                  .contains(query.toLowerCase()))
          .toList();
    });
  }

  void _editSupplement(int index) {
    // Implement edit functionality here
    Supplement supplement = Supplement.fromJson(displayedSupplements[index]);

    montantController.text = supplement.montant;
    descriptionController.text = supplement.description;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Edit Supplement Details'),
          content: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  DropdownButtonFormField<String>(
                    value: _selectedOption,
                    items: _options.map((String option) {
                      return DropdownMenuItem<String>(
                        value: option,
                        child: Text(option),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        _selectedOption = newValue;
                      });
                    },
                    decoration: InputDecoration(
                      labelText: 'Select an option',
                    ),
                  ),
                  TextFormField(
                    controller: montantController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
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
                      labelText: 'Description',
                    ),
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a description';
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
                  int id = displayedSupplements[index]['id'];
                  int contratId = displayedSupplements[index]['contrat_id'];
                  String montant = montantController.text;
                  String description = descriptionController.text;

                  Supplement supplement = Supplement(
                    id: id,
                    contratId: contratId,
                    montant: montant,
                    description: description,
                  );

                  // Make the API request to update the supplement
                  client.ApiService.makeApiRequest(
                    'supplements/$id',
                    'PUT',
                    supplement.toJson(),
                  ).then((response) {
                    setState(() {
                      displayedSupplements[index] = supplement.toJson();
                    });

                    print('supplement details updated');

                    Navigator.of(context).pop(); // Close the dialog

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Details updated'),
                      ),
                    );
                  }).catchError((error) {
                    print('Error updating supplement details: $error');
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

  void _deleteSupplement(int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirm Delete'),
          content: Text('Are you sure you want to delete this supplement?'),
          actions: <Widget>[
            ElevatedButton(
              child: Text('Delete'),
              onPressed: () {
                var supplementId = displayedSupplements[index]['id'];
                client.ApiService.makeApiRequest(
                  'supplements/$supplementId',
                  'DELETE',
                  null,
                ).then((value) {
                  dynamic responseMap = value;
                  print(responseMap);
                });

                setState(() {
                  displayedSupplements.removeAt(index);
                });
                Navigator.of(context).pop(); // Close the dialog
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    backgroundColor: Colors.green,
                    content: Text('Supplement deleted successfully'),
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

  void _addNewSupplement() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Add New Supplement'),
          content: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  DropdownButtonFormField<String>(
                    value: _selectedOption,
                    items: _options.map((String option) {
                      return DropdownMenuItem<String>(
                        value: option,
                        child: Text(option),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        _selectedOption = newValue;
                      });
                    },
                    decoration: InputDecoration(
                      labelText: 'Select an option',
                    ),
                  ),
                  TextFormField(
                    controller: montantController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
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
                      labelText: 'Description',
                    ),
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a description';
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
                  int id = 0; // Assign a unique ID (if applicable)
                  int contratId = 1; // Assign a contrat ID (if applicable)
                  String montant = montantController.text;
                  String description = descriptionController.text;

                  Supplement supplement = Supplement(
                    id: id,
                    contratId: contratId,
                    montant: montant,
                    description: description,
                  );

                  // Make the API request to add the supplement
                  client.ApiService.makeApiRequest(
                    'supplements',
                    'POST',
                    supplement.toJson(),
                  ).then((response) {
                    setState(() {
                      displayedSupplements.add(supplement.toJson());
                    });

                    print('supplement details added');

                    Navigator.of(context).pop(); // Close the dialog

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Supplement added'),
                      ),
                    );
                  }).catchError((error) {
                    print('Error adding supplement details: $error');
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
        title: Text('Supplement List'),
        actions: [
          Flexible(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: searchController,
                onChanged: _searchSupplements,
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
        header: Text('Supplement List'),
        showFirstLastButtons: true,
        rowsPerPage: 5,
        columns: const [
          DataColumn(label: Text('ID')),
          DataColumn(label: Text('Contrat ID')),
          DataColumn(label: Text('Montant')),
          DataColumn(label: Text('Description')),
          DataColumn(label: Text('Actions')),
        ],
        source: MyDataTableSource(
          supplements: displayedSupplements,
          editSupplement: _editSupplement,
          deleteSupplement: _deleteSupplement,
          getIndex: _getIndex,
          selectedIndex: selectedIndex,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addNewSupplement,
        child: Icon(Icons.add),
      ),
    );
  }
}

class MyDataTableSource extends DataTableSource {
  final List<Map<String, dynamic>> supplements;
  final Function(int) editSupplement;
  final Function(int) deleteSupplement;
  final Function(int) getIndex;
  final int? selectedIndex;

  MyDataTableSource({
    required this.supplements,
    required this.editSupplement,
    required this.deleteSupplement,
    required this.getIndex,
    required this.selectedIndex,
  });

  @override
  DataRow getRow(int index) {
    final supplement = supplements[index];
    return DataRow(
      onSelectChanged: (bool? selected) {
        getIndex(index);
      },
      selected: selectedIndex == index ? true : false,
      cells: [
        DataCell(Text(supplement['id'].toString())),
        DataCell(Text(supplement['contrat_id'].toString())),
        DataCell(Text(supplement['montant'])),
        DataCell(Text(supplement['description'])),
        DataCell(
          Row(
            children: [
              IconButton(
                icon: Icon(Icons.edit, color: Colors.green),
                onPressed: () => editSupplement(index),
              ),
              IconButton(
                icon: Icon(
                  Icons.delete,
                  color: Colors.red,
                ),
                onPressed: () => deleteSupplement(index),
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
  int get rowCount => supplements.length;

  @override
  int get selectedRowCount => 0;
}
