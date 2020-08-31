import 'package:e_commerce/shared/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  final Function toggleScreen;

  Register({this.toggleScreen});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign up'),
        actions: <Widget>[
          FlatButton.icon(
            onPressed: widget.toggleScreen,
            icon: Icon(Icons.person),
            label: Text('Sign in'),
            textColor: Colors.white,
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Form(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(48.0),
                child: Text(
                  'Sign up',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 40.0),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  TextFormField(
                    decoration: textFieldDecoration.copyWith(hintText: 'Nome'),
                    onChanged: (value) {},
                  ),
                  SizedBox(
                    height: 24.0,
                  ),
                  TextFormField(
                    decoration: textFieldDecoration.copyWith(hintText: 'Email'),
                    onChanged: (value) {},
                  ),
                  SizedBox(
                    height: 24.0,
                  ),
                  TextFormField(
                    obscureText: true,
                    decoration:
                        textFieldDecoration.copyWith(hintText: 'Password'),
                    onChanged: (value) {},
                  ),
                  SizedBox(
                    height: 24.0,
                  ),
                  RaisedButton(
                    child: Text('Sign up'),
                    onPressed: () {},
                  ),
                ],
              ),
              Text(
                'ou',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20.0),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[

                  RaisedButton(
                    child: Text('Continue with Google'),
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
