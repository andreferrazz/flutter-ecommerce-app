import 'package:e_commerce/models/custom_user.dart';
import 'package:e_commerce/services/auth.dart';
import 'package:e_commerce/shared/styles.dart';
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
  String _passwordError = '';
  bool _emailIsValid = true;
  bool _passwordIsValid = true;

  void _signUp() async {
    // Assumes valid fields
    _emailIsValid = true;

    // Check if the fields are empty or the password length is less than 6
    if (!_formKey.currentState.validate()) {
      return;
    }

    // Try to register with the data provided.
    // Return the User on success, otherwise, return an error code
    dynamic result =
        await _auth.registerUserWithEmailAndPassword(_email, _password, name: _name);

    // Redirect to Home screen
    if (result is CustomUser) {
      print(result);
      Navigator.pop(context);
      return;
    }

    // Set error messages and re-validate fields
    switch (result) {
      case 'email-already-in-use':
        _emailError = 'The account already exists for that email.';
        _emailIsValid = false;
        break;
      case 'invalid-email':
        _emailError = 'Invalid email';
        _emailIsValid = false;
        break;
      case 'weak-password':
        _passwordError = 'The password provided is too weak.';
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
                        'Sign up',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 40.0),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        TextFormField(
                          decoration:
                              textFieldDecoration.copyWith(hintText: 'Nome'),
                          onChanged: (value) {
                            setState(() => _name = value);
                          },
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please supply a name';
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: 24.0,
                        ),
                        TextFormField(
                          decoration:
                              textFieldDecoration.copyWith(hintText: 'Email'),
                          onChanged: (value) {
                            setState(() => _email = value);
                          },
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please supply an email';
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
                            setState(() => _password = value);
                          },
                          validator: (value) {
                            if (value.length < 6) {
                              return 'Please supply a password with 6+ chars length';
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
                          child: Text('Sign up',
                              style: TextStyle(color: Colors.white)),
                          onPressed: _signUp,
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
                          child: Text('Continue with Google',
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
                          child: Text('Continue with Facebook',
                              style: TextStyle(color: Colors.white)),
                          onPressed: () async {
                            // TODO: call the auth service to sign in with facebook
                          },
                        ),
                      ],
                    ),
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
