import 'dart:ui';

import 'package:event_manager/widgets/profile_picture.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';

import '../globals/myColors.dart';
import '../globals/myFonts.dart';
import '../globals/mySpaces.dart';
import '../globals/sizeConfig.dart';
import '../providers/authentication.dart';
import '../screens/login.dart';

class DrawerScreen extends StatefulWidget {
  @override
  _DrawerScreenState createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen> {
  // Initializing Variables

  String _userName;
  final _auth = FirebaseAuth.instance;
  bool isLoading = false;

  changeName() {
    showDialog(
        context: context,
        builder: (ctx) {
          return AlertDialog(
            title: Text("Edit Name"),
            content: TextFormField(
              // controller: _nameController,
              onChanged: (value) {
                _userName = value;
              },
              decoration: InputDecoration(
                labelText: "Enter your name",
              ),
            ),
            actions: [
              TextButton(
                onPressed: () async {
                  setState(() {
                    isLoading = true;
                  });
                  Navigator.of(context).pop();
                  await Provider.of<Authentication>(context, listen: false)
                      .changeName(_userName, context);
                  setState(() {
                    isLoading = false;
                  });
                },
                child: Text("Submit"),
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: LayoutBuilder(
        builder: (context, constraint) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraint.maxHeight),
              child: IntrinsicHeight(
                child: Container(
                  color: drawerbackground,
                  padding: EdgeInsets.symmetric(
                      vertical: SizeConfig.verticalBlockSize * 7,
                      horizontal: SizeConfig.horizontalBlockSize * 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ProfilePicture(),
                      MySpaces.vLargeGapInBetween,
                      Consumer<Authentication>(builder: (ctx, auth, _) {
                        return isLoading
                            ? CircularProgressIndicator()
                            : Text(
                                _auth.currentUser.displayName
                                    .replaceAll(" ", "\n"),
                                style: MyFonts.bold
                                    .setColor(kWhite)
                                    .letterSpace(3)
                                    .size(SizeConfig.horizontalBlockSize * 7),
                              );
                      }),
                      // Text(
                      //   _auth.currentUser.displayName.replaceAll(" ", "\n"),
                      //   style: MyFonts.bold
                      //       .setColor(kWhite)
                      //       .letterSpace(3)
                      //       .size(SizeConfig.horizontalBlockSize * 7),
                      // ),
                      MySpaces.vLargestGapInBetween,
                      GestureDetector(
                        onTap: () {
                          changeName();
                        },
                        child: Row(
                          children: [
                            Icon(
                              Icons.person,
                              color: kGrey,
                            ),
                            MySpaces.hSmallestGapInBetween,
                            Text(
                              "Change Username",
                              style: MyFonts.medium
                                  .setColor(kWhite)
                                  .size(SizeConfig.horizontalBlockSize * 4.2),
                            ),
                          ],
                        ),
                      ),
                      MySpaces.vSmallestGapInBetween,
                      ...List.generate(4, (index) => "Option $index").map((e) {
                        return Container(
                          margin: EdgeInsets.symmetric(vertical: 6),
                          child: Row(
                            children: [
                              Icon(
                                Icons.add,
                                color: kGrey,
                              ),
                              MySpaces.hSmallestGapInBetween,
                              Text(
                                e,
                                style: MyFonts.medium
                                    .setColor(kWhite)
                                    .size(SizeConfig.horizontalBlockSize * 4),
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                      Spacer(),
                      Row(
                        children: [
                          Icon(
                            Icons.settings,
                            color: Colors.white,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          GestureDetector(
                            child: Text(
                              'Settings',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Container(
                            width: 2,
                            height: 25,
                            color: Colors.white,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          GestureDetector(
                            onTap: () async {
                              final authInstance = Provider.of<Authentication>(
                                  context,
                                  listen: false);
                              authInstance.signOut().then((value) {
                                Navigator.of(context).pushNamedAndRemoveUntil(
                                    Login.routeName, (route) => true);
                              }).catchError((error) {
                                authInstance.showError(
                                    error.toString(), context);
                              });
                            },
                            child: Row(
                              children: [
                                Icon(
                                  Icons.logout_outlined,
                                  color: Colors.white,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: Text(
                                    'Log out',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
