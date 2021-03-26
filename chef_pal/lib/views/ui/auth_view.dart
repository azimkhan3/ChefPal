import 'package:chef_pal/services/firebase_auth.dart';
import 'package:chef_pal/views/ui/home_view.dart';
import 'package:flutter/material.dart';

class Authentification extends StatefulWidget {
  @override
  _AuthentificationState createState() => _AuthentificationState();
}

class _AuthentificationState extends State<Authentification> {
  //captures tex fore textfields
  TextEditingController _emailField = TextEditingController();
  TextEditingController _passwordField = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          color: Colors.white10,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //email
            Container(
              width: MediaQuery.of(context).size.width / 1.3,
              child: TextFormField(
                style: TextStyle(color: Colors.grey.shade700),
                controller: _emailField,
                decoration: InputDecoration(
                  hintText: "something@email.com",
                  hintStyle: TextStyle(color: Colors.grey.shade400),
                  labelText: "Email",
                  labelStyle: TextStyle(color: Colors.grey),
                ),
              ),
            ),

            SizedBox(
              height: MediaQuery.of(context).size.height / 35,
            ),

            Container(
              width: MediaQuery.of(context).size.width / 1.3,
              child: TextFormField(
                style: TextStyle(color: Colors.grey.shade700),
                controller: _passwordField,
                obscureText: true, //blocks characters typed
                decoration: InputDecoration(
                  hintText: "password",
                  hintStyle: TextStyle(color: Colors.grey.shade400),
                  labelText: "Password",
                  labelStyle: TextStyle(color: Colors.grey),
                ),
              ),
            ),

            SizedBox(
              height: MediaQuery.of(context).size.height / 35,
            ),

            Container(
              width: MediaQuery.of(context).size.width / 1.4,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.0),
                color: Colors.white,
              ),
              child: MaterialButton(
                color: Colors.orange.shade400,
                onPressed: () async {
                  bool shouldNavigate =
                      await register(_emailField.text, _passwordField.text);
                  if (shouldNavigate) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => HomeView()),
                    );
                  }
                },
                child: Text(
                  "Register",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),

            SizedBox(
              height: MediaQuery.of(context).size.height / 35,
            ),

            Container(
              width: MediaQuery.of(context).size.width / 1.4,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.0),
                color: Colors.white,
              ),
              child: MaterialButton(
                color: Colors.orange.shade400,
                onPressed: () async {
                  bool shouldNavigate =
                      await signIn(_emailField.text, _passwordField.text);
                  if (shouldNavigate) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => HomeView()),
                    );
                  }
                },
                child: Text(
                  "Log In",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
