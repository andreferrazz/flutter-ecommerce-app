import 'package:e_commerce/services/auth.dart';
import 'package:e_commerce/shared/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
  final Function toggleScreen;

  SignIn({this.toggleScreen});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign in'),
        actions: <Widget>[
          FlatButton.icon(
            onPressed: widget.toggleScreen,
            icon: Icon(Icons.person),
            label: Text('Sign up'),
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
                  'Sign in',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 40.0),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  TextFormField(
                    decoration: textFieldDecoration.copyWith(hintText: 'Email'),
                    onChanged: (value) {},
                  ),
                  SizedBox(
                    height: 24.0,
                  ),
                  TextFormField(
                    obscureText: true,
                    decoration: textFieldDecoration.copyWith(hintText: 'Password'),
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
              Text(
                'ou',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20.0),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[

                  RaisedButton(
                    child: Text('Sign in anon'),
                    onPressed: () async {
                      dynamic result = await _auth.signInAnon();
                      if(result != null){
                        print(result);
                      }else{
                        print('Login failed');
                      }
                    },
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
