import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

// CR: Maybe call it AuthService and hide the Firebase-specific models (like AuthResult and such)
// CR: Tomorrow you might want to use a different auth provider and it will be useful to have the same interface

class FirebaseService
{
  FirebaseAuth auth;
  Firestore firestore;

  String currentUserId;

  // CR: pass Firebase objects from outside instead of creating them here
  // CR: better to test this way
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