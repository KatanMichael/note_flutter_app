import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:note_flutter_app/controllers/MainController.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
{
  MainController controller = MainController();

  TextStyle textStyle = TextStyle(fontSize: 25);
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
                    child: Text("Sign In", style: textStyle),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 1,
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
                  Expanded(
                    flex: 1,
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
                            Text("Not have an Account? ", style: TextStyle(fontSize: 18),),
                            FlatButton(
                              child: Text("Sign Up!", style: TextStyle(fontSize: 18, color: Colors.blue),
                            )
                                  ,
                              onPressed: ()
                              {
                                print("Click to sign up");
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
        controller.loginWithEmailAndPassword(email: email, password: password,
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
