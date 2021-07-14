import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';

import './providers/authentication.dart';
import './screens/login.dart';
import './screens/homepage.dart';
// import './screens/splash_screen.dart';
import './screens/signup.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Future<FirebaseApp> _initialization = Firebase.initializeApp();
    return FutureBuilder(
      // Initialize FlutterFire:
      future: _initialization,
      builder: (context, snapshot) {
        // Check for errors
        if (snapshot.hasError) {
          print('Something has gone wrong!');
        }

        // Once complete, show the application
        if (snapshot.connectionState == ConnectionState.done) {
          return MultiProvider(
            providers: [
              ChangeNotifierProvider(
                create: (ctx) => Authentication(),
              ),
            ],
            child: MaterialApp(
              debugShowCheckedModeBanner: false,
              home: HomePage(),
              routes: {
                HomePage.routeName: (ctx) => HomePage(),
                SignUp.routeName: (ctx) => SignUp(),
                Login.routeName: (ctx) => Login(),
              },
            ),
          );
        }

        // Till then, show something whilst waiting for initialization to complete
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData.light(),
          home: Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          ),
        );
      },
    );
  }
}
