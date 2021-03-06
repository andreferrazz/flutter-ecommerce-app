import 'package:e_commerce/models/custom_user.dart';
import 'package:e_commerce/services/auth.dart';
import 'package:e_commerce/theme/style.dart';
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
  final _formKey = GlobalKey<FormState>();

  String _email = '';
  String _password = '';
  String _emailError = '';
  String _passwordError = '';
  bool _emailIsValid = true;
  bool _passwordIsValid = true;

  void _signIn() async {
    // Assumes valid fields
    _emailIsValid = true;
    _passwordIsValid = true;

    // Check if the fields are empty
    if (!_formKey.currentState.validate()) {
      return;
    }

    // Try sign in with the data provided.
    // Return the User on success, otherwise, return an error code
    dynamic result = await _auth.signInWithEmailAndPassword(_email, _password);

    // Redirect to Home screen
    if (result is CustomUser) {
      // print(result);
      Navigator.pop(context);
      return;
    }

    // Set error messages and re-validate fields
    switch (result) {
      case 'user-not-found':
        _emailError = 'No user found for that email.';
        _emailIsValid = false;
        break;
      case 'invalid-email':
        _emailError = 'Invalid email';
        _emailIsValid = false;
        break;
      case 'wrong-password':
        _passwordError = 'Wrong password provided for that user.';
        _passwordIsValid = false;
        break;
      default:
        print('Error: $result');
    }
    _formKey.currentState.validate();
  }

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
      body: LayoutBuilder(
        builder: (context, viewport) {
          return SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 24.0),
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: viewport.maxHeight),
              child: Form(
                key: _formKey,
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
                          decoration:
                              textFieldDecoration.copyWith(hintText: 'Email'),
                          onChanged: (value) {
                            this._email = value;
                          },
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Supply an email';
                            }
                            if (!_emailIsValid) {
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
                          decoration: textFieldDecoration.copyWith(
                              hintText: 'Password'),
                          onChanged: (value) {
                            this._password = value;
                          },
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Supply a password';
                            }
                            if (!_passwordIsValid) {
                              return _passwordError;
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: 24.0,
                        ),
                        RaisedButton(
                          color: Theme.of(context).primaryColor,
                          elevation: 0,
                          child: Text('Sign in',
                              style: TextStyle(color: Colors.white)),
                          onPressed: _signIn,
                        ),
                      ],
                    ),
                    Text(
                      'ou',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 20.0, color: Colors.grey[700]),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        RaisedButton(
                          color: Color.fromARGB(255, 219, 68, 55),
                          elevation: 0,
                          child: Text('Sign in with Google',
                              style: TextStyle(color: Colors.white)),
                          onPressed: () {
                            // TODO: call the auth service to sign in with google
                          },
                        ),
                        SizedBox(
                          height: 8.0,
                        ),
                        RaisedButton(
                          color: Color.fromARGB(255, 66, 103, 178),
                          elevation: 0,
                          child: Text('Sign in with Facebook',
                              style: TextStyle(color: Colors.white)),
                          onPressed: () async {
                            // TODO: call the auth service to sign in with facebook
                          },
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
