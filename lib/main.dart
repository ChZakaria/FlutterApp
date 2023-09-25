import 'package:flutter/material.dart';
import 'package:my_web_project/pages/dashboard.dart';
import 'package:my_web_project/pages/home.dart';
import 'package:my_web_project/pages/login_page.dart';
import 'package:my_web_project/pages/vehiculeList.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'routes/route.dart' as route;

void main() {
  SharedPreferences.setMockInitialValues({});
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
     
      onGenerateRoute: route.controller,
      initialRoute: route.homePage,
      debugShowCheckedModeBanner: false,
    );
  }
}
