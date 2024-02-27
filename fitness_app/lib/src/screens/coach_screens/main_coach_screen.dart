import 'package:fitness_app/src/screens/coach_screens/coach_personal_trainings_screen.dart';
import 'package:fitness_app/src/screens/coach_screens/coach_trainings_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

import 'coach_schedule_screen.dart';

class CoachMain extends StatefulWidget {
  const CoachMain({super.key});

  @override
  State<CoachMain> createState() => _CoachMainState();
}

class _CoachMainState extends State<CoachMain> {

  int _selectedIndex = 0;
  void _navigateBottomBar(int index){
    setState(() {
      _selectedIndex = index;
    });
  }

  final List<Widget> _screens = [
    CoachPersonalTrainings(),
    CoachTrainingsScreen(),
    CoachScheduleScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: Container(
        color: Colors.grey.shade100,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
          child: GNav(
            selectedIndex: _selectedIndex,
            onTabChange: _navigateBottomBar,
            backgroundColor: Colors.grey.shade100,
            color: Colors.blueAccent.shade100,
            activeColor: Colors.white,
            padding: EdgeInsets.all(16),
            gap: 8,
            tabBackgroundColor: Colors.blueAccent.shade100,
            textStyle: TextStyle(color: Colors.white),
            tabs: [
              GButton(
                icon: Icons.person,
                text: 'Персональные',
              ),
              GButton(
                icon: Icons.group,
                text: 'Групповые',
              ),
              GButton(
                  icon: Icons.schedule,
                  text: 'Расписание',)
            ],
          ),
        ),
      ),
    );
  }
}

