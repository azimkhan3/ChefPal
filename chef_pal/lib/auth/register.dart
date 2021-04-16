import 'package:chef_pal/auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Register extends StatefulWidget {
  Register({Key key}) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  //captures text for textfields
  final TextEditingController _emailField = TextEditingController();
  final TextEditingController _passwordField = TextEditingController();
  final TextEditingController _passwordCheckField = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          color: Colors.white10,
        ),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Container(
                  alignment: Alignment.bottomCenter,
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.width / 4,
                child: Image.asset(
                  "assets/logo.png",
                  fit: BoxFit.contain,
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / 35,
              ),
              Container(
                width: MediaQuery.of(context).size.width / 1.3,
                child: TextFormField(
                  validator: (_emailField) =>
                      _emailField.isEmpty ? 'Enter Email' : null,
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
                  validator: (_passwordField) => _passwordField.length < 8
                      ? 'Password must be at least 8 characters long'
                      : null,
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
                width: MediaQuery.of(context).size.width / 1.3,
                child: TextFormField(
                  validator: (_passwordCheckField) =>
                      !(_passwordCheckField == _passwordField.text)
                          ? 'Password do not match'
                          : null,
                  style: TextStyle(color: Colors.grey.shade700),
                  controller: _passwordCheckField,
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
                    if (_formKey.currentState.validate()) {
                      context.read<AuthentificationService>().signUp(
                            _emailField.text.trim(),
                            _passwordField.text.trim(),
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
              Expanded(
                child: Container(
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      height: MediaQuery.of(context).size.height / 10,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Already have an Account?",
                            style: TextStyle(
                              color: Colors.grey,
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pop(
                                context,
                              );
                            },
                            child: Text("Login"),
                          )
                        ],
                      ),
                      decoration: const BoxDecoration(
                        border: Border(
                          top: BorderSide(width: 1.0, color: Colors.grey),
                        ),
                      ),
                    ),
                  ),
                  alignment: Alignment.bottomCenter,
                  decoration: const BoxDecoration(
                    border: Border(
                        //top: BorderSide(width: 1.0, color: Colors.grey),
                        //bottom: BorderSide(width: 1.0, color: Colors.grey),
                        ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
