import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:untitled/screens/beratBadanScreen/BeratBadanScreen.dart';
import 'package:untitled/screens/loginScreen/LoginFixScreen.dart';
import 'package:untitled/screens/tekananDarahScreen/TekananDarahScreen.dart';

class FloatingDashboardCoba extends StatelessWidget {
  BuildContext context;
  FloatingDashboardCoba({super.key, required this.context});

  void goToBB() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const BeratBadanScreen()),
    );
  }

  void goToTD() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const TekananDarahScreen()),
    );
  }

  void logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
    await prefs.remove('email');
    await prefs.remove('kode_verif');
    await prefs.remove('idMobileUser');
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginFixScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        FloatingActionButton(
          onPressed: goToBB,
          child: const Icon(Icons.person),
          heroTag: 'beratBadanFAB',
        ),
        const SizedBox(height: 10),
        FloatingActionButton(
          onPressed: goToTD,
          child: const Icon(Icons.water),
          heroTag: 'tekananDarahFAB',
        ),
        const SizedBox(height: 10),
        FloatingActionButton(
          onPressed: logout,
          child: const Icon(Icons.logout),
          heroTag: 'logoutFAB',
        ),
      ],
    );
  }
}
