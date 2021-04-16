import 'dart:convert';

import 'package:chef_pal/auth/firebase_auth.dart';
import 'package:chef_pal/auth/login.dart';
import 'package:chef_pal/auth/register.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AuthentificationView extends StatefulWidget {
  @override
  _AuthentificationViewState createState() => _AuthentificationViewState();
}

class _AuthentificationViewState extends State<AuthentificationView> {
  //captures text for textfields

  @override
  Widget build(BuildContext context) {
    return Login();
  }
}









// /            Container(
//               width: MediaQuery.of(context).size.width / 1.4,
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(15.0),
//                 color: Colors.white,
//               ),
//               child: MaterialButton(
//                 color: Colors.orange.shade400,
//                 onPressed: () async {
//                   await FirebaseFirestore.instance
//                       .collection('data')
//                       .doc('ingredients')
//                       .set({
//                     'ingredients': {
//                       'Meats': [
//                         "Chicken",
//                         "Beef",
//                         "Lamb",
//                         "Pork",
//                       ],
//                       "Dairy": [
//                         "Milk",
//                         "Egg",
//                         "Cheese",
//                         "Yogurt",
//                         "Heavy Cream",
//                         "Swiss Cheese",
//                       ],
//                       "Spices": [],
//                       "Seafood": [],
//                       "Fruit": [],
//                       "Vegetables": [],
//                     }
//                   }).then((value) => print("updated ingredients"));
//                   // await FirebaseFirestore.instance
//                   //     .collection('data')
//                   //     .doc('ingredients')
//                   //     .update({
//                   //   'ingredients': {
//                   //     'Meats': [
//                   //       "Lamb",
//                   //       "Pork",
//                   //     ],
//                   //     "Dairy": [
//                   //       "Yogurt",
//                   //       "Heavy Cream",
//                   //       "Swiss Cheese",
//                   //     ],
//                   //   }
//                   // }).then((value) => print("update values"));
//                 },
//                 child: Text(
//                   "Do Something",
//                   style: TextStyle(
//                     color: Colors.white,
//                   ),
//                 ),
//               ),
//             ),

