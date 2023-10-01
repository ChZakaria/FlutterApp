import 'dart:convert';
import 'dart:js_util';

import 'package:flutter/material.dart';
import '../../api/apiService.dart' as client;
import '../models/additionalCharge.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AdditionalChargeList extends StatefulWidget {
  @override
  _AdditionalChargeListState createState() => _AdditionalChargeListState();
}

class _AdditionalChargeListState extends State<AdditionalChargeList> {
  List<Map<String, dynamic>> additionalChargesList = [];
  List<Map<String, dynamic>> displayedAdditionalCharge = [];

  TextEditingController contractIdController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController typeController = TextEditingController();
  TextEditingController quantityController = TextEditingController();
  TextEditingController unitPriceController = TextEditingController();
  TextEditingController totalPriceController = TextEditingController();
  TextEditingController searchController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  int? selectedIndex = -1;
  String? bearerToken;

  @override
  void initState() {
    super.initState();
    // Fetch additional-charge

    client.ApiService.makeApiRequest(
      'additional-charge',
      'GET',
      null,
    ).then((value) {
      dynamic responseMap = value;

      var additionalChargeData = responseMap["AdditionalCharges"];
      List<AdditionalCharge> additionalCharges = [];

      for (var additionalChargeJson in additionalChargeData) {
        AdditionalCharge additionalCharge =
            AdditionalCharge.fromJson(additionalChargeJson);
        additionalCharges.add(additionalCharge);
        additionalChargesList.add(additionalChargeJson);
      }
      setState(() {
        displayedAdditionalCharge = List.from(additionalChargesList);
      });
    });
  }

