import 'package:e_commerce/components/profile_tile.dart';
import 'package:flutter/material.dart';

class ProfileTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        ListTile(
          contentPadding: EdgeInsets.only(top: 4.0, bottom: 4.0, left: 80.0),
          title: Text('Profile'),
        ),
        ProfileTile(
          text: 'My info',
          icon: Icons.account_circle,
          onTap: () => featureNotImplemented(context),
        ),
        ProfileTile(
          text: 'Privacy and Security',
          icon: Icons.security,
          onTap: () => featureNotImplemented(context),
        ),
        ProfileTile(
          text: 'Logout',
          icon: Icons.person,
          onTap: () => featureNotImplemented(context),
        ),
        ListTile(
          contentPadding: EdgeInsets.only(top: 4.0, bottom: 4.0, left: 80.0),
          title: Text('Support'),
        ),
        ProfileTile(
          text: 'Terms of use',
          icon: Icons.description,
          onTap: () => featureNotImplemented(context),
        ),
        ProfileTile(
          text: 'Privacy Policy',
          icon: Icons.description,
          onTap: () => featureNotImplemented(context),
        ),
        ProfileTile(
          text: 'License',
          icon: Icons.description,
          onTap: () => featureNotImplemented(context),
        ),
      ],
    );
  }

  void featureNotImplemented(BuildContext context) {
    Scaffold.of(context).showSnackBar(SnackBar(
      backgroundColor: Colors.yellow[700],
      content: Text('Funcionalidade não disponível'),
      duration: Duration(seconds: 3),
    ));
  }
}
