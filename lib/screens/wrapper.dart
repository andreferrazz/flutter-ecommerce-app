import 'package:e_commerce/models/custom_user.dart';
import 'package:e_commerce/screens/authenticate/authenticate_root.dart';
import 'package:e_commerce/screens/home/home.dart';
import 'package:e_commerce/screens/payment/payment.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<CustomUser>(context);
    // print(user);

    if(user == null) return AuthenticateRoot();

    return PaymentScreen();
  }
}
