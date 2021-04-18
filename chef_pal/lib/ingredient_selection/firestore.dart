import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final uid;
  FirestoreService(this.uid);

  Future<void> updateIngredients(User user, Map<String, dynamic> data) {
    return _db.collection('users').doc(user.uid).update({'ingredients': data});
  }

  //create user
  Future<void> initUser() async {
    Map<String, dynamic> ingredients = {
      'ingredients': {
        'Meat': {"Chicken": false, "Beef": false},
        'Seafood': {"Shrimp": false, "Salmon": false},
        'Vegetable': {"Carrots": false, "Onions": false},
      }
    };
    return await _db
        .collection('Users')
        .doc(this.uid)
        .set(ingredients)
        .then((value) => print('User created'))
        .catchError(
            (err) => print("Failed to create instance of user $uid : $err"));
  }

  Map<String, dynamic> _ingredientsFromSnapshot(DocumentSnapshot snapshot) {
    print(snapshot.get('ingredients'));
    return snapshot.get('ingredients');
  }

  //ingredient Stream
  Stream<Map<String, dynamic>> get ingredients {
    return _db
        .collection('Users')
        .doc(uid)
        .snapshots()
        .map(_ingredientsFromSnapshot);
  }
}
