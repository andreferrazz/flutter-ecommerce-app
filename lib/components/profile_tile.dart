import 'package:flutter/material.dart';

class ProfileTile extends StatelessWidget {
  final String text;
  final IconData icon;
  final Function onTap;

  ProfileTile({@required this.text, @required this.icon, @required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(vertical: 4.0, horizontal: 16.0),
      leading: Icon(icon, size: 48.0, color: Colors.grey[800]),
      title: Text(text),
      onTap: onTap,
    );
  }
}
