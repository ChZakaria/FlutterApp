import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ApiService {
  static Future<dynamic> makeApiRequest(
    String endpoint,
    String method, // "GET", "POST", "PUT", "DELETE", etc.
    Map<String, dynamic>? requestBody,
  ) async {
    String? myToken = await getFromShared();

    final Uri uri = Uri.parse('http://127.0.0.1:8000/api/$endpoint');

    final Map<String, String> headers = {
      'Authorization': 'Bearer $myToken',
      'Content-Type': 'application/json',
    };

    final Map<String, String> httpMethods = {
      'GET': 'get',
      'POST': 'post',
      'PUT': 'put',
      'DELETE': 'delete',
    };

    final response = await http.Client().send(
      http.Request(httpMethods[method]!, uri)
        ..headers.addAll(headers)
        ..body = jsonEncode(requestBody),
    );

// Create an http.Response directly from the HTTP response
    final _response = await http.Response.fromStream(response);

    if (_response.statusCode == 200 || _response.statusCode == 201) {
      return json.decode(_response.body);
    } else {
      return 'Error: ${_response.statusCode}';
    }
  }

  static getFromShared() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = await prefs.getString('token');

    return token;
  }
}
