import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
{
  TextStyle textStyle = TextStyle(fontSize: 25);
  String emailFormat = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(Icons.email),
            Text("Welcome To My App!", style: textStyle),
            TextFormField(
              decoration: InputDecoration(
                labelText: "Enter Email",
                labelStyle: textStyle,
              ),
              style: textStyle,
              onFieldSubmitted: (text)
              {
                print(text);
              },
              onChanged: (text)
              {
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

          ],
        ),
      ),
    );
  }
}
