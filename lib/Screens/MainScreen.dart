import 'package:flutter/material.dart';
import 'package:note_flutter_app/controllers/MainController.dart';
import 'package:note_flutter_app/models/User.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class MainScreen extends StatefulWidget
{
  String userId;
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen>
{


  User user;
  MainController controller = MainController();


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    controller.getUserDataFromFirestore(userId: controller.getCurrentUserId(),
    onComplete: (userData)
    {
      print("UserData: ${userData}");
      setState(() {
        user = userData;
      });
    },
    onError: (error)
    {
      print(error);
    }
    );


  }
  @override
  Widget build(BuildContext context)
  {
    // CR: Don't replace the entire tree on this condition,
    // CR: try to have the same skeleton and have an inner widget do this condition and display accordingly
    if(user == null)
      {
        return Scaffold(
            backgroundColor: Colors.blue,
            body: Center(
              child: Column
                (
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  SpinKitWanderingCubes(
                    color: Colors.white,
                    size: 100.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0,0,0,100),
                    child: Text("Getting Your Data...", style: TextStyle(color: Colors.white, fontSize: 30),),
                  )
                ],
              )
            )
        );
      }

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Expanded(
              child: Text("Username: ${user.username}"),
            )
          ],
        ),
      ),
    );
  }
}
