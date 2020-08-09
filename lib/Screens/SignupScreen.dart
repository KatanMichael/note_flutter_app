import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:note_flutter_app/controllers/MainController.dart';
// CR: Same UI issues as in the login screen
class SignupScreen extends StatefulWidget {
  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen>
{
  MainController controller = MainController();

  TextStyle textStyle = TextStyle(fontSize: 25,);
  String emailFormat = "";
  String passwordFormat = "";
  String email = "";
  String password = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child:
        Column(
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Column(

                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20,50,0,0),
                    child: Text("Create New Account", style: textStyle),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 2,
              child: Column(
                children: <Widget>[
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: "Enter Email",
                      labelStyle: textStyle,
                    ),
                    style: textStyle,
                    onChanged: (text)
                    {
                      setState(() {
                        email = text;
                      });
                      if(!EmailValidator.validate(text) && text.length > 0)
                      {
                        setState(() {
                          emailFormat = "Email Not Formatted Correctly";
                        });
                      }else
                      {
                        setState(() {
                          emailFormat = "";
                        });
                      }
                    },
                  ),
                  Text(emailFormat, style: TextStyle(color: Colors.red),), //Email Error Msg
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0,30,0,0),
                    child: TextFormField(
                      decoration: InputDecoration(
                        labelText: "Enter Password",
                        labelStyle:  textStyle,
                      ),
                      obscureText: true,
                      onChanged: (text)
                      {
                        // CR: This code is duplicated across Login and Signup,
                        // CR: Consider implementing it in a reusable Widget
                        setState(() {
                          password = text;
                        });
                        if(text.length < 6 && text.length >= 1)
                        {
                          setState(() {
                            passwordFormat = "Password too short";
                          });
                        }else{
                          setState(() {
                            passwordFormat = "";
                          });
                        }
                      },

                    ),

                  ),
                  Text(passwordFormat, style: TextStyle(color: Colors.red),), //Email Error Msg
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0,20,0,0),
                    child: Column(
                      children: <Widget>[
                        RaisedButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                              side: BorderSide(color: Colors.blueAccent)),
                          onPressed: () {
                            loginWithEmailAndPassowrd(email, password);
                          },
                          color: Colors.blueAccent,
                          textColor: Colors.white,
                          child: Text("Submit",
                              style: TextStyle(fontSize: 25)),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            // CR: Use Theme & ThemeData to have consistent text sizes and colors,
                            // CR: try not to use inline numbers as they're hard to change
                            Text("have an Account? ", style: TextStyle(fontSize: 18),),
                            FlatButton(
                              child: Text("Login!", style: TextStyle(fontSize: 18, color: Colors.blue),
                              )
                              ,
                              onPressed: ()
                              {
                                Navigator.pop(context);
                              },
                            ),
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  void loginWithEmailAndPassowrd(String email,String password)
  {
    if(passwordFormat.isEmpty && emailFormat.isEmpty && password.isNotEmpty && email.isNotEmpty)
    {
      controller.createUserWithEmailAndPassowrd(email: email, password: password,
          onComplete: (userId)
          {
            print(userId);
          },
          onError: (erorr)
          {
            print("Error: ${erorr}");
          }
      );
    }
  }

}
