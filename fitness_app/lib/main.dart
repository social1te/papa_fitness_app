import 'package:fitness_app/src/app.dart';
import 'package:fitness_app/src/screens/main_screens/account_screen.dart';
import 'package:fitness_app/src/screens/main_screens/gym_screen.dart';
import 'package:fitness_app/src/screens/main_screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

void main() {
  runApp(App());
}

class Main extends StatefulWidget {
  const Main({super.key});

  @override
  State<Main> createState() => _MainState();
}

class _MainState extends State<Main> {

  int _selectedIndex = 0;
  void _navigateBottomBar(int index){
    setState(() {
      _selectedIndex = index;
    });
  }

  final List<Widget> _screens = [
    HomeScreen(),
    GymScreen(),
    AccountScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: Container(
        color: Colors.white,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
          child: GNav(
            selectedIndex: _selectedIndex,
            onTabChange: _navigateBottomBar,
            backgroundColor: Colors.white,
            color: Colors.blueAccent.shade100,
            activeColor: Colors.white,
            padding: EdgeInsets.all(16),
            gap: 8,
            tabBackgroundColor: Colors.blueAccent.shade100,
            tabs: [
              GButton(
                icon: Icons.home,
                text: 'Главная',
              ),
              GButton(
                icon: Icons.fitness_center,
                text: 'Клуб',
              ),
              GButton(
                icon: Icons.person,
                text: 'Аккаунт',
              ),
            ],
          ),
        ),
      ),
    );
  }
}

