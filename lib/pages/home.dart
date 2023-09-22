import 'package:flutter/material.dart';
import 'package:my_web_project/pages/dashboard.dart';
import 'package:my_web_project/pages/login_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var myText = "blablabla";

  var myColor = Colors.green;

  @override
  Widget build(BuildContext context) {
    void saveInShared() async {
      // Obtain shared preferences.
      final SharedPreferences prefs = await SharedPreferences.getInstance();

      // Save an integer value to 'counter' key.
      await prefs.setInt('counter', 10);

      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Dashboard()),
      );
    }

    return Scaffold(
      body: Center(
        child: Column(children: [
          Container(
            decoration: BoxDecoration(color: Colors.amber),
            padding: const EdgeInsets.all(16.0),
            height: 300,
            width: MediaQuery.of(context).size.width * 0.5,
          ),
          ElevatedButton(onPressed: saveInShared, child: Text("Save"))
        ]),
      ),
    );
  }
}
