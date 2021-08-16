import 'package:event_manager/globals/myColors.dart';
import 'package:event_manager/screens/calendar_screen.dart';
import 'package:flutter/material.dart';

import './drawer.dart';
import 'package:event_manager/screens/subscription_screen.dart';
import 'package:event_manager/screens/tasks_screen.dart';
import '../globals/sizeConfig.dart';

class HomePage extends StatefulWidget {
  static const routeName = '/home-page';

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double xOffset = 0;
  double yOffset = 0;
  double scaleFactor = 1;
  double topPadding = 0;

  bool isDrawerOpen = false;

  int _selectedIndex = 0;
  List<Widget> _screens = [TasksScreen(), SubscriptionScreen()];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      // Stack widget creates a 3d space and places widgets on top of each other like a layer
      // So at the bottom would be the drawer screen and above that we will have the home screen in this case
      body: SafeArea(
        child: Stack(
          children: [
            DrawerScreen(),
            AnimatedContainer(
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
                                      xOffset =
                                          SizeConfig.horizontalBlockSize * 70;
                                      yOffset =
                                          SizeConfig.verticalBlockSize * 7;
                                      scaleFactor = 0.85;
                                      isDrawerOpen = true;
                                      topPadding = 15;
                                    });
                                  },
                                ),
                                //
                          Container(
                            padding: EdgeInsets.only(top: 10),
                            color: matteBlack,
                            width: SizeConfig.horizontalBlockSize * 18,
                            height: double.infinity,
                            child: IconButton(
                              onPressed: () {
                                Navigator.of(context).pushReplacementNamed(
                                    CalendarScreen.routeName);
                              },
                              icon: Icon(
                                Icons.calendar_today_rounded,
                                // color: Colors.purple.shade500,
                                color: kGrey,
                                size: SizeConfig.verticalBlockSize * 4,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  _screens[_selectedIndex],
                ],
              ),
            ),

            // _screens[_selectedIndex],
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              _selectedIndex == 0 ? Icons.home : Icons.home_outlined,
              size: 30,
            ),
            backgroundColor: Color.fromRGBO(23, 23, 23, 1),
            label: 'My Tasks',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              _selectedIndex == 0
                  ? Icons.calendar_today_outlined
                  : Icons.calendar_today_rounded,
              size: 30,
            ),
            label: 'Suscriptions',
          ),
        ],
        type: BottomNavigationBarType.shifting,
        currentIndex: _selectedIndex,
        selectedItemColor: kWhite,
        iconSize: 40,
        onTap: _onItemTapped,
        elevation: 5,
      ),
    );
  }
}
