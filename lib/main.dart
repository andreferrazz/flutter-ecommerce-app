import 'package:e_commerce/screens/wrapper.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  // Create the initialization Future
//  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      // Initialize FlutterFire
      future: Firebase.initializeApp(),
      builder: (context, snapshot) {
        // Check for errors
        if (snapshot.hasError) {
          return MaterialApp(
            home: Scaffold(
              backgroundColor: Colors.white,
              body: Center(
                child: Text(
                  'Could not initialize the App.',
                  style: TextStyle(color: Colors.red, fontSize: 20.0),
                ),
              ),
            ),
          );
        }

        // Once complete, show the application
        if (snapshot.connectionState == ConnectionState.done) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'E-commerce',
            theme: ThemeData(
              primarySwatch: Colors.blue,
              visualDensity: VisualDensity.adaptivePlatformDensity,
            ),
            home: Container(
              child: Wrapper(),
            ),
          );
        }

        // Show something whilst waiting for initialization to complete
        return MaterialApp(
          home: Scaffold(
            backgroundColor: Colors.white,
            body: Center(
              child: Center(child: CircularProgressIndicator()),
            ),
          ),
        );
      },
    );
  }
}
