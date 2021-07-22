import 'package:event_manager/providers/tasks.dart';
import 'package:event_manager/screens/create_new_task.dart';
import 'package:event_manager/screens/edit_category_screen.dart';
import 'package:event_manager/screens/calendar_screen.dart';
import 'package:event_manager/screens/splash_screen.dart';
// import 'package:event_manager/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';

import './providers/authentication.dart';
import './screens/login.dart';
import './screens/homepage.dart';
// import './screens/splash_screen.dart';
import './screens/signup.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => Authentication(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => Tasks(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SplashScreen(),
        routes: {
          HomePage.routeName: (ctx) => HomePage(),
          SignUp.routeName: (ctx) => SignUp(),
          Login.routeName: (ctx) => Login(),
          EditCategoryScreen.routeName: (ctx) => EditCategoryScreen(),
          CreateNewTask.routeName: (ctx) => CreateNewTask(),
          CalendarScreen.routeName: (ctx) => CalendarScreen(),
        },
      ),
    );
  }
}
