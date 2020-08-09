import '../models/User.dart';
import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:note_flutter_app/services/FirebaseService.dart';

// CR: instead of implementing Singleton, use `provider` or `get_it` to inject the class
class MainController {
  static final MainController instance = MainController._internal();
  // CR: Better to initialize outside and pass as a param to c'tor
  FirebaseService firebaseService = FirebaseService();

  factory MainController()
  {
    return instance;
  }

  // CR: Functions need to be typed better,
  // CR: Nothing prevents me from calling onComplete(2, 3, 4) which is not valid.
  void loginWithEmailAndPassword({String email, String password, Function onComplete, Function onError}) async
  {
    AuthResult result;
    try
    {
      result = await firebaseService.loginWithEmailAndPassowrd(email, password);
    }
    catch(e)
    {
      onError(e);
    }
    if(result != null)
      {
        onComplete(result.user.uid);
      }

  }

  void getUserDataFromFirestore({userId, Function onComplete, Function onError}) async
  {
    // CR: Why not use Future<User> instead of a onComplete callback?
    // CR: Also onError is better to be replaced with a regular `throw`

    try{
      var querySnapshot = await firebaseService.getUserDataFromFirestore(userId: userId);
      Map data = querySnapshot.documents[0].data;
      User tempUser = User(useruid: data['userId'], userEmail: data['userEmail'], username: data['userDisplayName']);
      onComplete(tempUser);

    }catch(e)
    {
      onError(e);
    }
  }

  // CR: try shorter names: registerUser
  // CR: the params explain themselves
  // CR: use @required when appropriate
  void createUserWithEmailAndPassowrd({String email, String password,
    Function onComplete,
    Function onError}) async
  {
    AuthResult result;

    try
    {
      result = await firebaseService.createUserWithEmailAndPassowrd(email: email, password: password);

    }catch(e)
    {
      onError(e);
    }

    if(result!= null)
      {
        onComplete(result.user.uid);
      }
  }

  MainController._internal();

  void setCurrentUserId(userId) {
    firebaseService.currentUserId = userId;
  }

  String getCurrentUserId()
  {
    return firebaseService.currentUserId;
  }
}