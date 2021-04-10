import 'package:chef_pal/auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AuthentificationView extends StatefulWidget {
  @override
  _AuthentificationViewState createState() => _AuthentificationViewState();
}

class _AuthentificationViewState extends State<AuthentificationView> {
  //captures text for textfields
  final TextEditingController _emailField = TextEditingController();
  final TextEditingController _passwordField = TextEditingController();

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
                onPressed: () {
                  context.read<AuthentificationService>().signIn(
                        _emailField.text.trim(),
                        _passwordField.text.trim(),
                      );
                },
                child: Text(
                  "Login",
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
                onPressed: () {
                  context.read<AuthentificationService>().signUp(
                        _emailField.text.trim(),
                        _passwordField.text.trim(),
                      );
                },
                child: Text(
                  "Register",
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
