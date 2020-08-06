import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseService
{
  FirebaseAuth auth;
  Firestore firestore;

  String currentUserId;

  FirebaseService()
  {
    auth = FirebaseAuth.instance;
    firestore = Firestore.instance;

  }

  Future<AuthResult> loginWithEmailAndPassowrd(String email, String passowrd)
  {
    return auth.signInWithEmailAndPassword(email: email, password: passowrd);
  }

  Future<AuthResult> createUserWithEmailAndPassowrd({String email, String password})
  {
    return auth.createUserWithEmailAndPassword(email: email, password: password);
  }

  Future<QuerySnapshot> getUserDataFromFirestore({userId})
  {
    return firestore.collection("Users").where("userId", isEqualTo: userId)
        .getDocuments();

  }
}