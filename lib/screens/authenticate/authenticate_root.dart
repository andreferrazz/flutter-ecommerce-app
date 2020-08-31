import 'package:e_commerce/screens/authenticate/authenticate.dart';
import 'package:flutter/material.dart';

class AuthenticateRoot extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 24.0),
        child: Column(
          children: <Widget>[
            Expanded(
              child: Center(
                child: Text('LOGO', style: TextStyle(fontSize: 40.0)),
              ),
            ),
            Row(
//            mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Expanded(
                  child: RaisedButton(
                    child: Text('Sign in'),
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (_) {
                        return Authenticate(showSignIn: true);
                      }));
                    },
                  ),
                ),
                SizedBox(width: 8.0),
                Expanded(
                  child: RaisedButton(
                    child: Text('Sign up'),
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (_) {
                        return Authenticate(showSignIn: false);
                      }));
                    },
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
