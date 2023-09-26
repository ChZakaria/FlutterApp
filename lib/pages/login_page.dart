
import 'package:flutter/material.dart';

import 'package:my_web_project/models/user.dart';

import '../api/apiLogin.dart' as login;

import 'package:my_web_project/routes/route.dart' as route;

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  void showLoginErrorDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Login Error"),
          content: Text("Incorrect login credentials"),
          actions: <Widget>[
            TextButton(
              child: Text("OK"),
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
  void initState() {
    // TODO: implement initState
    emailController.text = "test@test.com";
    passwordController.text = "hello@world";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _form_key = GlobalKey<FormState>();

    return Scaffold(
      appBar: AppBar(
        title: Text('Login Page'),
        centerTitle: true,
      ),
      body: Center(
        child: Container(
          width: 300,
          padding: EdgeInsets.all(16.0),
          child: Form(
            key: _form_key,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Login to continue',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                SizedBox(height: 8.0),
                // Email input
                TextFormField(
                  controller: emailController,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    prefixIcon: Icon(Icons.email),
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (!value!.contains("@")) {
                      return "you should type an email";
                    }
                  },
                ), //end email input
                SizedBox(height: 16.0),

                //passeword input
                TextFormField(
                  controller: passwordController,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    prefixIcon: Icon(Icons.lock),
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "you should type a correct password";
                    }
                  },
                  obscureText: true,
                ),

                //end passeword input

                SizedBox(height: 24.0),

                ElevatedButton(
                  onPressed: () {
                    // Implement login functionality here

                    if (_form_key.currentState!.validate()) {
                      User myUser = User(
                          email: emailController.text,
                          password: passwordController.text);

                      login.ApiLogin.makeLoginRequest(myUser).then((value) {
                        if (value) {
                          Navigator.pushNamed(
                            context,
                           route.homePage
                          );
                        } else {
                          showLoginErrorDialog(context);
                        }
                      });
                    }
                  },
                  child: Text('Login'),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.blue,
                    onPrimary: Colors.white,
                    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                    shape:
                        RoundedRectangleBorder(borderRadius: BorderRadius.zero),
                    elevation: 5,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
