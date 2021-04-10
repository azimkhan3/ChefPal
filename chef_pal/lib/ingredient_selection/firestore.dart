import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final FirebaseFirestore _firebaseFirestore;
  FirestoreService(this._firebaseFirestore);
  Future<void> addUser(String uid) {
    print(uid);
    DocumentReference documentReference = _firebaseFirestore
        .collection('users')
        .doc(uid)
        .collection('ingredients')
        .doc('meat');
    CollectionReference users = _firebaseFirestore.collection('users');
    Map<String, dynamic> user = {
      uid: [],
    };

    // Call the user's CollectionReference to add a new user
    users.add(user);
  }
}