  void _getIndex(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  void _editAdditionalCharge(int index) {
    // Implement edit functionality here
    AdditionalCharge additionalCharge =
        AdditionalCharge.fromJson(displayedAdditionalCharge[index]);

    contractIdController.text = additionalCharge.contractId.toString();
    nameController.text = additionalCharge.chargeName;
    typeController.text = additionalCharge.chargeType;
    quantityController.text = additionalCharge.quantity.toString();
    unitPriceController.text = additionalCharge.unitPrice.toString();
    totalPriceController.text = additionalCharge.totalPrice.toString();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Edit Additional Charge Details'),
          content: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  TextFormField(
                    controller: contractIdController,
                    decoration: InputDecoration(
                      labelText: 'ContratID',
                    ),
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a Contrat id';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: nameController,
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
                    controller: typeController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      labelText: 'Type',
                    ),
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter an type';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: quantityController,
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      labelText: 'Quantity',
                    ),
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a Quantity';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: unitPriceController,
                    decoration: InputDecoration(
                      labelText: 'unitPrice',
                    ),
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter an unitPrice';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: totalPriceController,
                    decoration: InputDecoration(
                      labelText: 'totalPrice',
                    ),
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter an totalPrice';
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
                  AdditionalCharge additionalCharge = AdditionalCharge(
                    additionalChargeId: displayedAdditionalCharge[index]['id'],
                    contractId: int.parse(contractIdController.text.toString()),
                    chargeName: nameController.text,
                    chargeType: typeController.text,
                    quantity: int.parse(quantityController.text.toString()),
                    unitPrice:
                        double.parse(unitPriceController.text.toString()),
                    totalPrice:
                        double.parse(totalPriceController.text.toString()),
                    createdAt: DateTime.now(),
                    updatedAt: DateTime.now(),
                  );

                  client.ApiService.makeApiRequest(
                    'additional-charge/${additionalCharge.additionalChargeId}',
                    'PUT',
                    additionalCharge.toJson(),
                  ).then((response) {
                    setState(() {
                      displayedAdditionalCharge[index] =
                          additionalCharge.toJson();
                    });

                    print('Additional Charge details updated');

                    Navigator.of(context).pop();
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Details updated'),
                      ),
                    );
                  }).catchError((error) {
                    print('Error updating Additional Charge details: $error');
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

  void _deleteAdditionalCharge(int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirm Delete'),
          content:
              Text('Are you sure you want to delete this Additional Charge?'),
          actions: <Widget>[
            ElevatedButton(
              child: Text('Delete'),
              onPressed: () {
                var additionalChargeId = displayedAdditionalCharge[index]['id'];

                client.ApiService.makeApiRequest(
                  'additional-charge/$additionalChargeId',
                  'DELETE',
                  null,
                ).then((value) {
                  dynamic responseMap = value;
                  print(responseMap);
                });

                setState(() {
                  displayedAdditionalCharge.removeAt(index);
                });
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    backgroundColor: Colors.green,
                    content: Text('Additional Charge supprimé avec succès'),
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

  void _searchAdditionalCharge(String query) {
    setState(() {
      displayedAdditionalCharge = additionalChargesList
          .where((additionalCharge) =>
              additionalCharge["name"]
                  .toLowerCase()
                  .contains(query.toLowerCase()) ||
              additionalCharge["type"]
                  .toLowerCase()
                  .contains(query.toLowerCase()) ||
              additionalCharge["quantity"]
                  .toLowerCase()
                  .contains(query.toLowerCase()) ||
              additionalCharge["unitPrice"]
                  .toLowerCase()
                  .contains(query.toLowerCase()))
          .toList();
    });
  }

  void _addNewAdditionalCharge() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Add New Additional Charge'),
          content: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  TextFormField(
                    controller: contractIdController,
                    decoration: InputDecoration(
                      labelText: 'ContratID',
                    ),
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a Contrat id';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: nameController,
                    decoration: const InputDecoration(
                      labelText: 'Name',
                    ),
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a name';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: typeController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      labelText: 'Type',
                    ),
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter an type';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: quantityController,
                    keyboardType: TextInputType.phone,
                    decoration: const InputDecoration(
                      labelText: 'quantity',
                    ),
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a quantity';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: unitPriceController,
                    decoration: const InputDecoration(
                      labelText: 'unitPrice',
                    ),
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter an unitPrice';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: totalPriceController,
                    decoration: const InputDecoration(
                      labelText: 'TotalPrice',
                    ),
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a totalPrice';
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
                  AdditionalCharge additionalCharge = AdditionalCharge(
                    additionalChargeId: 0,
                    contractId: int.parse(contractIdController.text.toString()),
                    chargeName: nameController.text,
                    chargeType: typeController.text,
                    quantity: int.parse(quantityController.text.toString()),
                    unitPrice:
                        double.parse(unitPriceController.text.toString()),
                    totalPrice:
                        double.parse(totalPriceController.text.toString()),
                    createdAt: DateTime.now(),
                    updatedAt: DateTime.now(),
                  );

                  client.ApiService.makeApiRequest(
                    'additional-charge',
                    'POST',
                    additionalCharge.toJson(),
                  ).then((response) {
                    setState(() {
                      displayedAdditionalCharge.add(additionalCharge.toJson());
                    });

                    print('additional charge details added');

                    Navigator.of(context).pop();
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('additional charge added'),
                      ),
                    );
                  }).catchError((error) {
                    print('Error adding additional charge details: $error');
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
        title: Text('Additional Charge List'),
        actions: [
          Flexible(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: searchController,
                onChanged: _searchAdditionalCharge,
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
        header: Text('Additional Charge List'),
        showFirstLastButtons: true,
        rowsPerPage: 5,
        arrowHeadColor: Colors.purple,
        showCheckboxColumn: true,
        columns: const [
          DataColumn(label: Text('ID')),
          DataColumn(label: Text('Name')),
          DataColumn(label: Text('Type')),
          DataColumn(label: Text('Quantity')),
          DataColumn(label: Text('UnitPrice')),
          DataColumn(label: Text('TotalPrice')),
          DataColumn(label: Text('Actions')),
        ],
        source: MyDataTableSource(
          additionalCharges: displayedAdditionalCharge,
          editAdditionalCharge: _editAdditionalCharge,
          deleteAdditionalCharge: _deleteAdditionalCharge,
          getIndex: _getIndex,
          selectedIndex: selectedIndex,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addNewAdditionalCharge,
        child: Icon(Icons.add),
      ),
    );
  }
}

class MyDataTableSource extends DataTableSource {
  final List<Map<String, dynamic>> additionalCharges;
  final Function(int) editAdditionalCharge;
  final Function(int) deleteAdditionalCharge;
  final Function(int) getIndex;
  final int? selectedIndex;

  MyDataTableSource({
    required this.additionalCharges,
    required this.editAdditionalCharge,
    required this.deleteAdditionalCharge,
    required this.getIndex,
    required this.selectedIndex,
  });

  @override
  DataRow getRow(int index) {
    final additionalCharge = additionalCharges[index];
    return DataRow(
      onSelectChanged: (bool? selected) {
        getIndex(index);
      },
      selected: selectedIndex == index ? true : false,
      cells: [
        DataCell(Text(additionalCharge['AdditionalChargeId'].toString())),
        DataCell(Text(additionalCharge['ChargeName'])),
        DataCell(Text(additionalCharge['ChargeType'])),
        DataCell(Text(additionalCharge['Quantity'].toString())),
        DataCell(Text(additionalCharge['UnitPrice'])),
        DataCell(Text(additionalCharge['TotalPrice'])),
        DataCell(
          Row(
            children: [
              IconButton(
                icon: Icon(Icons.edit, color: Colors.green),
                onPressed: () => editAdditionalCharge(index),
              ),
              IconButton(
                icon: Icon(
                  Icons.delete,
                  color: Colors.red,
                ),
                onPressed: () => deleteAdditionalCharge(index),
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
  int get rowCount => additionalCharges.length;

  @override
  int get selectedRowCount => 0;
}
