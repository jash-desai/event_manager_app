// import 'package:event_manager/globals/myFonts.dart';
import 'package:flutter/material.dart';
import './drawer.dart';
import './main_screen.dart';

class HomePage extends StatelessWidget {
  static const routeName = '/home-page';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          DrawerScreen(),
          HomeScreen(),
        ],
      ),
    );
  }
}
























// TextButton(
//           onPressed: () {
//             Provider.of<Authentication>(context, listen: false)
//                 .signOut()
//                 .then((value) {
//               Navigator.of(context)
//                   .pushNamedAndRemoveUntil(Login.routeName, (route) => true);
//             }).catchError((error) {
//               showError(error.toString(), context);
//             });
//           },
//           child: Text("SignOut"),
//         ),