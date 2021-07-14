import 'package:event_manager/globals/myColors.dart';
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
      body: Stack(
        children: [
          DrawerScreen(),
          _screens[_selectedIndex],
        ],
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
