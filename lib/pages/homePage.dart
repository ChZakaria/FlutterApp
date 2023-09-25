import 'package:flutter/material.dart';




class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Car Rental Analytics Dashboard'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header and Navigation
            Row(
              children: [
                Image.asset(
                  'assets/logo.png',
                  height: 50,
                  width: 50,
                ),
                Spacer(),
                TextButton(
                  onPressed: () {},
                  child: Text('Dashboard'),
                ),
                TextButton(
                  onPressed: () {},
                  child: Text('Rentals'),
                ),
                TextButton(
                  onPressed: () {},
                  child: Text('Analytics'),
                ),
                TextButton(
                  onPressed: () {},
                  child: Text('Settings'),
                ),
              ],
            ),
            SizedBox(height: 20),

            // Page Title and Subtitle
            Text(
              'Car Rental Analytics Dashboard',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'View valuable insights about car rentals at a glance.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),

            // Date Range Selector
            DropdownButton<String>(
              value: 'Today',
              onChanged: (String? newValue) {},
              items: <String>['Today', 'This Week', 'This Month', 'Custom Range']
                  .map<DropdownMenuItem<String>>(
                (String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                },
              ).toList(),
            ),
            SizedBox(height: 20),

            // Summary Cards (Placeholders)
            Row(
              children: [
                SummaryCard(title: 'Total Rentals', value: '2500'),
                SummaryCard(title: 'Revenue', value: '\$150,000'),
                SummaryCard(title: 'Avg. Rental Duration', value: '4.5 days'),
              ],
            ),
            SizedBox(height: 20),

            // Graphs and Charts (Placeholder)
            Container(
              height: 300,
              color: Colors.grey[200],
            ),

            SizedBox(height: 20),

            // Tabular Data (Placeholder)
            DataTable(
              columns: <DataColumn>[
                DataColumn(label: Text('Rental ID')),
                DataColumn(label: Text('Car Model')),
                DataColumn(label: Text('Pickup Date')),
                DataColumn(label: Text('Return Date')),
                DataColumn(label: Text('Price')),
              ],
              rows: <DataRow>[
                DataRow(cells: <DataCell>[
                  DataCell(Text('1')),
                  DataCell(Text('Sedan')),
                  DataCell(Text('2023-09-25')),
                  DataCell(Text('2023-09-28')),
                  DataCell(Text('\$200')),
                ]),
                // Add more rows as needed
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class SummaryCard extends StatelessWidget {
  final String title;
  final String value;

  SummaryCard({required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: EdgeInsets.all(20),
        width: 300,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              value,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
