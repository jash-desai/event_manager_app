// import 'package:event_manager/screens/tasks_screen.dart';
import 'package:event_manager/globals/mySpaces.dart';
import 'package:event_manager/widgets/category_button.dart';
import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';

// import '../globals/mySpaces.dart';
import '../globals/myColors.dart';
import '../globals/sizeConfig.dart';
// import '../globals/myFonts.dart';

class TasksScreen extends StatefulWidget {
  @override
  _TasksScreenState createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> {
  double xOffset = 0;
  double yOffset = 0;
  double scaleFactor = 1;
  double topPadding = 0;

  bool isDrawerOpen = false;

  // final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: AnimatedContainer(
        transform: Matrix4.translationValues(xOffset, yOffset, 0)
          ..scale(scaleFactor),
        duration: Duration(milliseconds: 250),
        decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(isDrawerOpen ? 40 : 0.0)),
        child: Column(
          children: [
            Container(
              // color: kBlue,
              padding: EdgeInsets.only(left: 5, top: topPadding),
              child: IntrinsicHeight(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    isDrawerOpen
                        ? IconButton(
                            icon: Icon(Icons.arrow_back_ios),
                            onPressed: () {
                              setState(() {
                                xOffset = 0;
                                yOffset = 0;
                                scaleFactor = 1;
                                isDrawerOpen = false;
                                topPadding = 0;
                              });
                            },
                          )
                        : IconButton(
                            icon: Icon(Icons.menu),
                            onPressed: () {
                              setState(() {
                                xOffset = SizeConfig.horizontalBlockSize * 70;
                                yOffset = SizeConfig.verticalBlockSize * 9.25;
                                scaleFactor = 0.85;
                                isDrawerOpen = true;
                                topPadding = 15;
                              });
                            },
                          ),
                    Container(
                      padding: EdgeInsets.only(top: 10),
                      color: matteBlack,
                      width: SizeConfig.horizontalBlockSize * 20,
                      height: double.infinity,
                      child: Icon(
                        Icons.calendar_today_outlined,
                        color: kGrey,
                        size: SizeConfig.verticalBlockSize * 5,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Row(
                children: [
                  Container(
                    width: SizeConfig.horizontalBlockSize * 80,
                    child: Column(
                      children: [],
                    ),
                  ),
                  Container(
                    width: SizeConfig.horizontalBlockSize * 20,
                    color: matteBlack,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Spacer(),
                        CategoryButton(),
                        CategoryButton(),
                        CategoryButton(),
                        Spacer(),
                        Icon(
                          Icons.add,
                          color: kGrey,
                          size: SizeConfig.verticalBlockSize * 5,
                        ),
                        MySpaces.vSmallGapInBetween,
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
