import '../models/User.dart';
import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:note_flutter_app/services/FirebaseService.dart';

class MainController {
  static final MainController instance = MainController._internal();
  FirebaseService firebaseService = FirebaseService();

  factory MainController()
  {
    return instance;
  }

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