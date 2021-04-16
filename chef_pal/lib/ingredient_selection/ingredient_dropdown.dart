import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class IngredientDropdown extends StatelessWidget {
  const IngredientDropdown({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    FirebaseFirestore.instance.collection('data').doc('ingredients');

    // return StreamBuilder<DocumentSnapshot>(
    //     stream: db.collection('path').doc('id').snapshots(),
    //     builder: (context, snapshot) {
    //       Map data = snapshot.data.data;
    //       return Container(
    //         child: child,
    //       );
    //     });
  }
}
