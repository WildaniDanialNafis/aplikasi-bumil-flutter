import 'package:flutter/material.dart';
import 'package:untitled/components/choiceFeatures/ChoiceFeatures.dart';
import 'package:untitled/screens/dashboardScreen/DashboardScreen.dart';
import 'package:untitled/screens/profileScreen/ProfileScreen.dart';

class CustomNavigationBar extends StatefulWidget {
  @override
  _CustomNavigationBarState createState() => _CustomNavigationBarState();
}

class _CustomNavigationBarState extends State<CustomNavigationBar> {
  int _selectedIndex = 0;

  static List<Widget> _widgetOptions = <Widget>[
    DashboardScreen(),
    ChoiceFieturesScreen(),
    ProfileScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.pink[900]!, Colors.pink[400]!],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          selectedItemColor: Colors.pink[800],
          unselectedItemColor: Colors.grey,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: _buildIcon(Icons.home, 0),
              label: 'Beranda',
            ),
            BottomNavigationBarItem(
              icon: _buildIcon(Icons.search, 1),
              label: 'Cari',
            ),
            BottomNavigationBarItem(
              icon: _buildIcon(Icons.account_circle, 2),
              label: 'Profil',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildIcon(IconData icon, int index) {
    bool isSelected = _selectedIndex == index;

    if (isSelected) {
      return ShaderMask(
        shaderCallback: (bounds) => LinearGradient(
          colors: [Colors.pink[900]!, Colors.pink[400]!],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ).createShader(bounds),
        child: Icon(
          icon,
          color: Colors.white,
        ),
      );
    } else {
      return Icon(
        icon,
        color: Colors.grey,
      );
    }
  }
}