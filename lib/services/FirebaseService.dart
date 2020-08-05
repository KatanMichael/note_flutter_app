import 'package:firebase_auth/firebase_auth.dart';

class FirebaseService
{
  FirebaseAuth auth;
  FirebaseService()
  {
    auth = FirebaseAuth.instance;
  }

  Future<AuthResult> loginWithEmailAndPassowrd(String email, String passowrd)
  {
    return auth.signInWithEmailAndPassword(email: email, password: passowrd);
  }

  Future<AuthResult> createUserWithEmailAndPassowrd({String email, String password})
  {
    return auth.createUserWithEmailAndPassword(email: email, password: password);
  }
}