import 'package:e_commerce/screens/authenticate/register.dart';
import 'package:e_commerce/screens/authenticate/sign_in.dart';
import 'package:flutter/material.dart';

class Authenticate extends StatefulWidget {
  final showSignIn;

  Authenticate({this.showSignIn = true});

  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  bool _showSignIn;

  void toggleScreen(){
    setState(() => _showSignIn = !_showSignIn);
  }

  @override
  void initState() {
    this._showSignIn = widget.showSignIn;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (_showSignIn) {
      return SignIn(toggleScreen: this.toggleScreen,);
    } else {
      return Register(toggleScreen: this.toggleScreen,);
    }
  }
}
