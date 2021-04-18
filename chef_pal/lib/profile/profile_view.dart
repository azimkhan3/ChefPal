import 'package:chef_pal/auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Container(
        alignment: Alignment.center,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.0),
          color: Colors.white,
        ),
        child: MaterialButton(
          color: Colors.orange.shade400,
          onPressed: () {
            context.read<AuthentificationService>().signOut();
          },
          child: Text(
            "Sign Out",
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
