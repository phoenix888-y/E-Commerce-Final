import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseServices {
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  String getUserId() {
    return _firebaseAuth.currentUser.uid;
  }

  final CollectionReference prodductsRef =
      FirebaseFirestore.instance.collection("Products");

  final CollectionReference usersRef = FirebaseFirestore.instance.collection(
      "Users"); // user-> userID (Document)-> cart -> productID(Document)

  final CollectionReference storesRef =
      FirebaseFirestore.instance.collection("Stores");
// This is the beggining of the new code
}
