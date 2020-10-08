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
        ProfileTile(text: 'My info', icon: Icons.account_circle),
        ProfileTile(text: 'Privacy and Security', icon: Icons.security),
        ProfileTile(text: 'Logout', icon: Icons.person),
        ListTile(
          contentPadding: EdgeInsets.only(top: 4.0, bottom: 4.0, left: 80.0),
          title: Text('Support'),
        ),
        ProfileTile(text: 'Terms of use', icon: Icons.description),
        ProfileTile(text: 'Privacy Policy', icon: Icons.description),
        ProfileTile(text: 'License', icon: Icons.description),
      ],
    );
  }
}
