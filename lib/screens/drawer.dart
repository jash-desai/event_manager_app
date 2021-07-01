import 'package:event_manager/globals/myColors.dart';
import 'package:flutter/material.dart';
import 'package:event_manager/providers/authentication.dart';
import 'package:event_manager/screens/login.dart';
import 'package:provider/provider.dart';

class DrawerScreen extends StatefulWidget {
  @override
  _DrawerScreenState createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen> {
  final isLoading = true;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: kBlue,
      padding: EdgeInsets.only(top: 50, bottom: 70, left: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              CircleAvatar(),
              SizedBox(
                width: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'User Name',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ],
              )
            ],
          ),
          Row(
            children: [
              Icon(
                Icons.settings,
                color: Colors.white,
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                'Settings',
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                width: 10,
              ),
              Container(
                width: 2,
                height: 20,
                color: Colors.white,
              ),
              SizedBox(
                width: 10,
              ),
              GestureDetector(
                onTap: () async {
                  final authInstance =
                      Provider.of<Authentication>(context, listen: false);
                  authInstance.signOut().then((value) {
                    Navigator.of(context).pushNamedAndRemoveUntil(
                        Login.routeName, (route) => true);
                  }).catchError((error) {
                    authInstance.showError(error.toString(), context);
                  });
                },
                child: Text(
                  'Log out',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
