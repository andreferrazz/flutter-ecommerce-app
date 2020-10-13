import 'package:e_commerce/screens/home/cart_tab.dart';
import 'package:e_commerce/screens/home/favorite_tab.dart';
import 'package:e_commerce/screens/home/profile_tab.dart';
import 'package:e_commerce/services/auth.dart';
import 'package:e_commerce/services/payment.dart';
import 'package:flutter/material.dart';

import 'home_tab.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final AuthService _auth = AuthService();
  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();

  int _currentIndex = 0;

  List<Widget> _tabs;

  final _titles = ['Home', 'Cart', 'Favorites', 'Profile'];

  @override
  void initState() {
    // TODO: implement initState
    _tabs = [
      HomeTab(_key),
      // TestTab(),
      CartTab(_key),
      FavoriteTab(),
      ProfileTab(),
    ];
    // PaymentService().init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      appBar: AppBar(
        title: Text(_titles[_currentIndex]),
        // centerTitle: true,
        elevation: 0,
        actions: <Widget>[
          FlatButton.icon(
            onPressed: () async {
              await _auth.signOut();
            },
            icon: Icon(Icons.exit_to_app),
            label: Text('Logout'),
            textColor: Colors.white,
          )
        ],
      ),
      body: _tabs[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            title: Text('Home'),
            backgroundColor: Colors.blue,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            title: Text('Cart'),
            backgroundColor: Colors.blue,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            title: Text('Favorite'),
            backgroundColor: Colors.blue,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            title: Text('Profile'),
            backgroundColor: Colors.blue,
          ),
        ],
        onTap: (index) {
          setState(() => _currentIndex = index);
        },
      ),
    );
  }
}
