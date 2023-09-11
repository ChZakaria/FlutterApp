import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../models/user.dart';

class ApiLogin {
  static bool loggedIn = false;

  static Future<dynamic> makeLoginRequest(User myUser) async {
    String _response = '';
    final response = await http.post(
      Uri.parse('http://127.0.0.1:8000/api/login'),
      body: myUser.toJson(),
    );

    if (response.statusCode == 200) {
      _response = response.body;
      var responseBody =
          json.decode(_response); // Parse the response body into a map
      var token =
          responseBody['token']; // Access the 'token' property from the map
      saveInShared(token);
      loggedIn = true;

      return loggedIn;
    } else {
      _response = 'Error: ${response.body}';
      print(_response);
      print(response);
      return loggedIn;
    }
  } //end makeLoginRequest

  static saveInShared(var token) async {
    // Obtain shared preferences.
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    // Save an integer value to 'counter' key.
    await prefs.setString('token', token);
  }
}
