import 'package:e_commerce/shared/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign in'),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Form(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Text(
                'Sign in',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 40.0),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  TextFormField(
                    decoration: textFieldDecoration,
                    onChanged: (value) {},
                  ),
                  SizedBox(
                    height: 24.0,
                  ),
                  TextFormField(
                    decoration: textFieldDecoration,
                    onChanged: (value) {},
                  ),
                  SizedBox(
                    height: 24.0,
                  ),
                  RaisedButton(
                    child: Text('Sign in'),
                    onPressed: () {},
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Text(
                    'ou',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 20.0),
                  ),
                  RaisedButton(
                    child: Text('Sign in anon'),
                    onPressed: () {},
                  ),
                  SizedBox(
                    height: 8.0,
                  ),
                  RaisedButton(
                    child: Text('Sign in with Google'),
                    onPressed: () {},
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
