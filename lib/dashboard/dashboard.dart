import 'package:animate_gradient/animate_gradient.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire_ui/auth.dart';
import 'package:tuneyourmindtym/shared/TYMColors.dart';

import '../features/alarms/TYMAlarms.dart';
import '../features/home/TYMHome.dart';
import '../features/profile/TYMProfile.dart';

class TYMDashboard extends StatefulWidget {
  const TYMDashboard({Key? key}) : super(key: key);

  @override
  State<TYMDashboard> createState() => _TYMDashboardState();
}

class _TYMDashboardState extends State<TYMDashboard> {
  int _currentIndex=0;
  final screens = [
    TYMHome(),
    TYMAlarms(),
    TYMProfile()
  ];

  @override
  void initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15),
            topRight: Radius.circular(15),
          ),
          child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            currentIndex: _currentIndex,
            selectedItemColor: Palette.kToDark.shade800,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            iconSize: 30,
            elevation: 0,
            unselectedItemColor: Palette.kToDark.shade600,
            onTap: (value){
              setState(() {
                _currentIndex=value;
              });
            },
            items: [
              BottomNavigationBarItem(
                icon: ImageIcon(
                  AssetImage("assets/tymmenuicon.png"),
                ),
                label: '',
              ),
              BottomNavigationBarItem(
                  icon: ImageIcon(
                    AssetImage("assets/alarmicon.png"),
                  ),
                  label: 'Alarms'
              ),
              BottomNavigationBarItem(
                  icon: ImageIcon(
                    AssetImage("assets/floatperson.png"),
                  ),
                  label: 'Profile'
              ),
            ],

          ),
        ),
      body: IndexedStack(
        index: _currentIndex,
        children: screens,
        sizing: StackFit.loose,
      )
    );
  }
}
