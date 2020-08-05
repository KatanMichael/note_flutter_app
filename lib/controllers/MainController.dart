
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
  MainController._internal();
}