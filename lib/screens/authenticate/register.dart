import 'package:e_commerce/services/auth.dart';
import 'package:e_commerce/shared/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  final Function toggleScreen;

  Register({this.toggleScreen});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  String _name = '';
  String _email = '';
  String _password = '';
  String _emailError = '';
  bool _emailIsValid = true;

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
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Form(
          key: _formKey,
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
                    onChanged: (value) {
                      setState(() => _name = value);
                    },
                    validator: (value) {
                      if(value.isEmpty){
                        return 'Please supply a name';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 24.0,
                  ),
                  TextFormField(
                    decoration: textFieldDecoration.copyWith(hintText: 'Email'),
                    onChanged: (value) {
                      setState(() => _email = value);
                    },
                    validator: (value){
                      if(value.isEmpty){
                        return 'Please supply an email';
                      }
                      if(!_emailIsValid){
                        return _emailError;
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 24.0,
                  ),
                  TextFormField(
                    obscureText: true,
                    decoration:
                        textFieldDecoration.copyWith(hintText: 'Password'),
                    onChanged: (value) {
                      setState(() => _password = value);
                    },
                    validator: (value){
                      if(value.length < 6){
                        return 'Please supply a password with 6+ chars length';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 24.0,
                  ),
                  RaisedButton(
                    child: Text('Sign up'),
                    onPressed: () async {
                      setState(() => _emailIsValid = true);
                      if (_formKey.currentState.validate()) {
                        dynamic result = await _auth.registerUserWithEmailAndPassword(_email, _password);
//                        print(result);
                        if(result is User){
                          Navigator.pop(context);
                        }else{
                          print('result: $result');
                          setState(() {
                            _emailError = result;
                            _emailIsValid = false;
                            _formKey.currentState.validate();
                          });
                        }
                      }
                    },
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
